function plotTarget(x, y, theta)
% TODO: bounce target off walls, angle it in direction, randomize it
% currently depends on drone trajectory to define the region in which it is
% flying 
    function h = plotCircle(i,j,r)
        C = [i,j,1.05] ;   % center of circle
        R = r ;    % Radius of circle
        teta=0:0.01:2*pi ;
        x_t=C(1)+R*cos(teta);
        y_t=C(2)+R*sin(teta) ;
        z_t = C(3)+zeros(size(x_t)) ;
        patch(x_t,y_t,z_t,'k')
        hold on
        plot3(C(1),C(2),C(3),'b')
    end
            

% plot the red X 
xq1 = [-1.5,1.5];
yq1 = ones(1,length(xq1));
zq = ones(1,length(xq1));
xh1 = xq1; 
yh1 = yq1; 
xq2 = ones(1,length(xq1));
yq2 = [-1.5,1.5];
xh2 = xq2; 
yh2 = yq2; 
thetaRad = pi * theta / 180; 
for i=1:length(xq1)
    xh1(i) = xq1(i) * cos(thetaRad) - yq1(i) * sin(thetaRad) + x; 
    yh1(i) = xq1(i) * sin(thetaRad) + yq1(i) * cos(thetaRad) + y; 
    xh2(i) = xq2(i) * cos(thetaRad) - yq2(i) * sin(thetaRad) + x; 
    yh2(i) = xq2(i) * sin(thetaRad) + yq2(i) * cos(thetaRad) + y; 
end
    
target1 = [xh1; yh1; zq];%[xh1;yh1;zq];
target2 = [xh2; yh2; zq];%[xh2;yh2;zq];

%plotCircle(x*cos(thetaRad) - y * sin(thetaRad), y * cos(thetaRad) + x * sin(thetaRad),1.5); 
plotCircle(x,y,1.5);
% height of truck is 1
P = [x,y,0.5] ;   % your center point 
L = [3,4,1] ;  % your cube dimensions 
O = P-L/2 ;       % Get the origin of cube so that P is at center 
%plotcube(L,O,.8,[1 0 0]);   % use function plotcube 

%plotAngledCube(x,y,0,3,4,1,45); 
plotAngledCube(O,3,4,1,theta); 
hold on
%plot3(P(1),P(2),P(3),'Color', 'b');

plot3(target1(1,:),target1(2,:),target1(3,:),'LineWidth',2,'Color','r');
hold on;
plot3(target2(1,:),target2(2,:),target2(3,:),'LineWidth',2,'Color','r');

end