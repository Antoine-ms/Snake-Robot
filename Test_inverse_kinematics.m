clear all
clc

%% Inverse Kinematic Solver

% Loading the model and creating a kinematics Solver object for the model

mdl = 'Snake_Robot_v1';
load_system(mdl);
ik = simscape.multibody.KinematicsSolver(mdl);

% Setting the world frame as the base
% Setting the snake block as the followers

base = mdl + "/Snake_Model/World Frame/W";
follower_1 = mdl + "/Snake_Model/Tail block/R";
follower_2 = mdl + "/Snake_Model/Body 1/R";
follower_3 = mdl + "/Snake_Model/Body 2/R";
follower_4 = mdl + "/Snake_Model/Head block/R";

addFrameVariables(ik,'Tail','Translation',base,follower_1);
addFrameVariables(ik,'Tail','Rotation',base,follower_1);

addFrameVariables(ik,'Body_1','Translation',base,follower_2);
addFrameVariables(ik,'Body_1','Rotation',base,follower_2);

addFrameVariables(ik,'Body_2','Translation',base,follower_3);
addFrameVariables(ik,'Body_2','Rotation',base,follower_3);

addFrameVariables(ik,'Head','Translation',base,follower_4);
addFrameVariables(ik,'Head','Rotation',base,follower_4);

% Listing all frame variables
% Assigning the x and y translation anz z rotation as targets variables

frameVariables(ik)
targetIDs = ["Tail.Translation.x";"Tail.Translation.y";
    "Head.Translation.x";"Head.Translation.y"];
addTargetVariables(ik,targetIDs)

%Listing all joint position variables
% Assigning the revolute joint variables as output variables

jointPositionVariables(ik)
outputIDs = ["j1.Rz.q";"j2.Rz.q";"j3.Rz.q"];
addOutputVariables(ik,outputIDs)

% Computing the joints variables corresponding to a snake position of 

targets = [0,0,0.4,0.4];
[outputVec,statusFlag] = solve(ik,targets);

if statusFlag == 1
    disp('Cinématique inverse résolue avec succès')
else
    disp('La résolution a échouée')
end

% Visualise the solution

viewSolution(ik);
