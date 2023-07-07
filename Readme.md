## Usage

### Building the container image

If needed, modify the variables `locale` (e.g. `Pacific/Auckland`, `America/Sao_Paulo`, etc) and `base_ros_img` (e.g. `osrf/ros:noetic-desktop-full`, `osrf/ros:melodic-desktop-full`, etc). Note that you can change the name of the images (`development:noetic`, `development:melodic`, etc) to whatever you want. Just make sure to keep track of the name so that it can latter be used by the `start` script.

- Building ROS Noetic:
```console
docker build \
--build-arg locale=Pacific/Auckland \
--build-arg base_ros_img=osrf/ros:noetic-desktop-full \
--build-arg username=$USER \
--build-arg uid=$UID \
--build-arg gid=$(id -g ${USER}) \
--build-arg videoid=$(getent group video | awk -F: '{printf "%d", $3}') \
--build-arg audioid=$(getent group audio | awk -F: '{printf "%d", $3}') \
--build-arg dialoutid=$(getent group dialout | awk -F: '{printf "%d", $3}') \
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
--build-arg videoid=$(getent group video | awk -F: '{printf "%d", $3}') \
--build-arg audioid=$(getent group audio | awk -F: '{printf "%d", $3}') \
--build-arg dialoutid=$(getent group dialout | awk -F: '{printf "%d", $3}') \
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
--build-arg videoid=$(getent group video | awk -F: '{printf "%d", $3}') \
--build-arg audioid=$(getent group audio | awk -F: '{printf "%d", $3}') \
--build-arg dialoutid=$(getent group dialout | awk -F: '{printf "%d", $3}') \
-t development:kinetic -f Dockerfile_Kinetic .
```

---


### Running cointainers

## start
The `start` script will start a ROS container and auto-mount either the Melodic_Projects or the Noetic_Projects (depending on the ROS distro you're starting) inside the container's home folder. Note that while the container is not permanent, any changes made to the projects folders will persist. Everything inside the folder `dotfiles` will be copied to the container's home folder. 

The user password for the container is the same as the username. So if the username inside the container is `ros_pc`, the password will be `ros_pc`.

Run `./start -h` to get details about the parameters.

For the examples bellow, we will assume that the ros master node is being run on the PC with ip `192.168.1.4`, while the IP of the PC running the container is `192.168.1.10`.

- Running ROS Noetic:
```console
./start development:noetic --homedir ./Noetic_Projects/ --name noetic_devel --rosip 192.168.1.10 --rosmasteruri http://192.168.1.4:11311
```

- Running ROS Melodic:
```console
./start development:melodic --homedir ./Melodic_Projects/ --name melodic_devel --rosip 192.168.1.10 --rosmasteruri http://192.168.1.4:11311
```

- Running ROS Noetic with terminator as the terminal:
```console
./start development:noetic --homedir ./Noetic_Projects/ --name noetic_devel --rosip 192.168.1.10 --rosmasteruri http://192.168.1.4:11311 --exec terminator
```

- Running ROS Melodic with terminator as the terminal:
```console
./start development:melodic --homedir ./Melodic_Projects/ --name melodic_devel --rosip 192.168.1.10 --rosmasteruri http://192.168.1.4:11311 --exec terminator
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