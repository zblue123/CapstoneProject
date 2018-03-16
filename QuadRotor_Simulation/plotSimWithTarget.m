function plotSimWithTarget(t,x_sim,y_sim,z_sim,phi_sim,theta_sim,psi_sim,off_sim, target_x, target_y)

dt = t(2) - t(1);

x_min = min(x_sim);
y_min = min(y_sim);
xt_min = min(target_x);
yt_min = min(target_y);
xy_min = min(min(x_min,y_min),-4);
xyt_min = min(min(xt_min,yt_min),-4);
xy_min_total = min(xy_min,xyt_min);
z_min = min(z_sim);

x_max = max(x_sim);
y_max = max(y_sim);
xt_max = max(target_x);
yt_max = max(target_y);
xy_max = max(max(x_max,y_max),4);
xyt_max = max(max(xt_max,yt_max),4);
xy_max_total = max(xy_max,xyt_max);
z_max = max(z_sim);

target_dY = target_y(length(t)) - target_y(1); 
target_dX = target_x(length(t)) - target_x(1); 
theta = atan(target_dY - target_dX) * 180 / pi;


for i = 1:5:length(t)
    plotQuadrotor(x_sim(i),y_sim(i),z_sim(i),psi_sim(i),theta_sim(i),phi_sim(i),5,t(i),off_sim(i));
    plotTarget(target_x(i), target_y(i), theta); 
    grid on;
    mytitle = sprintf('Time = %0.2f', t(i));
    title(mytitle);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    
    view(0,0);
    
    axis([xy_min_total-1, xy_max_total+1, xy_min_total-1, xy_max_total+1, z_min-1, z_max+1]);
    pause(dt/4);
    
    if i < length(t)-5
        clf;
    end
end

end