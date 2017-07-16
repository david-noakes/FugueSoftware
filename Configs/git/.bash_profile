source ~/.config/git/git-prompt.sh
alias ll="ls -la" 
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
alias gp="color_my_prompt"

##Code	Color
##30	Black
##31	Red
##32	Green
##33	Yellow
##34	Blue
##35	Magenta
##36	Cyan
##37	White
##01;33 bold yellow

export PS1="\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[0;37m\]\d \t \[\033[0;33m\w"

git --version
##export PROMPT_COMMAND=_mk_prompt
export PROMPT_COMMAND=color_my_prompt