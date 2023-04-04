clear variables
clc

% Set all the paramaters for the model

%% Model parameters

% Input parameters
amplitude=2.5;
frequency = 2; % rad/s
phase = 1.4; % rad


% Friction for the anisotropic model
   % Static friction coefficients
mus_x = 1e-4;
mus_y = 13;
   % Dynamic friction coefficients
muk_x = 1e-5;
muk_y = 10;
    % Lookup table xdaty
lookup_table_x = [-3 -1.5 -1 1 1.5 3];
lookup_table_y = [-3 -1.5 -1 1 1.5 3];


% Internal joint paramaters
internal_stiffness = 0.85;

% Joints limit parameters
spring_stiffness = 1e4;
joint_damp = 10;

% Bias for steering
bias=0.35;

%%

disp('Done - Robot parameters set')
