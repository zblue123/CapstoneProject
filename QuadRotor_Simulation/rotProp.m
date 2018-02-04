function prop_rot = rotProp(prop, theta)
    rot_mat = [cos(theta),sin(theta),0;-sin(theta),cos(theta),0;0,0,1];
    prop_rot = rot_mat*prop;
end