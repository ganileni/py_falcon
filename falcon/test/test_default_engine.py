from unittest import TestCase
import numpy as np

FALCON_DIR = '../'
test_matrix = np.loadtxt(FALCON_DIR + 'test.csv', delimiter=',')


class TestDefaultEngine(TestCase):
    """Test whether the module variable `default_engine` works correctly"""

    def test_working(self):
        import falcon
        from falcon import nested_test
        # engine should be off for starters
        self.assertFalse(falcon.default_engine.is_started)
        result = nested_test(test_matrix)
        # engine should now be on
        self.assertTrue(falcon.default_engine.is_started)
        falcon.default_engine.shutdown_engine()
        # engine should be off again
        self.assertFalse(falcon.default_engine.is_started)
