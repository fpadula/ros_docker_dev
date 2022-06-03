source ~/.git-prompt.sh
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
# export PS1='\[\e[1;38;5;41m\]\u@${ROS_DISTRO^} \[\e[1;38;5;214m\]\W\[\e[1;38;5;74m\]$(__git_ps1) \[\e[1;38;5;214m\]\$\[\e[00m\] '
## Define all the colors
COL_USR='1;38;5;41'
COL_DIR='1;38;5;214'
COL_GIT='1;38;5;74'
COL_CUR='1;38;5;214'

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "(${BRANCH}${STAT})"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[${COL_USR}m\]\u\[\e[m\]\[\e[${COL_USR}m\]@\[\e[m\]\[\e[${COL_USR}m\]${ROS_DISTRO^}\[\e[m\] \[\e[${COL_DIR}m\]\W\[\e[m\] \[\e[${COL_GIT}m\]\`parse_git_branch\`\[\e[m\] \n\[\e[${COL_CUR}m\]\\$\[\e[m\] "