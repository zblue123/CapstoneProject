function [quad_result,time,x_final] = findAcceleration3(drone_x0, drone_v0, target_x0, target_v0, x_max, time_step) 
dX = drone_x0 - target_x0; 
dV = drone_v0 - target_v0;

disp(dV);

%% to use acceleration - just put into gray box 
%% do the position changing graph in Sydney's model



time_step = 0.01; 

% constraint: sqrt positive
% positions are the same 

% EXISTING VELOCITY: PDOT COMING OUT OF THE RHS OF MODEL 
% decision vector: [xf a t] 
    function obj = fun(x) 
        x_ts =  drone_x0 + drone_v0 * time_step + 0.5 * x * time_step ^ 2;
        obj = abs(x_ts - (target_x0 + target_v0 * time_step)); 
        if abs(dX) < 1
            obj = obj + abs(1/dX * (target_v0 - (drone_v0 + x * obj)));
        elseif abs(dX) ~= 0
            obj = abs(target_v0 - (drone_v0 + x * time_step));
        end
       
    end

    %xf a t
    function [c,ceq] = mycon(x)
        x_ts =  drone_x0 + drone_v0 * time_step + 0.5 * x * time_step ^ 2;
        ceq = 0;
        c = [2*x*dX - (dV)^2; 
            %-drone_x0 - drone_v0*t - 0.5*a*t*t;
            %-abs(dX) + abs(x_ts - (target_x0 + target_v0*time_step))
            %-x_f;
            -x_ts];
            %-t];
            %-drone_x0 - drone_v0 * time_step - 0.5 * a * time_step ^ 2];
    end


g = 9.8; 

ub = g; 
lb = -g; 

t_guess = 2; 
a_guess = 0;%2 / t_guess^2 * (dX - t_guess * dV);
%x_guess = target_x0 + target_v0 * t_guess; 

quad_result = fmincon(@fun,a_guess,[],[],[],[],lb,ub,@mycon);

% need to establish logic for an impossible/illogical result 
% x_final = x_initial + v_initial * time_step + 0.5 * accelartion *
% time_step ^ 2
time = (-dV + sqrt(abs((dV)^2 - 2*quad_result*dX)))/quad_result;

x_final = drone_x0 + drone_v0 * time_step + 0.5 * quad_result * (time_step ^ 2); 
end
