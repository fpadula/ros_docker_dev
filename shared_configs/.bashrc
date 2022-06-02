source ~/.git-prompt.sh
export PS1='\[\e[1;38;5;41m\]\u@${ROS_DISTRO^} \[\e[1;38;5;214m\]\W\[\e[1;38;5;74m\]$(__git_ps1) \[\e[1;38;5;214m\]\$\[\e[00m\] '
alias clipboard='xclip -sel clip'
alias aws='{ { source ../devel/setup.bash &> /dev/null || source ./devel/setup.bash &> /dev/null || source ./catkin_ws/devel/setup.bash &> /dev/null ; } && echo Workspace sourced successfully ; } || echo Error sourcing Workspace'
source /opt/ros/${ROS_DISTRO}/setup.bash
export HISTSIZE=10000
export HISTFILESIZE=10000
export GAZEBO_MODEL_PATH=~/GazeboModels/gazebo_models:${GAZEBO_MODEL_PATH}
alias tmuxlayout="tmux list-windows | sed -n -e 's/^.*\[layout //p' | sed -e 's/\] @0.*$//' | clipboard"
alias aenv='source venv*/bin/activate'
export LIBDYNAMIXEL="$HOME/libraries/libdynamixel_install/"
export PATH="$HOME/.local/bin:$PATH"