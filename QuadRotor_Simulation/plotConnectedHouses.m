function plotConnectedHouses 

% plot center node 
[x1,y1,z1] = sphere;
%[x2,y2,z2] = sphere2;
%[x3,y3,z3] = sphere3;
%[x4,y4,z4] = sphere4;

%acreage 0.3:4
%price: 1000:50,0000
%distance to metro stop: 0.1:6
nodes = zeros(20,3);
figure

    
for i=1:20
    r = 0.3;
    randX = round(6 * rand())+0.5;
    randY = round(7 * rand())+0.5;
    randZ = round(10 * rand())+0.5;
    
    surf(x1*r+randX,y1*r+randY,z1*r+randZ);
    hold on;
    nodes(i,:) = [randX,randY,randZ];
   
end

for i=1:20
    firstVal = 0;
    for k=1:4
        minNode = zeros(3,1);
        minVal = 99999;
        
        node1 = nodes(i,:);
        
        for j=1:20

            node2 = nodes(j,:);
            temp = sqrt((node1(1) - node2(1))^2+(node1(2) - node2(2))^2+(node1(3) - node2(3))^2);
            if temp < minVal && j ~= firstVal && i ~= j
                
                minVal = temp;
                firstVal = j; 
                minNode = nodes(j,:);
            end
        end
    
        plot3([node1(1) minNode(1)], [node1(2) minNode(2)], [node1(3) minNode(3)]);
        hold on;
    end
end

hold off; 

xlabel('Acreage');
ylabel('Approximate Distance to Metro (miles)');
zlabel('Price ($K)');
    

% find other nodes 
% plot lines to them

end