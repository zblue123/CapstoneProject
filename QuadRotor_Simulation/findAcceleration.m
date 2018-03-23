function [quad_a,time,x_final] = findAcceleration(drone_x0, drone_v0, target_x0, target_v0, x_max, time_step) 
dX = drone_x0 - target_x0; 
dV = drone_v0 - target_v0;

% constraint: sqrt positive
% positions are the same 

% EXISTING VELOCITY: PDOT COMING OUT OF THE RHS OF MODEL 
% decision vector: [xf a t] 
    function obj = fun(x) 
        t = x(3); 
        a = x(2);
        xf = x(1);
        obj = t; % + abs(xf - drone_x0);
        if abs(dX) > 0.1
            obj = obj + abs(1/dX * (target_v0 - (drone_v0 + a * t)));
        elseif abs(dX) ~= 0
            obj = obj - t + abs(1/dX * (target_v0 - (drone_v0 + a * t)));
        end
       
    end

    %xf a t
    function [c,ceq] = mycon(x)
        t = x(3);
        a = x(2); 
        xf = x(1);
        x_ts =  drone_x0 + drone_v0 * time_step + 0.5 * a * time_step ^ 2;
        ceq = [target_x0 + target_v0*t - drone_x0 - drone_v0*t - 0.5*a*t*t;
            target_x0 + target_v0*t - xf;
            t - (-dV + sqrt((dV)^2 - 2*a*dX))/a];
        c = [2*a*dX - (dV)^2; 
            -drone_x0 - drone_v0*t - 0.5*a*t*t;
            -abs(dX) + abs(x_ts - (target_x0 + target_v0*time_step))];
            %-drone_x0 - drone_v0 * time_step - 0.5 * a * time_step ^ 2];
    end


g = 9.8; 

ub = [x_max, g, 60]; 
lb = [0, -g, 0]; 

t_guess = 2; 
a_guess = 2 / t_guess^2 * (-1 * dX - t_guess * dV);
x_guess = target_x0 + target_v0 * t_guess; 

[quad_result, time] = fmincon(@fun,[x_guess,a_guess,t_guess],[],[],[],[],lb,ub,@mycon);

% need to establish logic for an impossible/illogical result 
% x_final = x_initial + v_initial * time_step + 0.5 * accelartion *
% time_step ^ 2

quad_a = quad_result(2); 

x_final = drone_x0 + drone_v0 * time_step + 0.5 * quad_a * time_step ^ 2; 

end
