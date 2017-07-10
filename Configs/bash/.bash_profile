source ~/git-prompt.sh
alias ll="ls -la" 
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*";
 # [[ $(git status 2> /dev/null | grep "Your branch is ahead of") ]] && echo "+"
 # if [ "$(git stash list 2> /dev/null | grep "stash@{0}" )"  ] 
 # then 
 #    echo "$"  
 # fi
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

function color_my_prompt {
. ~/git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE=1
    local __user_and_host="\[\033[01;32m\]\u@\h"
	local __cur_date_time="\[\033[01;37m\]\d \t "
    local __cur_location="\[\033[01;33m\]\w"
    local __git_branch_color="\[\033[35m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`' 
	#local __git_branch='$(__git_ps1 " (%s)") '
	local __git_dirty='$X_git_modified'
    local __prompt_tail="\[\033[01;36m\]"
    local __last_color="\[\033[00m\]"
    #export PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color$__git_branch$__prompt_tail  \n$ $__last_color"
    #export PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color$__git_branch$__prompt_tail  \$ $__last_color"
    export PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color$(parse_git_branch)$__prompt_tail  \n$ $__last_color"
}

#parse_git_dirty
#parse_git_branch
color_my_prompt
#. ~/git-prompt.sh
#export GIT_PS1_SHOWDIRTYSTATE=1
#export PS1='\[\033[01;32m\]\u@\h\[\033[01;37m\]\d \t \[\033[01;33m\]\w\[\033[35m\]$(__git_ps1 " (%s)")\[\033[01;36m\]  \n $\[\033[00m\] '
#the above prompt has a problems on win 10
# \n gives a syntax error on `__git_ps1 " (%s)")'
#export PS1='\[\033[01;32m\]\u@\h\[\033[01;37m\]\d \t \[\033[01;33m\]\w\[\033[35m\]$(__git_ps1 " (%s)")\[\033[01;36m\]  $\[\033[00m\] '
# and this one shows git output above the prompt, but does display the dirty state

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
