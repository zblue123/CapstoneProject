function [target_x, target_y] = targetSim(time,interval)
len = round(time/interval,0) + 1;
target_x = zeros(len,1);
target_y = zeros(len,1); 

vel_x = 10/time; 
%vel_y = (y_max - y_min) / length(x); 
%dist = sqrt((y_min-y_max)^2+(x_min-x_max)^2)
%vel = dist / length(x)

for i=1:len
    target_x(i) = vel_x * (i-1);
    %target_y(i) = vel_y * i; 
end 

end 
    