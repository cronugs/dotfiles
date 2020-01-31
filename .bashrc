#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export MONGO_URI="mongodb+srv://root:N4gu4lp4ss@myfirstcluster-y9fbv.mongodb.net/myTestDB?retryWrites=true&w=majority"
export MONGO_NATMA_URI="mongodb+srv://root:N4gu4lp4ss@myfirstcluster-y9fbv.mongodb.net/task_manager?retryWrites=true&w=majority"
export MONGO_GPMS_URI="mongodb+srv://root:N4gu4lp4ss@myfirstcluster-y9fbv.mongodb.net/goannapms?retryWrites=true&w=majority"
export MONGO_MYBLOG_URI="mongodb+srv://root:N4gu4lp4ss@myfirstcluster-y9fbv.mongodb.net/myBlog?retryWrites=true&w=majority"
export NOFOLIO_SECRET_KEY="1f67b3678156205853ddc3ef59abafed"

alias ls='ls --color=auto'
alias run='python manage.py runserver 127.0.0.1:5000'

# Fancy prompting colors
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
MAGENTA="\[\033[0;35m\]"
RED="\[\033[0;31m\]"
CLEAR="\[\033[0m\]"
YELLOW="\[\033[1;33m\]"
PINK="\[\033[1;35m\]"
PURPLE="\[\033[41;1;33m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GREY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

# Determine active Python virtualenv.
function set_virtualenv () {
    if test -z "$VIRTUAL_ENV" ; then
	PYTHON_VIRTUALENV=""
    else
	PYTHON_VIRTUALENV="${PURPLE}(`basename \"$VIRTUAL_ENV"`)${COLOR_NONE} "
    fi
}

# Fancy prompting with Git stuffs
function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
}

function set_bash_prompt () {
    set_virtualenv
    PS1="${PYTHON_VIRTUALENV}${debian_chroot:+($debian_chroot)}${WHITE}\u@\h $GREEN\w$MAGENTA\$(parse_git_branch) $BLUE\$$CLEAR "
}

PROMPT_COMMAND=set_bash_prompt

#export VIRTUALENVWRAPPER_PYTHON=`which python2`
#export VIRTUALENVWRAPPER_VIRTUALENV=`which virtualenv`
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages --distribute'
#export WORKON_HOME=$HOME/src
#export PIP_VIRTUALENV_BASE=$WORKON_HOME
#export PIP_RESPECT_VIRTUALENV=true
#source `which virtualenvwrapper.sh`

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end
