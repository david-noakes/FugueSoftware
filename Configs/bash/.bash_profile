source ~/git-prompt.sh
alias ll="ls -la" 
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
alias gp="color_my_prompt"

function parse_git_dirty {
# not working
  export git_status="$(git status 2> /dev/null)"
  #echo $git_status
  local git_flags=""
  if [[  $git_status =~ "Changes not staged for commit" ]]; then
    git_flags+="*"
  fi	
  if [[ $git_status =~ "Your branch is ahead of" ]]; then
    git_flags+="^"
  fi	
  if [[ $git_status =~ "Changes to be committed" ]]; then
    git_flags+="+"
  fi	
  if [[ $git_status =~ "Untracked files" ]]; then	
      git_flags+="%"
  fi
  export git_stash="$(git stash list 2> /dev/null)"
  if [[ $git_stash =~ "stash@{0}" ]]; then 
      git_flags+="$"
  fi
  if [ ! $git_flags = "" ]; then
     #echo "["$git_flags"]"
	 echo " : "$git_flags
  fi	 
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
  #git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$($(__git_ps1 " (%s)"))]/"
}

function color_my_prompt {
. ~/git-prompt.sh
    local __user_and_host="\[\033[01;32m\]\u@\h"
	local __cur_date_time="\[\033[01;37m\]\d \t "
    local __cur_location="\[\033[01;33m\]\w"
    local __git_branch_color="\[\033[35m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    #local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\$(parse_git_dirty)\)\ /`' 
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`' 
	#local __git_branch=$(__git_ps1 " (%s)")
	#local __git_branch=" \$(__git_ps1) \$(parse_git_dirty) "
	#local __git_branch=" (\$(\"git branch 2>/dev/null | grep '^*' \"  ) )"
    local __prompt_tail="\[\033[01;36m\]"
    local __last_color="\[\033[00m\]"
    #PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color$__git_branch$__prompt_tail  \n$ $__last_color"
    #export PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color$__git_branch$__prompt_tail  \$ $__last_color"
    PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color"
	PS1+=$(parse_git_branch)
	#PS1+=$__git_branch 
	#PS1+=$(parse_git_dirty) 
	PS1+="$__prompt_tail  \n$ $__last_color"
	export PS1
}

#parse_git_dirty
#parse_git_branch
color_my_prompt

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
