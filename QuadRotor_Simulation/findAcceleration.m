function [quad_a,time] = findAcceleration(drone_x0, drone_v0, target_x0, target_v0, x_max) 
dX = drone_x0 - target_x0; 
dV = drone_v0 - target_v0;



% constraint: sqrt positive
% positions are the same 

% decision vector: [xf a] 
    function obj = fun(x) 
        %xf = x(1);
        a = x(2); 
        deltaX = dX;
        if dX == 0 
            obj = abs((drone_v0 - dV * sqrt(dV^2 - 2*a*dX) - target_v0));
        else
            if a == 0
                a = 0.01;
            end
            deltaV = dV;
            t = (-deltaV - sqrt((deltaV)^2 - 2*a*deltaX))/a;
            if t < 0
                t = (-deltaV + sqrt((deltaV)^2 - 2*a*deltaX))/a;
            end
            obj = t + abs(10/dX * ((drone_v0 - dV * sqrt(dV^2 - 2*a*dX) - target_v0)));
        end
        
    end

    function [c,ceq] = mycon(x)
        ceq = 0;
        a = x(2); 
        c = 2*a*dX - (dV)^2;
    end


g = 9.8; 

ub = [x_max, 3*g]; 
lb = [0, -3*g]; 

[quad_result, time] = fmincon(@fun,[0,0],[],[],[],[],lb,ub,@mycon);

% need to establish logic for an impossible/illogical result 

quad_a = quad_result(2); 

end
