function plotSim(t,x_sim,y_sim,z_sim,phi_sim,theta_sim,psi_sim)

dt = t(2) - t(1);

% x_min = min(x_sim);
% y_min = min(y_sim);
z_min = min(z_sim);

% x_max = max(x_sim);
% y_max = max(y_sim);
z_max = max(z_sim);


for i = 1:length(t)
    plotQuadrotor(x_sim(i),y_sim(i),z_sim(i),phi_sim(i),theta_sim(i),psi_sim(i),5,t(i));
    grid on;
    mytitle = sprintf('Time = %0.2f', t(i));
    title(mytitle);
    
    lowerlim = max(1,i-200);
    upperlim = min(length(t),i+200);
    
    x_min = min(x_sim(lowerlim:upperlim));
    y_min = min(y_sim(lowerlim:upperlim));

    x_max = max(x_sim(lowerlim:upperlim));
    y_max = max(y_sim(lowerlim:upperlim));
    
    axis([x_min-1, x_max+1, y_min-1, y_max+1, z_min-1, z_max+1]);
    pause(dt/4);
    
    if i ~= length(t)
        clf;
    end
end

end