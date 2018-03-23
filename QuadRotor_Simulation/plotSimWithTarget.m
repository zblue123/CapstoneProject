function plotSimWithTarget(t,x_sim,y_sim,z_sim,phi_sim,theta_sim,psi_sim,off_sim, target_x, target_y)

dt = t(2) - t(1);

x_min = min(x_sim);
y_min = min(y_sim);
xy_min = min(min(x_min,y_min),-4);
z_min = min(z_sim);

x_max = max(x_sim);
y_max = max(y_sim);
xy_max = max(max(x_max,y_max),4);
z_max = max(z_sim);
length(t)
length(target_y)
target_dY = target_y(length(t)-1) - target_y(1); 
target_dX = target_x(length(t)-1) - target_x(1); 
theta = atan(target_dY - target_dX) * 180 / pi; 


for i = 1:3:length(t)
    plotQuadrotor(x_sim(i),y_sim(i),z_sim(i),phi_sim(i),theta_sim(i),psi_sim(i),5,t(i),off_sim(i));
    plotTarget(target_x(i), target_y(i), theta); 
    grid on;
    mytitle = sprintf('Time = %0.2f', t(i));
    title(mytitle);
    
    axis([xy_min-1, xy_max+1, xy_min-1, xy_max+1, z_min-1, z_max+1]);
    pause(dt/4);0
    
    if i ~= length(t)
        clf;
    end
end

end