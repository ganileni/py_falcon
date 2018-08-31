from unittest import TestCase
import numpy as np


class TestMatlabAPIInstalledCorrectly(TestCase):
    """test whether Matlab API is installed correctly"""

    def test_installed(self):
        import matlab
        eng = matlab.engine.start_matlab()
        self.assertTrue(np.isclose(float(1), eng.eval('1')))
        eng.quit()
