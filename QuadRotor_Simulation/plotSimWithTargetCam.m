function plotSimWithTargetCam(t,x_sim,y_sim,z_sim,phi_sim,theta_sim,psi_sim,off_sim,target_x,target_y)

dt = t(2) - t(1);

target_dY = target_y(length(t)) - target_y(1); 
target_dX = target_x(length(t)) - target_x(1); 
theta = atan(target_dY - target_dX) * 180 / pi;

xy_width = 75;
z_min = 0;
z_max = max(z_sim) + 1;

for i = 1:5:length(t)
    plotQuadrotor(x_sim(i),y_sim(i),z_sim(i),psi_sim(i),theta_sim(i),phi_sim(i),5,t(i),off_sim(i));
    plotTarget(target_x(i), target_y(i), theta); 
    grid on;
    mytitle = sprintf('Time = %0.2f', t(i));
    title(mytitle);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    
    x_min = target_x(i) - xy_width;
    x_max = target_x(i) + xy_width;
    
    y_min = target_y(i) - xy_width;
    y_max = target_y(i) + xy_width;
    
    view(0,0);
    
    axis([x_min, x_max, y_min, y_max, z_min, z_max]);
    pause(dt/4);
    
    if i < length(t)-5
        clf;
    end
end

end