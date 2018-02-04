function plotCameraView(t,x_sim,y_sim,z_sim,phi_sim,theta_sim,psi_sim)
x_global_min = min(x_sim);
y_global_min = min(y_sim);
%z_min = min(z_sim);

x_global_max = max(x_sim);
y_global_max = max(y_sim);
%z_max = max(z_sim);
    function [new_x, new_y] = scaleToImage(x_data, y_data ,image)
        new_x = zeros(length(x_data),1);
        new_y = zeros(length(y_data),1);
        [x_img,y_img,z_img] = size(img);
        x_slope = x_img / (x_global_max - x_global_min);
        y_slope = y_img / (y_global_max - y_global_min);
        for i=1:length(x_data)
            new_x(i) = x_slope*(x_data(i) - x_global_min);
            new_y(i) = y_slope*(y_data(i) - y_global_min);
        end
    end

dt = t(2) - t(1)

img = imread('BrookingsMap.JPG');
[x_adj,y_adj] = scaleToImage(x_sim, y_sim, img);
image(img)
hold on
h = animatedline; 
for i=1:length(x_adj)
    addpoints(h,x_adj(i),y_adj(i));
    drawnow update
    %hold on
    pause(dt/8);
end
drawnow
end