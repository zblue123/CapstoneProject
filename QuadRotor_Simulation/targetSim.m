function [target_x, target_y] = targetSim(x,y)

y_min = min(y); 
y_max = max(y);
x_min = min(x);
x_max = max(x);

target_x = zeros(length(x),1);
target_y = zeros(length(x),1); 

vel_x = (x_max - x_min) / length(x); 
vel_y = (y_max - y_min) / length(x); 
%dist = sqrt((y_min-y_max)^2+(x_min-x_max)^2)
%vel = dist / length(x)

for i=1:length(x)
    target_x(i) = x_min + vel_x * (i-1);
    target_y(i) = y_min + vel_y * (i-1); 
end 

end 
    