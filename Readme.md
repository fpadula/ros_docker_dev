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
-t development:noetic .
```

- Building ROS Melodic:
```console
docker build \
--build-arg locale=America/Sao_Paulo \
--build-arg base_ros_img=osrf/ros:melodic-desktop-full \
--build-arg username=$USER \
--build-arg uid=$UID \
--build-arg gid=$(id -g ${USER}) \
-t development:melodic .
```

---
**NOTE**

On older ROS versions (like Melodic) you may get package installation errors. Just remove them from the Dockerfile and run the build process again.

---


### Running cointainers
- Running ROS Noetic:
```console
./start noetic
```
- Running ROS Melodic:
```console
./start melodic
```
- Running ROS Noetic and specifying a different projects folder:
```console
./start noetic ~/Projects
```