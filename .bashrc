#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
alias xup='xrdb ~/.Xresources'
alias packer='packer --noedit'
PS1='[\u@\h \W]\$ '
echo -en "\x1b[\x35 q"
bash --init-file <(echo "neofetch")
