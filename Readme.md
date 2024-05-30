## Nvidia-runtime branch

This branch was created in response to nvidia-docker being deprecated: https://github.com/NVIDIA/nvidia-docker.

This branch will eventually merge with master once everything is working reliably.

## Usage

### Building the container image

If needed, modify the variables `locale` (e.g. `Pacific/Auckland`, `America/Sao_Paulo`, etc) and `base_ros_img` (e.g. `fpadula/noetic_base`, `osrf/ros:melodic-desktop-full`, etc). Note that you can change the name of the images (`noetic_dev` for example) to whatever you want. Just make sure to keep track of the name so that it can latter be used by the `start` script.

- Building ROS Noetic:
```console
docker build \
--build-arg locale=Pacific/Auckland \
--build-arg base_ros_img=fpadula/noetic_base \
--build-arg username=$USER \
-t noetic_dev -f Dockerfile_Noetic .
```

---


### Running cointainers

## start
The `start` script will start a ROS container and mount a specific folder (specified by the `--homedir` parameter) inside the container's home folder. Note that while the container is not permanent, any changes made to the projects folders will persist. When using the start script, everything inside the folder `dotfiles` will be copied to the container's home folder.

The user password for the container is the same as in the base PC, since all the files inside `/etc/passwd` are mounted.

Run `./start -h` to get details about the parameters.

For the examples bellow, we will assume that the ros master node is being run on the PC with ip `192.168.1.4`, while the IP of the PC running the container is `192.168.1.10`.

- Running ROS Noetic:
```console
./start noetic_dev --homedir ./Noetic_Projects/ --name noetic_dev_base --rosip 192.168.1.10 --rosmasteruri http://192.168.1.4:11311
```

- Running ROS Noetic with terminator as the terminal:
```console
./start noetic_dev --homedir ./Noetic_Projects/ --name noetic_dev_base --rosip 192.168.1.10 --rosmasteruri http://192.168.1.4:11311 --exec terminator
```

## run

If for some reason you wish to run a command into a running container, use this command:

- Running a bash shell inside a running ROS Noetic container:
```console
./run noetic_dev_base
```

- Running terminator inside a running ROS Noetic container:
```console
./run noetic_dev_base terminator
```