# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable vi mode
set -o vi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'


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
    [[ $(git status --porcelain 2>/dev/null) ]] && echo "*" || echo ""
}

function parse_git_branch {
    local dirty
    dirty=$(parse_git_dirty)
    git branch --no-color 2>/dev/null | sed -n '/^\*/s/^\* \(.*\)/[\1'"$dirty"']/p'
}

function set_bash_prompt () {
    set_virtualenv
    PS1="${debian_chroot:+($debian_chroot)}\$(parse_git_branch)\n${PYTHON_VIRTUALENV}${WHITE}${USER:0:1}@\h ${BLUE}\w${BLUE}\$ ${CLEAR}"
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
