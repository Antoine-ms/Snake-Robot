
% Plot the joint position and desired position overtime
% Useful to check and tune the performance of the PID controllers

figure

subplot(3,2,1)
plot(out.pos1)
hold on
plot(out.des1)
hold off
title('Joint 1')
legend 'pos' 'des' % pos = joint position ; des = desired joint position


subplot(3,2,2)
plot(out.pos2)
hold on
plot(out.des2)
hold off
title('Joint 2')
legend 'pos' 'des'


subplot(3,2,3)
plot(out.pos3)
hold on
plot(out.des3)
hold off
title('Joint 3')
legend 'pos' 'des'


subplot(3,2,4)
plot(out.pos4)
hold on
plot(out.des4)
hold off
title('Joint 4')
legend 'pos' 'des'


subplot(3,2,5)
plot(out.pos5)
hold on
plot(out.des5)
hold off
title('Joint 5')
legend 'pos' 'des'


