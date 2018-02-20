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

    function plotCube(i,j,k,l,w,h,theta) 
        x_min = i - l/2; 
        x_max = i + 1/2; 
        y_min = j - w/2; 
        y_max = j + w/2; 
        z_min = k - h/2; 
        z_max = k + h/2; 
        p = zeros(8, 3); 
        
        p(1) = [x_min, y_min, z_min]; 
        p(2) = [x_min, y_min, z_max]; 
        p(3) = [x_min, y_max, z_min]; 
        p(4) = [x_min, y_max, z_max]; 
        p(5) = [x_max, y_min, z_min]; 
        p(6) = [x_max, y_min, z_max]; 
        p(7) = [x_max, y_max, z_min]; 
        p(8) = [x_max, y_max, z_max];
        
        rot_mat = [cos(theta), 0, sin(theta);
                   0,          1, 0;
                   -sin(theta),0, cos(theta)];
        for i=1:8 
            p(i) = p(i) * rot_mat; 
        end
        
        %patch
    end
            

% plot the red X 
xq1 = [x-1.5,x+1.5];
yq1 = ones(1,length(xq1)) * y;
zq = ones(1,length(xq1));
xh1 = xq1; 
yh1 = yq1; 
xq2 = ones(1,length(xq1)) * x;
yq2 = [y-1.5,y+1.5];
xh2 = xq2; 
yh2 = yq2; 
for i=1:length(xq1)
    xh1(i) = xq1(i) * cos(theta); %- yq1(i) * sin(theta); 
    yh1(i) = xq1(i) * sin(theta); %+ yq1(i) * cos(theta); 
    xh2(i) = xq2(i) * cos(theta+pi/4); %- yq2(i) * sin(theta); 
    yh2(i) = xq2(i) * sin(theta+pi/4); %+ yq2(i) * cos(theta); 
end
    
target1 = [xq1; yq1; zq];%[xh1;yh1;zq];
target2 = [xq2; yq2; zq];%[xh2;yh2;zq];

plotCircle(x,y,1.5); 

% height of truck is 1
P = [x,y,0.5] ;   % your center point 
L = [3,4,1] ;  % your cube dimensions 
O = P-L/2 ;       % Get the origin of cube so that P is at center 
plotcube(L,O,.8,[1 0 0]);   % use function plotcube 
hold on
plot3(P(1),P(2),P(3),'Color', 'b');

plot3(target1(1,:),target1(2,:),target1(3,:),'LineWidth',2,'Color','r');
hold on;
plot3(target2(1,:),target2(2,:),target2(3,:),'LineWidth',2,'Color','r');

end