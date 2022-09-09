## Usage

### Building the container image

If needed, modify the variables `locale` (e.g. `Pacific/Auckland`, `America/Sao_Paulo`, etc) and `base_ros_img` (e.g. `osrf/ros:noetic-desktop-full`, `osrf/ros:melodic-desktop-full`, etc).

- Building ROS Noetic:
```console
docker build \
--build-arg locale=America/Sao_Paulo \
--build-arg base_ros_img=osrf/ros:noetic-desktop-full \
--build-arg username=$USER \
--build-arg uid=$UID \
--build-arg gid=$(id -g ${USER}) \
-t development:noetic -f Dockerfile_Noetic .
```

- Building ROS Melodic:
```console
docker build \
--build-arg locale=America/Sao_Paulo \
--build-arg base_ros_img=osrf/ros:melodic-desktop-full \
--build-arg username=$USER \
--build-arg uid=$UID \
--build-arg gid=$(id -g ${USER}) \
-t development:melodic -f Dockerfile_Melodic .
```

- Building ROS Kinetic:
```console
docker build \
--build-arg locale=America/Sao_Paulo \
--build-arg base_ros_img=osrf/ros:kinetic-desktop-full \
--build-arg username=$USER \
--build-arg uid=$UID \
--build-arg gid=$(id -g ${USER}) \
-t development:kinetic -f Dockerfile_Kinetic .
```

---


### Running cointainers

## start
The `start` script will start a ROS container and auto-mount either the Melodic_Projects or the Noetic_Projects (depending on the ROS distro you're starting) inside the container's home folder. Note that while the container is not permanent, any changes made to the projects folders will persist. Everything inside the folder `dotfiles` will be copied to the container's home folder. 

The password for the container is the same as the username.

 Running the `start` script with only the distro type as argument will start a bash shell inside the container.

- Running ROS Noetic:
```console
./start noetic
```
- Running ROS Melodic:
```console
./start melodic
```

If a second argument is passed to `start`, it will attempt to run it as a command instead of running bash. This is useful if you wish to run a graphical terminal emulator (like `terminator`):

- Running terminator inside ROS Noetic:
```console
./start noetic terminator
```

## run

If for some reason you wish to run a command into a running container, use this command:

- Running a bash shell inside a running ROS Noetic container:
```console
./run noetic
```

- Running terminator inside a running ROS Noetic container:
```console
./run noetic terminator
```