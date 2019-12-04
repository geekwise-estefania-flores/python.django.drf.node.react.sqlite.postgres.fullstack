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


## needed for custom .profile on gitpod
alias pippath=". $(find_repo)"'/.venv/bin/activate'

function update() {
    
    # export PYTHONPATH="${workspace_folder}/.venv/bin/activate"
    # . /workspace/testing.drf/.venv/bin/activate

    if [ -d "/workspace/$(workspace_folder)/.venv" ]; then
        # echo 'pipenv .venv exisits'
        . "$(find_repo)/.venv/bin/activate"
        # export PYTHONPATH="${workspace_folder}.venv/bin/activate"
    fi
 
    workspace && cp gitpod.custom/dircolors.256dark ~/.dir_colors
    # eval `dircolors ~/.dir_colors`
    eval $( dircolors -b ${HOME}/.dircolors )
    git_update_ps1
    source "/workspace/$(workspace_folder)/.venv/bin/activate"
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
        echo "\e[94mpipenv:🐍$(echo '  ')\e[97m$(pwd)\n\e[96mrepo:\e[92m`git_repo`\e[93m`git_branch`\[\033[00m\]\n\$ "
    else
        echo "👉 \e[97m$(pwd)\n\e[96mrepo:\e[92m`git_repo`\e[93m`git_branch`\[\033[00m\]\n\$ "
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

. $(find_repo)/gitpod.custom/helpku.sh