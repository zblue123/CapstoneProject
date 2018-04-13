clear all
close all
m = 25; %1; % 25
Ixx = 0.7625; %8.1e-3; % 0.7625
Iyy = 0.7625; %8.1e-3; % 0.7625
Izz = 1.2183; %14.2e-3; % 1.2183
I = [Ixx 0 0;0 Iyy 0;0 0 Izz];
Jtp = 0.0072; %104e-6; % 0.0072
Ke = 0.0796; %6.3e-3; % 0.0796
Km = 0.0796; %6.3e-3; % 0.0796
L = 15e-6; % % Keep same
b = 0.0013; %54.2e-6; % 0.0013
l = sqrt(2)/2; %0.24; % sqrt(2)/2
g = 9.81; % same
n = 0.9; % same
N = 5.6; %1; %5.6; % 1?
h = 1e-3; % same
R = 1.5; %0.6; % 1.5
d = 5.1467e-5; %1.1e-6; % drag factor % 5.1467e-5
% Motor Controller Design

Kp_position = 0.5;
Ki_position = 0;
Kd_position = 2;

Kp_z = 0.1;
Ki_z = 0.1;
Kd_z = 5;

Kp_angle = 5*2;
Ki_angle = 0;
Kd_angle = 10*2;

Kp_motor = 15;
Ki_motor = 30;
Kd_motor = 0;

%w'=Apw+Bpv+Cp
wh = 43;

Ap = -Ke*Km*n*N*N/(Jtp*R) - 2*d*wh/Jtp; %-22.5;
Bp = Km*n*N/(Jtp*R); %509;
Cp = d*wh*wh/Jtp; %489;
a1 = Ap;
b1 = Bp;
c1 = 1;
d1 = 0;
sys_c_m = ss(a1,b1,c1,d1);
Gc_m = tf(sys_c_m);
sys_d_m = c2d(sys_c_m,h,'zoh');
Gd_m = tf(sys_d_m);

Cc_m = tf([Kp_motor Ki_motor],[1 0]);
sys_c_mctrl = ss(Cc_m);
sys_d_mctrl = c2d(sys_c_mctrl,h,'tustin');
Cd_m = tf(sys_d_mctrl);

LGd_m = Gd_m*Cd_m;
Td_m = feedback(LGd_m,1);

figure(1)
margin(LGd_m)
hold on
grid on
figure(2)
step(Td_m)
hold on
grid on

num = [1];
den = [1 0 0];
Gc_p = tf(num,den);
sys_c_p = ss(Gc_p);
sys_d_p = c2d(sys_c_p,h,'zoh');
Gd_p = tf(sys_d_p);


Cc_a = tf([Kp_angle Ki_angle],[1 0]);
sys_c_actrl = ss(Cc_a);
sys_d_actrl = c2d(sys_c_actrl,h,'tustin');
Cd_a = tf(sys_d_actrl);

% SMK Added
set_param('Quadrotor','AlgebraicLoopSolver','LineSearch');
dt = 0.01;
msl = 200;
vx = 10;
vy = 0;
x0 = 50;
y0 = 10;
