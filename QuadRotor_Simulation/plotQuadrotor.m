function plotQuadrotor(x,y,z,psi,theta,phi,w_rot,t,off)

% Quadrotor frame

%%%% Body %%%%%%%%%%%%%%%
% Arm 1
xq1 = [-0.75,0.75];
yq1 = zeros(1,length(xq1));
zq = zeros(1,length(xq1));
arm1q = [xq1;yq1;zq];
% Arm 2
xq2 = zeros(1,length(xq1));
yq2 = [-0.75,0.75];
arm2q = [xq2;yq2;zq];
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Prop Supports %%%%%%
sup_height = 0.2;
hal = max(xq1); % Half Arm Length
sup_frame = [0,0;0,0;0,sup_height];
sup_frontq = sup_frame + [hal,hal;0,0;0,0];
sup_backq = sup_frame + [-hal,-hal;0,0;0,0];
sup_rightq = sup_frame + [0,0;hal,hal;0,0];
sup_leftq = sup_frame + [0,0;-hal,-hal;0,0];
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Props %%%%%%%%%%%%%%
prop_half_length = 0.2;
prop1 = [-prop_half_length,prop_half_length;0,0;0,0];
prop2 = [0,0;-prop_half_length,prop_half_length;0,0];

if off
    theta_rot = 0;
else
    theta_rot = w_rot*t; 
end

prop1_frontq = rotProp(prop1,theta_rot) + [hal,hal;0,0;sup_height,sup_height];
prop2_frontq = rotProp(prop2,theta_rot) + [hal,hal;0,0;sup_height,sup_height];
prop1_backq = rotProp(prop1,theta_rot) + [-hal,-hal;0,0;sup_height,sup_height];
prop2_backq = rotProp(prop2,theta_rot) + [-hal,-hal;0,0;sup_height,sup_height];
prop1_rightq = rotProp(prop1,theta_rot) + [0,0;hal,hal;sup_height,sup_height];
prop2_rightq = rotProp(prop2,theta_rot) + [0,0;hal,hal;sup_height,sup_height];
prop1_leftq = rotProp(prop1,theta_rot) + [0,0;-hal,-hal;sup_height,sup_height];
prop2_leftq = rotProp(prop2,theta_rot) + [0,0;-hal,-hal;sup_height,sup_height];

% Home frame
% Transformation mat
rot_mat = [cos(psi)*cos(theta), -sin(psi)*cos(phi)+cos(psi)*sin(theta)*sin(phi), sin(psi)*sin(phi)+cos(psi)*sin(theta)*cos(phi);
           sin(psi)*cos(theta), cos(psi)*cos(phi)+sin(psi)*sin(theta)*sin(phi), -cos(psi)*sin(phi)+sin(psi)*sin(theta)*cos(phi);
           -sin(theta),         cos(theta)*sin(phi),                             cos(theta)*cos(phi)                           ];
Tq_h = [rot_mat(1,:),x;rot_mat(2,:),y;rot_mat(3,:),z;0,0,0,1];

arm1h = Tq_h*[arm1q;ones(1,size(arm1q,2))];
arm2h = Tq_h*[arm2q;ones(1,size(arm2q,2))];

sup_fronth = Tq_h*[sup_frontq;ones(1,size(sup_frontq,2))];
sup_backh = Tq_h*[sup_backq;ones(1,size(sup_backq,2))];
sup_righth = Tq_h*[sup_rightq;ones(1,size(sup_rightq,2))];
sup_lefth = Tq_h*[sup_leftq;ones(1,size(sup_leftq,2))];

prop1_fronth = Tq_h*[prop1_frontq;ones(1,size(prop1_frontq,2))];
prop2_fronth = Tq_h*[prop2_frontq;ones(1,size(prop2_frontq,2))];
prop1_backh = Tq_h*[prop1_backq;ones(1,size(prop1_backq,2))];
prop2_backh = Tq_h*[prop2_backq;ones(1,size(prop2_backq,2))];
prop1_righth = Tq_h*[prop1_rightq;ones(1,size(prop1_rightq,2))];
prop2_righth = Tq_h*[prop2_rightq;ones(1,size(prop2_rightq,2))];
prop1_lefth = Tq_h*[prop1_leftq;ones(1,size(prop1_leftq,2))];
prop2_lefth = Tq_h*[prop2_leftq;ones(1,size(prop2_leftq,2))];


plot3(arm1h(1,:),arm1h(2,:),arm1h(3,:),'LineWidth',2,'Color','g');
hold on;
plot3(arm2h(1,:),arm2h(2,:),arm2h(3,:),'LineWidth',2,'Color','g');
plot3(sup_fronth(1,:),sup_fronth(2,:),sup_fronth(3,:),'LineWidth',2,'Color','g');
plot3(sup_backh(1,:),sup_backh(2,:),sup_backh(3,:),'LineWidth',2,'Color','g');
plot3(sup_righth(1,:),sup_righth(2,:),sup_righth(3,:),'LineWidth',2,'Color','g');
plot3(sup_lefth(1,:),sup_lefth(2,:),sup_lefth(3,:),'LineWidth',2,'Color','g');

plot3(prop1_fronth(1,:),prop1_fronth(2,:),prop1_fronth(3,:),'LineWidth',2,'Color','r');
plot3(prop1_backh(1,:),prop1_backh(2,:),prop1_backh(3,:),'LineWidth',2,'Color','r');
plot3(prop1_righth(1,:),prop1_righth(2,:),prop1_righth(3,:),'LineWidth',2,'Color','r');
plot3(prop1_lefth(1,:),prop1_lefth(2,:),prop1_lefth(3,:),'LineWidth',2,'Color','r');

plot3(prop2_fronth(1,:),prop2_fronth(2,:),prop2_fronth(3,:),'LineWidth',2,'Color','r');
plot3(prop2_backh(1,:),prop2_backh(2,:),prop2_backh(3,:),'LineWidth',2,'Color','r');
plot3(prop2_righth(1,:),prop2_righth(2,:),prop2_righth(3,:),'LineWidth',2,'Color','r');
plot3(prop2_lefth(1,:),prop2_lefth(2,:),prop2_lefth(3,:),'LineWidth',2,'Color','r');

end