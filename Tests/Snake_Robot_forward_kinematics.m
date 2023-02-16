function [body_pos,body_vel,statusFlag] = Snake_Robot_forward_kinematics(actuator_pos,actuator_vel)
% Uses a persistent KinematicsSolver to compute the body position and 
% velocity given the actuators position and velocity

persistent ks PosInds VelInds

if isempty(ks)
    % Create the KinematicsSolver object

    mdl = 'Snake_Robot_v1';
    ks = simscape.multibody.KinematicsSolver(mdl);

    % Setting the world frame as the base
    % Setting the snake block as the followers

    base = mdl + "/Snake_Model/World Frame/W";
    %fol1 = mdl + "/Snake_Model/Tail block/R";
    fol2 = mdl + "/Snake_Model/Body 1/R";
    fol3 = mdl + "/Snake_Model/Body 2/R";
    fol4 = mdl + "/Snake_Model/Head block/R";

    % Add frame variables (position, orientation and linear velocity)

    %addFrameVariables(ks,'Tail','Translation',base,fol1);
    %addFrameVariables(ks,'Tail','Rotation',base,fol1);
    %addFrameVariables(ks,'Tail','LinearVelocity',base,fol1);

    addFrameVariables(ks,'Body_1','Translation',base,fol2);
    addFrameVariables(ks,'Body_1','Rotation',base,fol2);
    addFrameVariables(ks,'Body_1','LinearVelocity',base,fol2);

    addFrameVariables(ks,'Body_2','Translation',base,fol3);
    addFrameVariables(ks,'Body_2','Rotation',base,fol3);
    addFrameVariables(ks,'Body_2','LinearVelocity',base,fol3);

    addFrameVariables(ks,'Head','Translation',base,fol4);
    addFrameVariables(ks,'Head','Rotation',base,fol4);
    addFrameVariables(ks,'Head','LinearVelocity',base,fol4);

    % Define some useful ID arrays
    jointPosIDs = ks.jointPositionVariables.ID;
    jointVelIDs = ks.jointVelocityVariables.ID;
    jointPosPaths = ks.jointPositionVariables.BlockPath;
    jointVelPaths = ks.jointVelocityVariables.BlockPath;
    actuatorPosIDs = jointPosIDs(jointPosPaths.contains("Revolute"));
    actuatorVelIDs = jointVelIDs(jointVelPaths.contains("Revolute"));
   
    % Add target variables (actuator position)
    targetIDs = [actuatorPosIDs;actuatorVelIDs];
    ks.addTargetVariables(targetIDs);

    % Add output variables (body positions and velocity)
    outputIDs = ["Head.Translation.x";"Head.Translation.y";"Head.LinearVelocity.x";"Head.LinearVelocity.y"];
    %outputIDs = ["Tail.Translation.x";"Tail.Translation.y";"Head.Translation.x";"Head.Translation.y";
        %"Tail.LinearVelocity.x";"Tail.LinearVelocity.y";"Head.LinearVelocity.x";"Head.LinearVelocity.y"];
    ks.addOutputVariables(outputIDs);

    % Indices to get things out of output vector
   PosInds = ks.outputVariables.ID.contains(["Head.Translation.x";"Head.Translation.y"]);
   VelInds = ks.outputVariables.ID.contains(["Head.LinearVelocity.x";"Head.LinearVelocity.y"]);
   %PosInds = ks.outputVariables.ID.contains(["Tail.Translation.x";"Tail.Translation.y";"Head.Translation.x";"Head.Translation.y"]);
   %VelInds = ks.outputVariables.ID.contains(["Tail.LinearVelocity.x";"Tail.LinearVelocity.y";"Head.LinearVelocity.x";"Head.LinearVelocity.y"]);

end

% Solving
targetVals = [actuator_pos;actuator_vel];
[outputVals,statusFlag] = solve(ks,targetVals);
body_pos = outputVals(PosInds);
body_vel = outputVals(VelInds);

