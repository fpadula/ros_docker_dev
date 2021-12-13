ARG base_ros_img

FROM $base_ros_img

ARG username
ARG uid
ARG gid
ARG locale

# Creating user and group into the container and adding it to the sudoers
RUN useradd -u $uid $username
RUN groupmod -g $gid $username
RUN echo $username:$username | chpasswd
RUN echo $username 'ALL=(ALL) ALL' >> /etc/sudoers

# Setting container starting directory
WORKDIR /home/$username

# Setting bash as the default shell and vim as the default editor
ENV SHELL /bin/bash
ENV EDITOR vim

# Localization stuff
ENV TZ=$locale
# ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Installing needed packages
RUN apt-get update && apt-get install -y \
    neovim \
    git \
    xclip \
    tmux \
    wget \
    unzip \
    iputils-ping \
    ros-pcl-msgs \
    python3-pcl \
    python3-pcl-msgs \
    libpcl-msgs-dev \
    libpcl-conversions-dev \
    ros-${ROS_DISTRO}-turtlebot3 \
    ros-${ROS_DISTRO}-openslam-gmapping \
    ros-${ROS_DISTRO}-navigation \
    ros-${ROS_DISTRO}-ros-control* \
    ros-${ROS_DISTRO}-control* \
    ros-${ROS_DISTRO}-moveit* &&\
    rm -rf /var/lib/apt/lists/*

# Installing tmuxinator to manage tmux project sesions
run gem install tmuxinator

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}compute,utility,graphics