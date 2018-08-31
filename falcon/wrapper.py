import matlab
import matlab.engine
import os
from functools import wraps

# this is the path where this file is, and the matlab source code is expected to be in the same directory
dir_path = os.path.dirname(os.path.realpath(__file__))


class TempWD():
    """Context manager to temporarily switch cwd to `dir_path`"""

    def __init__(self, dir_path):
        self.cwd = os.getcwd()
        self.dir_path = dir_path
        os.chdir(self.dir_path)

    def __enter__(self):
        return None

    def __exit__(self, type, value, traceback):
        os.chdir(self.cwd)


def _start_matlab():
    """Starts matlab. It uses TempWD to temporarily switch cwd to the path where the matlab source files are,
    so that the path gets added to matlab PATH at startup and the sources are found by the engine. """
    # when you start matlab, cwd should be the dir where the matlab files are!
    with TempWD(dir_path) as wd_manager:
        eng = matlab.engine.start_matlab()
    return eng


class EngineWrapper():
    """Wraps a matlab.engine() instance to do lazy loading"""

    def __init__(self):
        self.eng = None
        self.is_started = False

    def __getattr__(self, item):
        if item == 'is_started':
            return self.is_started
        if self.is_started is False:
            self.eng = _start_matlab()
            self.is_started = True
        return getattr(self.eng, item)

    def __del__(self):
        if self.is_started:
            self.quit()


_engine = EngineWrapper()


def quit_matlab():
    """Stops the global lazy-loaded engine"""
    global _engine
    _engine.quit()


def lazy_load_engine(func):
    """Decorator that adds lazy loading of the engine to MATLAB wrapper functions.
    The wrappers must use the `eng` keyword argument as a matlab.engine object."""

    @wraps(func)  # to preserve signature
    def wrapper(*args, **kwargs):
        global _engine
        kwargs['eng'] = _engine
        return func(*args, **kwargs)

    return wrapper


