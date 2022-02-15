## Usage

### Build

Ideally you should only modify the variables `locale` and `base_ros_img`.

- Building ROS Noetic:
```console
docker build \
--build-arg locale=America/Sao_Paulo \
--build-arg base_ros_img=osrf/ros:noetic-desktop-full \
--build-arg username=$USER \
--build-arg uid=$UID \
--build-arg gid=$(id -g ${USER}) \
-t development:noetic -f NoeticDockerfile .
```

- Building ROS Melodic:
```console
docker build \
--build-arg locale=America/Sao_Paulo \
--build-arg base_ros_img=osrf/ros:melodic-desktop-full \
--build-arg username=$USER \
--build-arg uid=$UID \
--build-arg gid=$(id -g ${USER}) \
-t development:melodic -f MelodicDockerfile .
```

---
**NOTE**

On older ROS versions (like Melodic) you may get package installation errors. Just remove them from the Dockerfile and run the build process again.

---


### Running cointainers

The `start` script will auto-mount either the Melodic_Projects or the Noetic_Projects (depending on the argument) on the inside the container home folder. Note that everytime will exit the container will be destroyed, but any changes made to the projects folders will persist.

- Running ROS Noetic:
```console
./start noetic
```
- Running ROS Melodic:
```console
./start melodic
```