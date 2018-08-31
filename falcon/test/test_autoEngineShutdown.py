from unittest import TestCase
import numpy as np

# TODO -- generalize to a MATLAB function that is not FALCON
FALCON_DIR = '../'
test_matrix = np.loadtxt(FALCON_DIR + 'test.csv', delimiter=',')


class TestAutoEngineShutdown(TestCase):
    def test_working(self):
        import falcon
        # default engine should be off
        self.assertFalse(falcon.default_engine.is_started)
        from falcon import AutoEngineShutdown, nested_test
        with AutoEngineShutdown():
            # should still be off
            self.assertFalse(falcon.default_engine.is_started)
            result = nested_test(test_matrix)
            # call should have turned engine on
            self.assertTrue(falcon.default_engine.is_started)
        # __exit__ should have turned engine off
        self.assertFalse(falcon.default_engine.is_started)

    def test_noconflict(self):
        """See if the manual working mode creates conflicts."""
        import falcon
        # default engine should be off
        self.assertFalse(falcon.default_engine.is_started)
        from falcon import AutoEngineShutdown, nested_test
        result = nested_test(test_matrix)
        # engine should be on
        self.assertTrue(falcon.default_engine.is_started)
        falcon.default_engine.shutdown_engine()
        # engine should be off again
        self.assertFalse(falcon.default_engine.is_started)
        with AutoEngineShutdown():
            # should still be off
            self.assertFalse(falcon.default_engine.is_started)
            result = nested_test(test_matrix)
            # call should have turned engine on
            self.assertTrue(falcon.default_engine.is_started)
        # __exit__ should have turned engine off
        self.assertFalse(falcon.default_engine.is_started)
