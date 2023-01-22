# Optimization---Primal-Dual-Interior-Point
A Matlab implementation of the Central Path -fixed and adaptive step size- and Mehrotra algorithms


MATLAB implementations of the following Primal-Dual Interior Point Methods:
1. Central Path with fixed step size (α) and centering parameter (σ).
2. Central Path with adaptive step size (α) and centering parameter (σ).
3. Mehrotra Predictor-Corrector.
a. Applying the implementations on at three case studies 
b. Providing neat figures for each case study of the following:
  i. Objective function reduction versus iteration. 
  ii. Center path.
  iii. Complementary condition.
Comparing  results with MATLAB built-in function that uses Mehrotra algorithm.


Code files:
* Main file to manage the flow of the program by interacting with the user in the command window and call other functions in the correct order
* starting point is a function that takes the chosen problem to find a suitable point that the method can work use initially 
* method file which is a function that takes the user's input to choose the needed method to be used and the needed optimization probelm to solve with the chosen method 
* plotter file which is a fuction that take the returned outcome if the method to plot it and give 3 figures as asked
