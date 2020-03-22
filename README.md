# rainflow-counting
 rm algorithm & its matlab code are provided

reference: @MATLAB help center

Algorithm introduction:
 rainflow counting estimates the number of load change cycles as a function of cycle amplitude.

 Initially, rainflow turns the load history into a sequence of reversals. Reversals are the local minima and maxima where the load changes sign. The function counts cycles by considering a moving reference point of the sequence, Z, and a moving ordered three-point subset with these characteristics:

    1.The first and second points are collectively called Y.

    2.The second and third points are collectively called X.

    3.In both X and Y, the points are sorted from earlier to later in time, but are not necessarily consecutive in the reversal sequence.

    4.The range of X, denoted by r(X), is the absolute value of the difference between the amplitude of the first point and the amplitude of the second point. The definition of r(Y) is analogous.

Project introduction:
    The rainflow algorithm flowchart included in algorithm_flowchart.png, efforts made by myself to realize the function following the  algorithm mentioned above provided by @MATLAB.
    Code is presented in rainflow_counting.m, this function load a series of raw data and output the start point, end point, amplitude, mean-value, and cycle number for each loop.