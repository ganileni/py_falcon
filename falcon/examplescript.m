% examplescript.m
% Part of the FALCON (Framework of Adaptive ensembLes for the Comparison Of
% Nestedness) package: https://github.com/sjbeckett/FALCON
% Last updated: 15th April 2014


%% TEST SCRIPTS

%% TEST 1 - GENERATE A MATRIX AND TEST SIGNIFICANCE OF NODF SCORE AGAINST THE EQUIPROBABLE-EQUIPROBABLE NULL MODEL USING ADAPTIVE SOLVER
MATRIX = (rand(4,6)>0.45).*1;

store = PERFORM_NESTED_TEST(MATRIX,1,1,{'NODF'},1,[],1);
%Arguments
%1: name of matrix want to test
%2: specifies whether the nature of the measure is binary (1) quantitative (0) or both ((2) the case of spectral radius for example).
%3: specifies whether to sort the matrix for maximal packaging (1) or not (0). Is
%applied both to input and null matrices, but only makes a difference to
%NODF, DISCREPANCY and MANHATTAN DISTANCE scores and tests.
%4: specifies function name of measure(s) to perform. It is important that this argument is enclosed by braces {}. See folder MEASURES for complete list, or add your own!
%5: specifies which null tests to run. [] performs all that can be done based on whether the test is binary/quantitative.
% Binary null tests are positively numbered e.g.(1,2,3), whilst quantitative null tests are negatively numbered e.g. (-1,-2,-3).
% To run binary null tests 1 and 3 for example you should use the argument [1 3]
%6: To use the adaptive method this should be set as [], else the fixed solver is invoked which performs the set number of nulls
% in its ensemble e.g. if argument was 50, 50 null models would be performed.
%7: Determines whether a plot should be displayed to the user about how the test measurement compares to those found in the null
% ensemble. 1 indicates the plot should be made, 0 indicates it should not.

%Show the degree sorted nested configuration
store.NestedConfig.DegreeMatrix
%Show number of samples used by the solver in the significance test for
%this null model
store.Bin_t1.EnsembleSize
%Show the output statistics from the null model analysis
store.Bin_t1.measures{1}


%% TEST 2 - LOAD A MATRIX AND FIND SIGNIFICANCE OF SPECTRAL RADIUS AGAINST ALL POSSIBLE NULL MODELS

%loads data from test.xls stored in sheet 1 and assigns it to LOADEDMAT
LOADEDMAT= dlmread('test.csv')

%Performs significance tests for the Spectral Radius measure against all
%binary null models (where the input matrix is converted to binary form)
%and all quantitative null models (where the quantitative values in the
%input matrix are used).
ind=PERFORM_NESTED_TEST(LOADEDMAT,2,1,{'SPECTRAL_RADIUS'},[],[],1);

%display outputs
ind


%% TEST 3 - FIND THE NESTEDNESS PROPERTIES OF A MATRIX WITH ZERO ROWS ACCORDING TO MANHATTAN DISTANCE AND NODF USING NULL MODELS 1 AND 2 EACH USING 1000 RANDOMISED MATRICES IN THE FIXED SOLVER

%Several things to note:
%1. Zero rows will be removed - look at differences between the input
%matrix (TEST3matrix / test3.Matrix) and the matrix analysed (test3.Matrix(test3.index_rows,test3.index_cols) ).
%2. Although there is a threshold argument, the existence of
%the ensmebleNum argument overules this and calls the fixed solver
%3. Null model 2 (FF) creates poor statistics for the Manhattan distance- this is due to the
%Manhattan distance being equivalent in all null model instantiations as
%well as the input matrix as row and column element sums do not change under
%this null models constraints.


TEST3matrix=rand(4,7)>0.45; %create random matrix of zeros and ones
TEST3matrix(5,:)=zeros(1,7); %adds a row of zeros to it



test3=PERFORM_NESTED_TEST(TEST3matrix,1,1,{'MANHATTAN_DISTANCE','NODF'},[1,2],1000,1)


