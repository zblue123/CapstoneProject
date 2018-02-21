function quad_a = findAcceleration(drone_x0, drone_v0, target_x0, target_v0, x_max) 
dX = drone_x0 - target_x0; 
dV = drone_v0 - target_v0;

% constraint: sqrt positive
% positions are the same 

% decision vector: [xf a] 
    function obj = fun(x) 
        %xf = x(1);
        a = x(2); 
        deltaX = dX;
        deltaV = dV;
        t = (-deltaV + sqrt((deltaV)^2 - 2*a*deltaX))/a;
        obj = t + abs(1/dX * ((drone_v0 - dV * sqrt(dV^2 - 2*a*dX) - target_v0)));
    end

    function [c,ceq] = mycon(x)
        ceq = 0;
        a = x(2); 
        c = 2*a*dX - (dV)^2;
    end


g = 9.8; 

ub = [x_max, 3*g]; 
lb = [0, -3*g]; 

quad_result = fmincon(@fun,[1,1],[],[],[],[],lb,ub,@mycon);

quad_a = quad_result(2); 

end
