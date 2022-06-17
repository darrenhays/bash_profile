####################
# AWS
####################
eap () { export AWS_PROFILE="$@";}

####################
# Python
####################
# Disable pycache
PYTHONDONTWRITEBYTECODE=1
alias python='python3'
alias pip='pip3'
alias pip_up='/home/darrenhays/Envs/marketing-jobs/bin/python -m pip install --upgrade pip'
alias pipu='pip uninstall -y -r <(pip freeze)'

####################
# Pytest
####################
pyt () { clear; python -m pytest --disable-pytest-warnings "$@" -v; }

####################
# Docker
####################
# docker buildkit
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

alias dcu='docker-compose up'
alias dcub='docker-compose up --build'
alias dcd='docker-compose down -v'
alias dps='docker ps -a'
ds () { docker stop "$@"; }

####################
# Linter
####################
alias lint='flake8 . --show-source --statistics --ignore=E501'

####################
# Bash Profile Commands
####################
alias sbp='source ~/.bashrc'
alias obp='nano /mnt/c/Users/darre/Linux/bash_profile/bash_profile'

####################
# Common Commands
####################
alias l='ls -lah --color=auto'
alias p='pwd'
alias c="clear"
alias ..="cd ../"
alias ...="..;.."
alias ....="...;.."

####################
# Common Directories
####################
alias projects='cd /mnt/c/Users/darre/Linux/projects'
alias envs='cd ~/Envs'
alias home='cd /mnt/c/Users/darre/Linux'

####################
# Flask
####################
alias fr='export PYTHONPATH="$(pwd)";export PYTHONUNBUFFERED=1;export FLASK_DEBUG=1;eap swivel;python run.py'

####################
# Git
####################
# git config
git config --global user.name "darrenhays"
git config --global user.email "darrenxhays@gmail.com"

####################
# Swivel
####################
hfr () { clear; git checkout develop; hf update; hf release start "$@"; hf release finish "$@"; }
zus () { clear; workon `basename "$PWD"`; export AWS_PROFILE=swivel; pip uninstall -y -r <(pip freeze); pip install -r requirements.txt; zappa update staging_us_east_1; }

# environment commands
ee () {
if [ -z "$1" ]
then
    unset environment; echo "environment unset";
else
    export environment="$1"; echo "environment="$environment;
fi    
}
alias eep='ee production'

# git log
alias gl='git log --oneline -10'
gln () { git log --oneline -"$@"; }

# git commands
alias gb='git branch'
alias gs='git branch; git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gco='git checkout'
alias hf='git hf'
alias hff='git hf feature'

####################
# TMF Services
####################
# Postgres
alias postgres_start='sudo service postgresql start'
# Redis
alias redis_start='sudo service redis-server start'
alias redis_stop='sudo service redis-server stop'
alias redis_restart='sudo service redis-server restart'
# Rabbit MQ
alias rabbit_start='sudo service rabbitmq-server start'
alias rabbit_stop='sudo service rabbitmq-server stop'
# Nginx
function nginx_restart {
  sudo service nginx stop
  sudo service nginx start
  echo "is nginx running now"
  ps -ef | grep nginx
}
alias nginx_stop='sudo service nginx stop'

####################
# Configuration
####################

# set nano as default editor
export EDITOR=nano

# get virtualenv name
function virtualenv_info {
    [[ -n "$VIRTUAL_ENV" ]] && echo "(${VIRTUAL_ENV##*/}) "
}

# set default prompt
function set_default_prompt {
    export PS1='`virtualenv_info`\u: \w $ '
}

# set virtualenv prompt
function set_virtualenv_prompt {
    export PS1='`virtualenv_info`\u: \w \n$ '
}

# use default prompt
set_default_prompt

# setup flask
export PYTHONUNBUFFERED=1
export FLASK_DEBUG=1

# pyenv setup
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

####################
# Virt Env Commands
####################
# necessary for mkvirtualenvwrapper to work
# pip install virtualenv
# pip install virtualenvwrapper
# mkvirtualenv --python=python3 [NAME]
export WORKON_HOME=~/Envs
source /home/darrenhays/.local/bin/virtualenvwrapper.sh

alias d="deactivate; projects; clear; set_default_prompt"
wo () { clear; cd /mnt/c/Users/darre/Linux/projects/"$@"; workon "$@"; set_virtualenv_prompt; git branch; git status;}


# make an alias for each project
for dir in /mnt/c/Users/darre/Linux/projects/*/
do
    dir=${dir%*/}
    eval "alias ${dir##*/}='wo ${dir##*/}'"
done

####################
# SSH
####################
eval $(keychain --eval id_rsa)
eval $(keychain --eval id_ed25519)

####################
# Clean Up
####################
c
projects

