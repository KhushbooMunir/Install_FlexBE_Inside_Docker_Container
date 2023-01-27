FROM osrf/ros:noetic-desktop

RUN apt-get update
RUN apt-get install -y git && apt-get install -y python3-pip

RUN mkdir -p ~/catkin_ws/src && cd ~/catkin_ws/src

#RUN git clone https://github.com/noshluk2/ros1_wiki

#RUN echo "ALL DONE!"

#RUN roscd && cd ../src
#RUN git clone https://github.com/team-vigir/flexbe_behavior_engine.git

#RUN rosrun flexbe_widget create_repo [your_project_name]
#RUN roslaunch flexbe_onboard behavior_onboard.launch
#RUN roslaunch flexbe_app flexbe_ocs.launch
#RUN roslaunch flexbe_app flexbe_full.launch

# install as binary (recommended for users)
RUN sudo apt install ros-$ROS_DISTRO-flexbe-behavior-engine

# or build from source
RUN cd ~/catkin_ws/src  # or an alternative workspace source path
RUN git clone https://github.com/team-vigir/flexbe_behavior_engine.git 



RUN cd ~/catkin_ws/src
RUN git clone https://github.com/FlexBE/flexbe_app.git 
#Since FlexBE encourages re-use of states and behaviors, it is recommended to also download a few already existing #ones. A good starting point are the generic_flexbe_states, a collection of several multi-purpose FlexBE interfaces #to commonly used ROS components. Contributions are always welcome! See the bottom part of this page for some #additional recommendations. 


RUN cd ~/catkin_ws/src
RUN git clone https://github.com/FlexBE/generic_flexbe_states.git 

#Now build your workspace and source its setup.bash again such that ROS will recognize the new packages. 

RUN cd ~/catkin_ws
RUN catkin build
RUN source devel/setup.bash 


#Setting up workspace 

cd ~/catkin_ws/src
rosrun flexbe_widget create_repo [your_project_name]

# since new packages are created by the above command, build and source again
RUN cd ~/catkin_ws
RUN catkin build
RUN source devel/setup.bash 

RUN echo "ALL DONE!"
