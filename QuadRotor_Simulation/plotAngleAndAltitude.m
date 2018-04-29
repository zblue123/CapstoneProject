function angle = plotAngleAndAltitude(t, z, phi, psi, theta)

angle = zeros(length(z),1);

for i=1:length(angle)
    psi_land = psi(i);
    phi_land = phi(i);
    theta_land = theta(i); 
    rot_mat = [cos(psi_land)*cos(theta_land), -sin(psi_land)*cos(phi_land)+cos(psi_land)*sin(theta_land)*sin(phi_land), sin(psi_land)*sin(phi_land)+cos(psi_land)*sin(theta_land)*cos(phi_land);
           sin(psi_land)*cos(theta_land), cos(psi_land)*cos(phi_land)+sin(psi_land)*sin(theta_land)*sin(phi_land), -cos(psi_land)*sin(phi_land)+sin(psi_land)*sin(theta_land)*cos(phi_land);
           -sin(theta_land),         cos(theta_land)*sin(phi_land),                             cos(theta_land)*cos(phi_land)                           ];
 
    z_vector = [0,0,1]';
    drone_vector = rot_mat * z_vector; 
    cosAngle = dot(drone_vector,z_vector)/(norm(z_vector)*norm(drone_vector));
    angle(i) = acosd(cosAngle);  
end

% figure 
% plot(t,z)
% hold on 
% plot(t,angle)
% title('Altitude and Angle of the Quadcopter');
% xlabel('Time (s)');
% ylabel('Altitude (m) and Angle (deg)');
% legend('Altitude','Angle');
% hold off

end 
