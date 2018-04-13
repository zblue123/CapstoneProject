function [t_ren,t_land,error_land,vel_land,force_land,angle_land] = computeMetrics(t,x,y,z,phi,theta,psi,off,x_t,y_t,z_t,mode)
 
tolerance = 0.1; % Considered to have "rendezvoused" when within this tolerance of target
dt = t(2) - t(1);
time_to_remain = 0.5;
 
max_idx = length(t);
 
x_error = x - x_t;
y_error = y - y_t;
z_error = z - z_t;
 
total_error = sqrt((x_error.^2)+(y_error.^2)+(z_error.^2));
 
within_tol = total_error < tolerance;
first_idx = find(within_tol,1);
 
dzdt = diff(z(:))/dt;
ddzdtdt = diff(dzdt)/dt; 
 
unstable = 1;
 
while unstable
    last_idx = first_idx + time_to_remain/dt;
    if last_idx > max_idx
        t_ren = inf;
        break;
    end
    indices = first_idx:last_idx;
    sum_min = length(indices) - 10;
    my_sum = sum(within_tol(indices));
    if my_sum > sum_min
        unstable = 0;
        t_ren = t(last_idx);
    else
        first_idx = first_idx + 1;
    end
end
 
%t_land = t(find(off==1,1));
t_land = t(find(mode==4,1));
t_ren = t(find(mode==3,1));
error_land = total_error(find(off==1,1));
 
vel_land = dzdt(find(mode==4,1)-1);
 
% Right now rendezvous mode does not kick in until 10s
t_ren = t_ren - 10;
t_land = t_land - 10;
 
theta_land = theta(find(mode==4,1)-1);
psi_land = psi(find(mode==4,1)-1);
phi_land = phi(find(mode==4,1)-1);
 
rot_mat = [cos(psi_land)*cos(theta_land), -sin(psi_land)*cos(phi_land)+cos(psi_land)*sin(theta_land)*sin(phi_land), sin(psi_land)*sin(phi_land)+cos(psi_land)*sin(theta_land)*cos(phi_land);
           sin(psi_land)*cos(theta_land), cos(psi_land)*cos(phi_land)+sin(psi_land)*sin(theta_land)*sin(phi_land), -cos(psi_land)*sin(phi_land)+sin(psi_land)*sin(theta_land)*cos(phi_land);
           -sin(theta_land),         cos(theta_land)*sin(phi_land),                             cos(theta_land)*cos(phi_land)                           ];
 
z_vector = [0,0,1]';
drone_vector = rot_mat * z_vector; 
cosAngle = dot(drone_vector,z_vector)/(norm(z_vector)*norm(drone_vector));
angle_land = acosd(cosAngle); 
 
mass = 25;
force_land = (abs(vel_land)/dt)*mass; %ddzdtdt(find(mode==4,1)-1) * mass;
end
