import matlab
import matlab.engine
import os
from functools import wraps

# this is the path where this file is, and the matlab source code is expected to be in the same directory
dir_path = os.path.dirname(os.path.realpath(__file__))


class TempWD():
    """Context manager to temporarily switch cwd to `dir_path`"""

    def __init__(self, dir_path):
        pass

    def __enter__(self):
        self.cwd = os.getcwd()
        self.dir_path = dir_path
        os.chdir(self.dir_path)

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
        if item in self.__dir__():
            return getattr(self,item)
        else:
            if not self.is_started:
                self.eng = _start_matlab()
                self.is_started = True
            return getattr(self.eng, item)

    def shutdown_engine(self):
        if self.is_started:
            self.quit()
            self.is_started = False

    def __del__(self):
        if self.is_started:
            self.shutdown_engine()


default_engine = EngineWrapper()


def quit_matlab():
    """Stops the global lazy-loaded engine"""
    global default_engine
    default_engine.shutdown_engine()


def lazy_load_engine(func):
    """Decorator that adds lazy loading of the engine to MATLAB wrapper functions.
    The wrappers must use the `eng` keyword argument as a matlab.engine object."""

    @wraps(func)  # to preserve signature
    def wrapper(*args, **kwargs):
        global default_engine
        kwargs['eng'] = default_engine
        return func(*args, **kwargs)

    return wrapper


class AutoEngineShutdown():
    """Context manager to automatically close MATLAB engine on exit."""

    def __init__(self):
        pass

    def __enter__(self):
        global default_engine
        self.engine_wrapper = default_engine
        return default_engine

    def __exit__(self, type, value, traceback):
        self.engine_wrapper.shutdown_engine()
