# If not running interactively, don't do anything 
case $- in     *i*) ;;       *) return;; esac

alias clipboard='xclip -sel clip'
alias aws='{ { source ../../devel/setup.bash &> /dev/null || source ../devel/setup.bash &> /dev/null || source ./devel/setup.bash &> /dev/null || source ./catkin_ws/devel/setup.bash &> /dev/null ; } && echo Workspace sourced successfully ; } || echo Error sourcing Workspace'

alias rl='roslaunch $(basename $(pwd)) '
alias rr='rosrun $(basename $(pwd)) '
alias roslaunch='roslaunch --disable-title'
source /opt/ros/${ROS_DISTRO}/setup.bash
source ../../devel/setup.bash &> /dev/null || source ../devel/setup.bash &> /dev/null || source ./devel/setup.bash &> /dev/null || source ./catkin_ws/devel/setup.bash &> /dev/null
export HISTSIZE=10000
export HISTFILESIZE=10000
export GAZEBO_MODEL_PATH=~/GazeboModels/gazebo_models:${GAZEBO_MODEL_PATH}

alias aenv='source venv*/bin/activate'

export LIBDYNAMIXEL="$HOME/libraries/libdynamixel_install/"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Qt/Tools/QtCreator/bin:$PATH"

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

source venv/bin/activate &> /dev/null || source ../venv/bin/activate &> /dev/null || source ../../venv/bin/activate &> /dev/null || source ../../../venv/bin/activate &> /dev/null

### Saving tmux panel history:

# Create history directory if it doesn't exist
if tmux display-message -p '#S' &> /dev/null; then
	# "Inside of a tmux session!"
	HISTS_DIR=$HOME/.bash_history.d/$(tmux display-message -p '#S')
else
	# "Outside of a tmux session!"
	HISTS_DIR=$HOME/.bash_history.d
fi
mkdir -p "${HISTS_DIR}"

if [ -n "${TMUX_PANE}" ]; then

  # Check if we've already set this pane title
  pane_id=$(tmux display -pt "${TMUX_PANE:?}" "#{pane_title}" | sed 's/ //g') 
#   if [[ $pane_id != "$pane_id_prefix"* ]]; then

#     # if not, set it to a random ID
#     random_id=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16)
#     printf "\033]2;$pane_id_prefix$random_id\033\\"
#     pane_id=$(tmux display -pt "${TMUX_PANE:?}" "#{pane_title}")
#   fi

  # use the pane's random ID for the HISTFILE
  export HISTFILE="${HISTS_DIR}/bash_history_tmux_${pane_id}"
else
  export HISTFILE="${HISTS_DIR}/bash_history_no_tmux"
fi

export PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'history -a; history -n'
export PYTHONPATH="$PYTHONPATH:/usr/lib/python3/dist-packages/"