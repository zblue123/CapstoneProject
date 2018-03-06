function plotHouses 

% plot center node 
[x1,y1,z1] = sphere;
%[x2,y2,z2] = sphere2;
%[x3,y3,z3] = sphere3;
%[x4,y4,z4] = sphere4;

%acreage 0.3:4
%price: 1000:50,0000
%distance to metro stop: 0.1:6
anchors = zeros(8,3);
figure
for i=1:8
    %acreage
    newX = 2.5;
    if i > 4
        newX = 7.5;
    end
    
    newY = 2.5;
    if i==3 || i==4 || i==7 || i==8
        newY = 7.5;
    end
    
    newZ = 2.5;
    if i==2 || i==4 || i==6 || i==8
        newZ = 7.5;
    end
    r = 0.5;
    surf(x1*r+newX, y1*r+newY, z1*r+newZ);
    anchors(i,1) = newX; 
    anchors(i,2) = newY;
    anchors(i,3) = newZ; 
    hold on;
end
    
for i=1:20
    r = 0.3;
    randX = round(6 * rand())+0.5;
    randY = round(7 * rand())+0.5;
    randZ = round(10 * rand())+0.5;
    
    surf(x1*r+randX,y1*r+randY,z1*r+randZ);
    
    minNode = zeros(3,1);
    minVal = 99999;
    for i=1:8
        nodeX = anchors(i,1);
        nodeY = anchors(i,2);
        nodeZ = anchors(i,3);
        temp = sqrt((randX-nodeX)^2+(randY-nodeY)^2+(randZ-nodeZ)^2);
        if temp < minVal
            minVal = temp;
            minNode = anchors(i,:);
        end
        minNode;
        
    end
    plot3([randX minNode(1)], [randY minNode(2)], [randZ minNode(3)]);
    hold on;
end

hold off; 

xlabel('Acreage');
ylabel('Approximate Distance to Metro (miles)');
zlabel('Price ($K)');
    

% find other nodes 
% plot lines to them

end