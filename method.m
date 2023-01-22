function [ValuesOfX,ValuesOfS,obj_funct, NumberOfIterations] = method(x,s,y,A,c,b,type) 
[rows, columns] = size(A);
m = rows;
n = columns;
NumberOfIterations = 0;
ValuesOfX = x;
ValuesOfS = s;
c_transpose = c';
obj_funct = c_transpose*x;

%preparing the needed parameters for each method separately
% I am working with the values of segma and alpha that was choosen in the
% lecture, they are suitable
if type ==1  % for the fixed step size method
    Segma = 0.5;% the centering parameter
    Alpha = 0.9;
    Tolerance = 1.0000e-03;
elseif type == 2 % for the adaptive step size method
    Segma = 0.5; Alpha = 0.9;
    Tolerance = 1.0000e-03;
    AdaptiveAlpha = true;
    AdaptiveSegma = true;
    UpdateSegma = 0.5;
elseif type == 3 % for the mehrotra method
    % Etta value is prefrered to be 1 and it works with mw
    % but we can also approximate it to be 0.9 or something in this range
    % if it faces a probelm with the value 1
    Etta = 1;  Tolerance = 1.0000e-03;
end

Complementarity_condition = sum(x.*s);
while  Complementarity_condition >= Tolerance
    % preparing general parameters to be used within the probel
    
    %to create a square matrix X with the elements of vector x along its diagonal
    %the other elements of the matrix will be zeros
    X = diag(x);
    S = diag(s);
    jaccobian_matrix = [zeros(n) transpose(A) eye(n);A zeros(m,m) zeros(m,n);S zeros(n,m) X];
    rc = transpose(A)*y + s - c;
    rb = A*x - b;
    
    %working with specific method based on the user input
    if type == 1
        %For cenral method with fixed step size
        DualityMeasure = sum(x.*s)/n;
        %μ = xT*s/n
        Tau = Segma*DualityMeasure;
        %τ = σμ
        delta = jaccobian_matrix\[-1*rc; -1*rb ;-1*(x.*s)+Tau];
        x = x + Alpha*delta(1:n);
        y = y + Alpha*delta(n+1:n+m);
        s = s + Alpha*delta(n+m+1:end);
        %appending x, s and f and to the end of the array ValuesOfX, S and f  
        ValuesOfX = [ValuesOfX , x];
        ValuesOfS = [ValuesOfS,s];
        obj_funct = [obj_funct , c'*x];
        
    elseif type == 2
        %For cenral method with adaptive step size
        DualityMeasure = sum(x.*s)/n;
        %μ = xT*s/n
        Tau = Segma*DualityMeasure;
        %τ = σμ
        delta = jaccobian_matrix\[-1*rc; -1*rb ;-1*(x.*s)+Tau];
        %delta will bring the system to equilibrium
        %The delta vector is then calculated by solving linear equatiosw formed by multiplying the jacobian matrix and this right hand side vector
        
        DeltaX = delta(1:n);% DeltaX is a vector containing the first n elements of delta
        DeltaY = delta(n+1:n+m);%DeltaY is a vector containing the next m elements of delta
        DeltaS = delta(n+m+1:end);%DeltaS is a vector containing the remaining elements of delta
        %new α   
        if AdaptiveAlpha
            AlphaPri = min([1; min(-1*x(DeltaX<0)./DeltaX(DeltaX<0))]);
            AlphaDual = min([1; min(-1*s(DeltaS<0)./DeltaS(DeltaS<0))]);
            %new points to work with
            x = x + AlphaPri*delta(1:n);
            y = y + AlphaDual*delta(n+1:n+m);
            s = s + AlphaDual*delta(n+m+1:end);
        else
            x = x + Alpha*delta(1:n);
            y = y + Alpha*delta(n+1:n+m);
            s = s + Alpha*delta(n+m+1:end);
        end
            %new σ 
            if AdaptiveSegma
                Segma = Segma*UpdateSegma;
            end
            %appending x, s and f and to the end of the array ValuesOfX, S and f 
            ValuesOfX = [ValuesOfX , x];
            ValuesOfS = [ValuesOfS,s];
            obj_funct = [obj_funct , c'*x];
    else
        Mu = x'*s/n;
        DeltaAffine = jaccobian_matrix\[-1*rc; -1*rb ;-1*(x.*s)];
        DeltaX_affine = DeltaAffine(1:n);
        DeltaY_affine = DeltaAffine(n+1:n+m);
        DeltaS_affine = DeltaAffine(n+m+1:end);
        AlphaPri_affine = min([1; min(-1*x(DeltaX_affine<0)./DeltaX_affine(DeltaX_affine<0))]);
        AlphaDual_affine = min([1; min(-1*s(DeltaS_affine<0)./DeltaS_affine(DeltaS_affine<0))]);
        Mu_affine = sum((x + AlphaPri_affine*DeltaX_affine).*(s + AlphaDual_affine*DeltaS_affine))/n;
        
        % new σ 
        Segma = (Mu_affine / Mu)^3;
        % corrector step
        delta = jaccobian_matrix\[-1*rc; -1*rb ;-1*(x.*s) - (DeltaX_affine.*DeltaS_affine) + Segma*Mu];
        deltaX = delta(1:n);
        deltaY = delta(n+1:n+m);
        deltaS = delta(n+m+1:end);
        % corrector of α
        AlphaPri_k_max = min(-1*x(deltaX<0)./deltaX(deltaX<0));
        AlphaDual_k_max = min(-1*s(deltaS<0)./deltaS(deltaS<0));
        AlphaPri_k = min([1; Etta*AlphaPri_k_max]);
        AlphaDual_k = min([1; Etta*AlphaDual_k_max]);
        x = x + AlphaPri_k*deltaX;
        y = y + AlphaDual_k*deltaY;
        s = s + AlphaDual_k*deltaS;
        %appending x, s and f and to the end of the array ValuesOfX, S and f 
        ValuesOfX = [ValuesOfX , x];
        ValuesOfS = [ValuesOfS,s];
        obj_funct = [obj_funct , c'*x];
    end 
    Complementarity_condition = sum(x.*s);
    NumberOfIterations = NumberOfIterations+1;
end
end