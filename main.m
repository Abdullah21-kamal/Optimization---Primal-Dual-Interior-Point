clc; clear;
disp('Matricies are in the standard shape of Min to the objective function')
disp('1- Constraints_Coeff_A = [1 1 1] Objective_Coeff_c = [-1.1; -1; 0] b = 6')
disp('2- Constraints_Coeff_A = [2,1,1,0;1,3,0,1] Objective_Coeff_c = [4;1;0;0] b = [8;8]')
disp('3- Constraints_Coeff_A = [3,1,0,0;4,3,-1,0;1,2,0,1] Objective_Coeff_c = [-30;-20;0;0] b = [3;6;4];')
example = input('Choose which example to work with: enter 1, 2 or 3: ');

if example == 1
    Constraints_Coeff_A = [1 1 1]; Objective_Coeff_c = [-1.1; -1; 0]; b = 6;
elseif example == 2
    Constraints_Coeff_A = [2,1,1,0;1,3,0,1]; Objective_Coeff_c = [-30;-20;0;0]; b = [8;8];
elseif example == 3
    
    Constraints_Coeff_A = [3,1,0,0;4,3,-1,0;1,2,0,1]; Objective_Coeff_c = [4;1;0;0]; b = [3;6;4];
end
[x,y,s] = starting_point(Constraints_Coeff_A,Objective_Coeff_c,b);
disp('We start with')
disp('x =')
disp(x)
disp('s =')
disp(s)
disp('Note that the most important parameters to start with are x and s to achieve the complementarity condition')
disp('y =')
disp(y)


method_type = input('Enter 1 for central_path_fixed, 2 for central path adaptive and 3 for mehrotra: ');
if method_type == 1
    [xs_vector_cp_fixed,ss_vector_cp_fixed,objective_function, n_iterations] = method(x,s,y,Constraints_Coeff_A,Objective_Coeff_c,b,1); 
    plotter(xs_vector_cp_fixed,ss_vector_cp_fixed,objective_function,n_iterations, 1)

elseif method_type == 2
    [xs_vector_cp_fixed,ss_vector_cp_fixed,objective_function, n_iterations] = method(x,s,y,Constraints_Coeff_A,Objective_Coeff_c,b,2); 
    plotter(xs_vector_cp_fixed,ss_vector_cp_fixed,objective_function,n_iterations, 2)
elseif method_type == 3
    [xs_vector_cp_fixed,ss_vector_cp_fixed,objective_function, n_iterations] = method(x,s,y,Constraints_Coeff_A,Objective_Coeff_c,b,3); 
    plotter(xs_vector_cp_fixed,ss_vector_cp_fixed,objective_function,n_iterations, 3)
     
end
%matlab_built-in function
options = optimoptions('linprog','Algorithm','interior-point','Display','iter');
[x,fval,exitflag,output] = linprog(Objective_Coeff_c,[],[],Constraints_Coeff_A,b,zeros(length(x),1),inf,options);