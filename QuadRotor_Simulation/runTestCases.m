x0_vec = 20:10:100;
vx_vec = [16,17];
t_ren_res = zeros(length(x0_vec),length(vx_vec));
t_land_res = zeros(length(x0_vec),length(vx_vec));
error_res = zeros(length(x0_vec),length(vx_vec));
vel_res = zeros(length(x0_vec),length(vx_vec));
force_res = zeros(length(x0_vec),length(vx_vec));
angle_res = zeros(length(x0_vec),length(vx_vec));
xland_res = zeros(length(x0_vec),length(vx_vec));
yland_res = zeros(length(x0_vec),length(vx_vec));

for i = 1:length(x0_vec)
    for j = 1:length(vx_vec)
    x0 = x0_vec(i);
    vx = vx_vec(j);
    s = sim('Quadrotor', 'StopTime', '140');
    [t_ren,t_land,error,vel,force,angle,x_land,y_land] = computeMetrics(s.t,s.x,s.y,s.z,s.phi,s.theta,s.psi,s.off,s.x_t,s.y_t,1,s.mode,s.xland,s.yland);
    t_ren_res(i,j) = t_ren;
    t_land_res(i,j) = t_land;
    error_res(i,j) = error;
    vel_res(i,j) = vel;
    force_res(i,j) = force;
    angle_res(i,j) = angle;
    xland_res(i,j) = x_land;
    yland_res(i,j) = y_land;
    j
    end
    i
end