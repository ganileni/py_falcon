from unittest import TestCase
from falcon import TempWD
from os import getcwd
from os.path import abspath
import sys

class TestMatlabAPIInstalledCorrectly(TestCase):
    """test whether TempWD works as intended"""

    def test_correctDirectory(self):
        """we will test that TempWD changes the cwd only during execution of its code block."""
        # the only alternative directory that we know to exists for sure is the parent, so:
        alternate_dir = abspath('../')
        # get current dir
        current_dir = getcwd()
        with TempWD(alternate_dir):
            # should have switched to alternate dir
            self.assertEqual(alternate_dir,getcwd())
        # should now be back to current dir
        self.assertEqual(current_dir, getcwd())

        # it should not switch the directory if __enter__ is not called:
        wd_manager = TempWD(alternate_dir)
        self.assertEqual(current_dir, getcwd())
        # and it should switch if __enter__ is called manually:
        wd_manager.__enter__()
        self.assertEqual(alternate_dir, getcwd())
        # finally go back to current dir on __exit__ call:
        # (exit needs to be called with 3 arguments: exc, value, tb
        wd_manager.__exit__(*sys.exc_info())
        self.assertEqual(current_dir, getcwd())