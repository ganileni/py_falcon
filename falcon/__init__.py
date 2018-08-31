# import wrapper
from falcon.wrapper import *

import numpy as np

allowed_measures = ['DISCREPANCY', 'JDMnestedness', 'MANHATTAN_DISTANCE', 'NODF', 'NTC', 'SPECTRAL_RADIUS', 'WNODF']


@lazy_load_engine
def nested_test(matrix,
                bintest=1,
                sortVar=False,
                functhand=['NODF'],
                nullmodels=[],
                EnsembleNumber=[],
                plotON=0,
                eng=None):
    """Wrapper for FALCON's PERFORM_NESTED_TEST function (the main routine that allows all calculations). See `PERFORM_NESTED_TEST.m` docstrings and code for further info.
    Args:
        matrix: the matrix to test
        bintest: is the matrix binary (1) quantitative (0) or both ((2) the case of spectral radius for example).
        sortVar: specifies whether to sortVar the matrix for maximal packaging (1) or not (0). Is applied both to input and null matrices, but only makes a difference to NODF, DISCREPANCY and MANHATTAN DISTANCE scores and test.
        functhand:  specifies function name of measure(s) to perform. It is important that this argument is a list.
        nullmodels: pecifies which null test to run. [] performs all that can be done based on whether the test is binary/quantitative. Binary null test are positively numbered e.g.(1,2,3), whilst quantitative null test are negatively numbered e.g. (-1,-2,-3). To run binary null test 1 and 3 for example you should use the argument [1 3]
        EnsembleNumber: To use the adaptive method this should be set as [], else the fixed solver is invoked which performs the set number of nulls in its ensemble e.g. if argument was 50, 50 null models would be performed.
        plotON: Ignored. In MATLAB, determines whether a plot should be displayed to the user about how the test measurement compares to those found in the null ensemble. 1 indicates the plotON should be made, 0 indicates it should not.
        eng: MATLAB engine. Ignore if you're using module's global engine.
    """
    # matrices need to be fed as lists to the MATLAB fcn
    if not isinstance(matrix, list):
        matrix = np.asarray(matrix).tolist()
    for measure in functhand:
        if measure not in allowed_measures:
            raise ValueError('Error in functhand argument: {} is not a supported measure.'.format(measure))
    # convert to proper MATLAB type
    if bintest==1:
        # booleans if binary matrix
        matrix = matlab.logical(matrix)
    else:
        # doubles for quantitative matrix
        matrix = matlab.double(matrix)
    # nullmodels lists the null models to compute to calculate test significance.
    # PERFORM_NESTED_TEST only accepts a sorted MATLAB vector for this parameter.
    if isinstance(nullmodels, list):
        if not nullmodels:
            # correct way to initialize an empty vector
            nullmodels = eng.eval('[]')
        else:
            # convert to sorted double vector
            nullmodels = matlab.double(sorted(list(nullmodels)))
    if not EnsembleNumber:
        # here too we need to give an empty vector, the function won't accept EnsembleNumber===0
        EnsembleNumber = eng.eval('[]')
    # this needs to be converted to int
    sortVar = int(sortVar)
    # plotON is always 0, so we don't have to deal with MATLAB trying to access the graphical frontend
    # final note: MATLAB only takes positional arguments!
    result = eng.PERFORM_NESTED_TEST(matrix, bintest, sortVar, functhand, nullmodels, EnsembleNumber, 0)
    return result
