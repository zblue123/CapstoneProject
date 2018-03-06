function [quad_a,time,x_final] = findAcceleration(drone_x0, drone_v0, target_x0, target_v0, x_max, time_step) 
dX = drone_x0 - target_x0; 
dV = drone_v0 - target_v0;

% constraint: sqrt positive
% positions are the same 

% decision vector: [xf a t] 
    function obj = fun(x) 
        t = x(3); 
        a = x(2);
        xf = x(1);
        obj = t;
        if dX ~= 0
            obj = obj + abs(0.01/dX * (target_v0 - (drone_v0 + a * t)));
        end
        
        
        
        
        %xf = x(1);
%         a = x(2); 
%         deltaX = dX;
%         if dX == 0 
%             obj = abs((drone_v0 - dV * sqrt(dV^2 - 2*a*dX) - target_v0));
%         else
%             if a == 0
%                 a = 0.01;
%             end
%             deltaV = dV;
%             t = (-deltaV + sqrt((deltaV)^2 - 2*a*deltaX))/a;
%             if t < 0
%                 t = (-deltaV + sqrt((deltaV)^2 - 2*a*deltaX))/a;
%             end
%             obj = t ;%+ abs(1/dX * ((drone_v0 - dV * sqrt(dV^2 - 2*a*dX) - target_v0)));
%         end
        
    end

    %xf a t
    function [c,ceq] = mycon(x)
        t = x(3);
        a = x(2); 
        ceq = target_x0 + target_v0*t - drone_x0 - drone_v0*t - 0.5*a*t*t;
        c = [2*a*dX - (dV)^2; drone_x0 + drone_v0*t + 0.5*a*t*t];
    end


g = 9.8; 

ub = [x_max, 3*g, 60]; 
lb = [0, -3*g, 0]; 
a_guess = dV; 
x_guess = target_x0 + target_v0 * 4; 
[quad_result, time] = fmincon(@fun,[x_guess,100,4],[],[],[],[],lb,ub,@mycon);

% need to establish logic for an impossible/illogical result 
% x_final = x_initial + v_initial * time_step + 0.5 * accelartion *
% time_step ^ 2

quad_a = quad_result(2); 

x_final = drone_x0 + drone_v0 * time_step + 0.5 * quad_a * time_step ^ 2; 

end
