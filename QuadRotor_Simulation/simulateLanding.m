function [x,y,z,tx,ty,t,quad_acc] = simulateLanding
time = 5;
interval = 0.01;
[tx,ty,tdx,tdy] = targetSim(time, interval); 
t = 0:interval:time;

intervals = round(time / interval)+1;
%intervals = intervals + 1;

x = zeros(intervals,1); 

y = zeros(intervals,1); 
z = ones(intervals,1) * 10;

dx = zeros(intervals,1);
dy = zeros(intervals,1);
dz = zeros(intervals,1); 

quad_acc = zeros(intervals,2); 

for i=1:intervals-1
    %if i==1:
    
    [quad_ax,time_x,x_final] = findAcceleration(x(i),dx(i),tx(i),tdx,10000,0.01);
    %quad_ax
    [quad_ay,time_y,y_final] = findAcceleration(y(i),dy(i),ty(i),tdy,10000,0.01);
    x(i+1) = x_final;
    y(i+1) = y_final;
    quad_acc(i,1) = quad_ax;
    quad_acc(i,2) = quad_ay; 
    dx(i+1) = dx(i) + quad_ax * interval; 
    dy(i+1) = dy(i) + quad_ay * interval; 
    dz(i+1) = -1 * z(i) / max(time_x,time_y);
    z(i+1) = z(i) + dz(i) * interval;
    
end

figure
plot(t,x,t,tx)
title('X')
figure
plot(t,y,t,ty)
title('Y')

end