function plotSim(t,x_sim,y_sim,z_sim,phi_sim,theta_sim,psi_sim,off_sim)

dt = t(2) - t(1);

x_min = min(x_sim);
y_min = min(y_sim);
xy_min = min(min(x_min,y_min),-4);
z_min = min(z_sim);

x_max = max(x_sim);
y_max = max(y_sim);
xy_max = max(max(x_max,y_max),4);
z_max = max(z_sim);


for i = 1:length(t)
    plotQuadrotor(x_sim(i),y_sim(i),z_sim(i),phi_sim(i),theta_sim(i),psi_sim(i),5,t(i),off_sim(i));
    grid on;
    mytitle = sprintf('Time = %0.2f', t(i));
    title(mytitle);
    
    axis([xy_min-1, xy_max+1, xy_min-1, xy_max+1, z_min-1, z_max+1]);
    pause(dt/4);
    
    if i ~= length(t)
        clf;
    end
end

end