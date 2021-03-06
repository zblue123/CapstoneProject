function plotAngledCube(origin, X, Y, Z, theta) 
thetaRad = pi * theta / 180; 
% CUBE_PLOT plots a cube with dimension of X, Y, Z.
%
% INPUTS:
% origin = set origin point for the cube in the form of [x,y,z].
% X      = cube length along x direction.
% Y      = cube length along y direction.
% Z      = cube length along z direction.
% color  = STRING, the color patched for the cube.
%         List of colors
%         b blue
%         g green
%         r red
%         c cyan
%         m magenta
%         y yellow
%         k black
%         w white
% OUPUTS:
% Plot a figure in the form of cubics.
%
% EXAMPLES
% cube_plot(2,3,4,'red')
%
% ------------------------------Code Starts Here------------------------------ %
% Define the vertexes of the unit cubic
ver = [X/2 Y/2 -Z/2;
    -X/2 Y/2 -Z/2;
    -X/2 Y/2 Z/2;
    X/2 Y/2 Z/2;
    -X/2 -Y/2 Z/2;
    X/2 -Y/2 Z/2;
    X/2 -Y/2 -Z/2;
    -X/2 -Y/2 -Z/2];

rotMatrx = [cos(thetaRad) sin(thetaRad) 0; 
    -1*sin(thetaRad) cos(thetaRad) 0; 
    0 0 1]; 

for i=1:8
    ver(i,:) = ver(i,:) * rotMatrx;
end

ver(:,1) = ver(:,1)+origin(1)+X/2; 
ver(:,2) = ver(:,2)+origin(2)+Y/2;
ver(:,3) = ver(:,3)+origin(3)+Z/2;


%  Define the faces of the unit cubic
fac = [1 2 3 4;
    4 3 5 6;
    6 7 8 5;
    1 2 8 7;
    6 7 1 4;
    2 3 5 8];
cube = [ver(:,1),ver(:,2),ver(:,3)];
patch('Faces',fac,'Vertices',cube,'FaceColor','b');
end
% ------------------------------Code Ends Here-------------------------------- %
