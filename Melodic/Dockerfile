from osrf/ros:melodic-desktop-full

ARG USER_NAME="padula"
ARG USER_UID=1000
ARG USER_GID=1002
# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# Localization stuff
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}compute,utility,graphics

RUN apt-get update && apt-get install -y \
    vim \
    xclip \
    ros-${ROS_DISTRO}-moveit \
    ros-${ROS_DISTRO}-moveit-visual-tools &&\
    rm -rf /var/lib/apt/lists/*

# RUN apt-get update && apt-get install -y \
#     build-essential \
#     git \
#     tmux \
#     curl \
#     wget \
#     iputils-ping \
#     neovim \
#     gdb \
#     sudo \
#     unzip \
#     python3-pip \
#     && rm -rf /var/likb/apt/lists/*

# # install ros package
# RUN apt-get update && apt-get install -y \
#         libaria-dev \
#         ros-${ROS_DISTRO}-rviz \
#         ros-${ROS_DISTRO}-controller-manager \
#         ros-${ROS_DISTRO}-urdf \
#         ros-${ROS_DISTRO}-kdl-parser \
#         ros-${ROS_DISTRO}-tf2-eigen \
#         ros-${ROS_DISTRO}-image-transport \
#         ros-${ROS_DISTRO}-image-geometry \
#         ros-${ROS_DISTRO}-navigation \
#         ros-${ROS_DISTRO}-openslam-gmapping \
#         ros-${ROS_DISTRO}-urg-node \
#         ros-${ROS_DISTRO}-teleop-twist-keyboard \
#         ros-${ROS_DISTRO}-geometry2 \
#         alsa-base \
#         alsa-utils \
#         libasound-dev \
#         portaudio19-dev \
#         libportaudio2 \
#         libportaudiocpp0 \
#         ffmpeg \
#         sox \
#         libpcre3 \
#         libpcre3-dev \
#         libatlas-base-dev \
#         espeak \
#         python3-espeak &&\
#     rm -rf /var/lib/apt/lists/*

# ENV TZ=America/Sao_Paulo
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd -u $USER_UID $USER_NAME
RUN groupmod -g $USER_GID $USER_NAME
RUN echo $USER_NAME:$USER_NAME | chpasswd
RUN echo $USER_NAME 'ALL=(ALL) ALL' >> /etc/sudoers
WORKDIR /home/$USER_NAME

# # launch ros package

# # Install python dependencies
# COPY requirements.txt /opt/requirements.txt
# RUN pip3 install -r requirements.txt
# RUN python3 -m nltk.downloader punkt

# RUN apt-get update && apt-get install -y python3-tk

# # TODO: download nltk stuff
# CMD []
