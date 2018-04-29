kd_val = 0.71:0.01:0.74;
results = zeros(length(kd_val),6);

for i = 1:length(kd_val)
    kd_workspace = kd_val(i);
    s = sim('Quadrotor', 'StopTime', '140');
    [t_ren,t_land,error,vel,force,angle] = computeMetrics(s.t,s.x,s.y,s.z,s.phi,s.theta,s.psi,s.off,s.x_t,s.y_t,1,s.mode);
    results(i,1) = t_ren;
    results(i,2) = t_land;
    results(i,3) = error;
    results(i,4) = vel;
    results(i,5) = force;
    results(i,6) = angle;
    i
end