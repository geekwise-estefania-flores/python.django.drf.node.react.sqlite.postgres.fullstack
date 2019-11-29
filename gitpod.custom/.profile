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

# function pipenv_status() {
#     if $(ps -u gitpod | grep 'pipenv' | grep -v 'defunct'); then
#     ps -u gitpod | grep 'pipenv' | grep -v 'defunct' | awk {'print $1'} | xargs echo
#     #xargs kill -9
# fi
# }

function find_repo(){
    local current_directory=$(pwd)
    cd -- "/workspace/$(workspace_folder)/" && git rev-parse --show-toplevel
    cd ${current_directory}
}

function workspace_folder(){
   (cd /workspace/ && find . -maxdepth 1 -mindepth 1  -type d -not -path '*/\.*')
}

alias workspace="cd -- $(find_repo)"

function transfer(){
    cp $(find_repo)/gitpod.custom/.profile ~/
    cp $(find_repo)/gitpod.custom/.zshrc ~/
}

function update() {    
    workspace && cp gitpod.custom/dircolors.256dark ~/.dir_colors
    # eval `dircolors ~/.dir_colors`
    eval $( dircolors -b ${HOME}/.dircolors )
    git_update_ps1
    source ${HOME}/.profile
    source ${HOME}/.zshrc
}

function reset_pipenv(){
    kill -9 `ps -u gitpod | grep 'pipenv' | awk '{print $1}'`
}


function git_repo(){
    find_repo | sed 's/\/workspace\///g'
}

git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}



# function git_branch() {
#     echo $(__git_ps1) | tr -d '()'
# }

function pipshell() {
        pipenv shell & source ~/.profile
        # if [[ $VIRTUAL_ENV ]]; then
        #     source ~/.profile
        # fi
}

function git_ps1(){



    local pipenv_status=$(ps -u gitpod | grep 'pipenv' | grep -v 'defunct' | awk {'print $1'} | xargs echo)
    
    if [ ! -z "${pipenv_status}" ]; then
        #xargs kill -9
        echo "\e[94mpipenv:🐍\n\e[96mrepo:\e[92m`git_repo`\e[93m`git_branch`\[\033[00m\] \$ "
    else
        echo "👉 \e[97m$(pwd)\n\e[96mrepo:\e[92m`git_repo`\e[93m`git_branch`\[\033[00m\] \$ "
    fi
}

function git_update_ps1(){
    export PS1=`git_ps1`
}

## note: ran each time a bash commands is call, use with caution...
PROMPT_COMMAND="git_update_ps1"

# export PS1="\[\033[32m\]\$(git_repo)\[\033[33m\]\$(git_branch)\[\033[00m\]\$" 


# export PS1="\u@\[\033[32m\]\w\[\033[33m\]\$(git_branch)\[\033[00m\]\$ " 







#IMPORT CUSTOM FOLDER ALIAS LOCATIONS
# . /scripts/bash.prod/bash.custom.folder.aliases.sh



# function helpku() {
#     local command="${1}"
#     local subcommand="${2}"
#     local appname="${2}"
#     local error_message='Example: --appurl app-name-on-heroku'

# 	case "${command}" in
# 	'appurl' | '--appurl')
#         if [ ! -z "${appname}" ]; then
#             heroku apps:info -s ${appname}| grep web_url | cut -d= -f2
#         else
#             echo 'error: missing app name'
#             echo 'try running: heroku apps -A'
#             printf '\n'
#         fi
# 	;;
# 	* ) echo "${error_message}"
# 	;;

# 	esac

# }