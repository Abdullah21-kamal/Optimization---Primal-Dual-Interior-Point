function plotter(xs_vector, ss_vector, f_vector, n_iterations, method_type)
    if method_type == 1
        figure
        plot(xs_vector(1,:),xs_vector(2,:),'-*')
        ylim =0;
        xlim =0;
        xlabel('x1'); ylabel('x2')
        title('Central Path with fixed step size and centering parameter ')
        figure

        plot(xs_vector(1,:).*ss_vector(1,:),xs_vector(2,:).*ss_vector(2,:),'-*')
        xlabel('x1*s1'); ylabel('x2*s2')
        title('Fixed - Complementarity condition -')
        figure
        plot(0:1:n_iterations,-1 * f_vector,'-*')
        xlabel('iteration'); ylabel('objective function')
        
        title('Central Path with fixed step size and centering parameter')
    elseif method_type == 2
        figure
        plot(xs_vector(1,:),xs_vector(2,:),'-*')
        xlabel('x1'); ylabel('x2')
        title('Central Path with adaptive step size and centering parameter ')
        figure

        plot(xs_vector(1,:).*ss_vector(1,:),xs_vector(2,:).*ss_vector(2,:),'-*')
        xlabel('x1*s1'); ylabel('x2*s2')
        title('Adaptive- Complementarity condition')
        figure
        plot(0:1:n_iterations, -1 * f_vector,'-*')
        xlabel('iteration'); ylabel('objective function')
        title('Central Path with adaptive step size and centering parameter')
    elseif method_type == 3
        figure
        plot(xs_vector(1,:),xs_vector(2,:),'-*')
        xlabel('x1'); ylabel('x2')
        title('Mehrotra')
        figure

        plot(xs_vector(1,:).*ss_vector(1,:),xs_vector(2,:).*ss_vector(2,:),'-*')
        xlabel('x1*s1'); ylabel('x2*s2')
        title('Mehrotra - Complementarity condition')
        figure
        plot(0:1:n_iterations,-1 * f_vector,'-*')
        xlabel('iteration'); ylabel('objective function')
        title('Mehrotra')
    end
end