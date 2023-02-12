clear variables
clc

% This script set all the paramaters for the model

%% Model parameters

mu_static = 0.43 % not used in the anisotropic friction model
mu_dynamic=0.2 % not used in the anisotropic friction model

amplitude=0.7
frequency = 2 % rad/s
phase = pi/3 % rad

% Friction for the anisotropic model
friction_x = 0.1
friction_y = 0.1

%% Setting the Serpenoid Curve

arcs = 20; % mm, arc length of the serpenoid curve 
alpha = 0.8; % rad, bending angle of the serpenoid curve
N = 7; % number of joints
kn = 1; % number of S-shape
L = 2300; % mm, total length

% From the paper we get the formula :
servoangle = [-2*alpha*sin(kn*pi/N)*sin(2*kn*pi*arcs/L+2*kn*pi*1/N);
    -2*alpha*sin(kn*pi/N)*sin(2*kn*pi*arcs/L+2*kn*pi*2/N);
    -2*alpha*sin(kn*pi/N)*sin(2*kn*pi*arcs/L+2*kn*pi*3/N);
    -2*alpha*sin(kn*pi/N)*sin(2*kn*pi*arcs/L+2*kn*pi*4/N);
    -2*alpha*sin(kn*pi/N)*sin(2*kn*pi*arcs/L+2*kn*pi*5/N);
    -2*alpha*sin(kn*pi/N)*sin(2*kn*pi*arcs/L+2*kn*pi*6/N);
    -2*alpha*sin(kn*pi/N)*sin(2*kn*pi*arcs/L+2*kn*pi*7/N)]

%servoangle(i)=-2*alpha*sin(kn*pi/N)*sin(2*kn*pi*arcs/L+2*kn*pi*i/N)

% The curve is equivalent to a sin curve :
% --> We take a sin wave for our joint input

fit_curve = 7*sin(servoangle/7)

figure
plot([servoangle;servoangle],'-o')
hold on
plot([fit_curve;fit_curve])
legend 'servoangle' 'fit curve' location best


