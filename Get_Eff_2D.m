function [ N ] = get_Eff_2D(nn, img, wavelength, angle)
 
n_air = 1;
n_glass = 1.45;
thickness  = 325;
 
n_Si = 3.7081;%interp1(WL, n, wavelength);  %TBD
clear k n WL
angle_theta0 = 0; % Incidence angle in degrees
k_parallel = n_air*sin(angle_theta0*pi/180);
 
per = abs(wavelength/sind(angle));
period = [per, 0.5*per];
 
nns = [nn nn];
angle_delta = 0;
 
[m, n] = size(pattern);
nmat = pattern*(n_Si - n_air) + n_air;
dx = per/m;
dy = 0.5*per/n;
x = [1:m]*dx - 0.5*per;
y = [1:n]*dy - 0.5*0.5*per;
 
textures =cell(1,3);
textures{1}= n_air; % Uniform, top layer
textures{2} = {n_air,nmat};
textures{3}= n_glass; % Uniform, bottom layer
profile = {[0, thickness, 0], [1, 2, 3]};
aa = res1(wavelength,period,textures,nns,k_parallel,angle_delta);
two_D_TM = res2(aa, profile);
theta_arr = two_D_TM.TMinc_bottom_transmitted.theta-angle ;
%idx = find(abs(theta_arr) == min(abs(theta_arr)));
abseff = two_D_TM.TMinc_bottom_transmitted.efficiency_TM(1);
 
 
end

