# Snake-Robot

Execute the script first in order to set all the model parameters.


The 1st model (Snake_Robot_v1) is based on anisotropic friction. The snake body moves as it should but the robot is not moving forward. It is probably coming from the friction parameters but I coulnd't make it work yet. 

The 2nd model (Snake_Robot_v2_wheels_test) is based on small wheels in order to replace the anisotropic friction model. The goal was to confirm that the issue on the 1st model was the friction. This model works very well but it is a bit slow to compute.

I added a bias into the input function to make the robot steer. You can watch the demonstration video of the snake moving and steering.

Next step is to make the trajectory algorithm !
