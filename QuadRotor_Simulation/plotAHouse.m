function plotAHouse 
[x1,y1,z1]=sphere;
for i=1:20
    r = 0.3;
    randX = round(6 * rand())+0.5;
    randY = round(7 * rand())+0.5;
    randZ = round(10 * rand())+0.5;
    
    surf(x1*r+randX,y1*r+randY,z1*r+randZ);
    
    %plot3([randX minNode(1)], [randY minNode(2)], [randZ minNode(3)]);
    hold on;
end

xlabel('Acreage');
ylabel('Approximate Distance to Metro (miles)');
zlabel('Price ($K)');

hold off; 
    

% find other nodes 
% plot lines to them

end