function [des_actuator_pos,newGuessPos,statusFlag] = Snake_Robot_inverse_kinematics(des_body_pos,guess_pos_in)
% Uses a persistent KinematicsSolver to compute the actuator position and 
% velocity given the body position and velocity

persistent ks guessIDs GuessInds actuatorPosInds

if isempty(ks)
    % Create kinematics solver object

    mdl = 'Snake_Robot_v1';
    ks = simscape.multibody.KinematicsSolver(mdl);

    % Setting the world frame as the base
    % Setting the snake block as the followers

    base = mdl + "/Snake_Model/World Frame/W";
    %fol1 = mdl + "/Snake_Model/Tail block/R";
    fol2 = mdl + "/Snake_Model/Body 1/R";
    fol3 = mdl + "/Snake_Model/Body 2/R";
    fol4 = mdl + "/Snake_Model/Head block/R";

    % Add frame variables (position and orientation)

    %addFrameVariables(ks,'Tail','Translation',base,fol1);
    %addFrameVariables(ks,'Tail','Rotation',base,fol1);

    addFrameVariables(ks,'Body_1','Translation',base,fol2);
    addFrameVariables(ks,'Body_1','Rotation',base,fol2);

    addFrameVariables(ks,'Body_2','Translation',base,fol3);
    addFrameVariables(ks,'Body_2','Rotation',base,fol3);

    addFrameVariables(ks,'Head','Translation',base,fol4);
    addFrameVariables(ks,'Head','Rotation',base,fol4);

    % Add target variables (body position)
    targetIDs = ["Head.Translation.x";"Head.Translation.y"];
    %targetIDs = ["Tail.Translation.x";"Tail.Translation.y";"Head.Translation.x";"Head.Translation.y"];
    ks.addTargetVariables(targetIDs);

    % Add initial guess variables (actuator positions)
    guessIDs = ["j1.Rz.q";"j2.Rz.q";"j3.Rz.q"];
    ks.addInitialGuessVariables(guessIDs);

    % Add output variables (actuator positions)
    outputIDs = ["j1.Rz.q";"j2.Rz.q";"j3.Rz.q"];
    ks.addOutputVariables(outputIDs);

    % Indices to get things out of output vector
    GuessInds = ks.outputVariables.ID.contains(ks.initialGuessVariables.ID);
    actuatorPosInds = ks.outputVariables.ID.contains(guessIDs);
end

% if there is no guess_pos_in, set it to zero
if nargin == 1
    guess_pos_in = zero(numel(guessIDs),1);
end

% Solving
[outputVals,statusFlag] = solve(ks,des_body_pos,guess_pos_in);
newGuessPos = outputVals(GuessInds);
des_actuator_pos = outputVals(actuatorPosInds);

