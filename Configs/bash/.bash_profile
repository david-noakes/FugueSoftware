source ~/.config/git/git-prompt.sh
alias ll="ls -la" 
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
alias gp="color_my_prompt"
##export PROMPT_COMMAND=_mk_prompt
export PROMPT_COMMAND=color_my_prompt


#parse_git_dirty
#parse_git_branch
###color_my_prompt
#PS1='\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[0;37m\]\d \t \[\033[0;33m\w$( __git_ps1 )\033[0m\] \n$ '
#PS1='\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[0;37m\]\d \t \[\033[0;33m\w$( parse_git_branch )\033[0m\] \n$ '


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

# prompt examples:
#   [3 jobs master virtualenv] ~/code/myproject/foo
#   [1 job my-branch virtualenv] ~/code/bar/
#   [virtualenv] ~/code/
#   ~
# Very, very fast, only requiring a couple of fork()s (and no forking at all to determine the current git branch)

##if [[ "$USER" == "root" ]]
##then
##    export PS1="\e[1;31m\]\u \[\e[1;33m\]\w\[\e[0m\] ";
##else
##    export PS1="\[\e[1;33m\]\w\[\e[0m\] ";
##fi


