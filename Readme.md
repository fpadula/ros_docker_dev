## Usage

### Dockerfiles description

This repo provides a few useful Dockerfiles that can be used as-is or as a base for your own configs.

- **Dockerfile_ROS1_base**: This Dockerfile adds a few handy packages for dev (tmux, vim, terminator, wget, etc.) on top of a base ros image. The image `fpadula/noetic_base` is based on this file.
- **Dockerfile_user_cfg**: This Dockerfile is responsible for configuring some user variables, locale, etc.

### Building the container image

If needed, modify the variables `locale` (e.g. `Pacific/Auckland`, `America/Sao_Paulo`, etc) and `base_ros_img` (e.g. `fpadula/noetic_base`, `osrf/ros:melodic-desktop-full`, etc). Note that you can change the name of the images (`noetic_dev`, for example) to whatever you want. Just make sure to keep track of the name so that it can later be used by the `start` script.

- Building ROS Noetic:

This command will build an image based on the image specified by base_ros_img.  

```console
docker build \
--build-arg locale=Pacific/Auckland \
--build-arg base_ros_img=fpadula/noetic_base \
--build-arg username=$USER \
-t noetic_dev -f Dockerfile_user_cfg .
```

---


### Running containers

## start
The `start` script will start a ROS container and mount a specific folder (specified by the `--homedir` parameter) inside the container's home folder. Note that while the container is not permanent, any changes to the project folders will persist. When using the start script, everything inside the folder `dotfiles` will be copied to the container's home folder.

The user password for the container is the same as that for the base PC since all the files inside `/etc/passwd` are mounted.

Run `./start -h` to get details about the parameters.

For the examples below, we will assume that the ros master node is being run on the PC with ip `192.168.1.4`, while the IP of the PC running the container is `192.168.1.10`.

- Running ROS Noetic:
```console
./start noetic_dev --homedir ./Noetic_Projects/ --name noetic_dev --rosip 192.168.1.10 --rosmasteruri http://192.168.1.4:11311
```

- Running ROS Noetic with terminator as the terminal:
```console
./start noetic_dev --homedir ./Noetic_Projects/ --name noetic_dev --rosip 192.168.1.10 --rosmasteruri http://192.168.1.4:11311 --exec terminator
```

## run
If, for some reason, you wish to run a command into a running container, use this command:

- Running a bash shell inside a running ROS Noetic container:
```console
./run noetic_dev_base
```

- Running terminator inside a running ROS Noetic container:
```console
./run noetic_dev_base terminator
```

## Aliases

The bashrc file provided in `dotfiles/.bashrc` specifies a few useful aliases:

- `aws` (**a**ctivate **w**ork**s**pace): Will source a ROS1/ROS2 workspace. It will essentially try to run the following commands:

```console
source ../../install/setup.bash
source ../install/setup.bash
source ./install/setup.bash
source ./ros2_ws/install/setup.bash
source ../../devel/setup.bash
source ../devel/setup.bash
source ./devel/setup.bash
source ./catkin_ws/devel/setup.bash
```

If one of them succeeds, the message `Workspace sourced successfully` is displayed. If all of them failed, the message `Error sourcing Workspace` is displayed instead.
