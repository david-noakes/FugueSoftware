export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
alias ll="ls -l"

PS1='\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[0;37m\]\d \t \[\033[0;33m\w$(__git_ps1)\033[0m\] \n$ '
