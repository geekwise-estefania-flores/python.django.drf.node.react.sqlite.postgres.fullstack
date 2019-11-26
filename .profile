### --- Start Of GitPod Default --- ###
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
### --- End Of GitPod Default --- ###

### --- Start Of Custom Workflow Commands --- ###

function helpku() {
    local command="${1}"
    local subcommand="${2}"
    local appname="${2}"
    local error_message='Example: --appurl app-name-on-heroku'

	case "${command}" in
	'appurl' | '--appurl')
        if [ ! -z "${appname}" ]; then
            heroku apps:info -s ${appname}| grep web_url | cut -d= -f2
        else
            echo 'error: missing app name'
            echo 'try running: heroku apps -A'
            printf '\n'
        fi
	;;
	* ) echo "${error_message}"
	;;

	esac

}

function git_repo(){
    echo $(basename `git rev-parse --show-toplevel`)
}

git_branch() {
    echo $(__git_ps1) | tr -d '()'
}

function git_ps1(){
    echo "\e[92m`git_repo`/\e[93m`git_branch`\[\033[00m\] \$ "
}

function git_update_ps1(){
    export PS1=`git_ps1`
}

## note: ran each time a bash commands is call, use with caution...
PROMPT_COMMAND="git_update_ps1"

# git_branch() {
#      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
# }

# export PS1="\[\033[32m\]\$(git_repo)\[\033[33m\]\$(git_branch)\[\033[00m\]\$" 


# export PS1="\u@\[\033[32m\]\w\[\033[33m\]\$(git_branch)\[\033[00m\]\$ " 