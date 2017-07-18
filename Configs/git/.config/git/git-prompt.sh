function parse_git_dirty {

  export git_status="$(git status 2> /dev/null)"
  #echo $git_status
  local git_flags=""
  if [[  $git_status =~ "Changes not staged for commit" ]]; then
    #git_flags+="*"
    git_flags+="!"
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
  export GITFLAGS=$git_flags
  if [ ! $git_flags == "" ]; then
	  echo " "$git_flags
  fi	 
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
  #git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1/"
}

function color_my_prompt {
	export GIT_PS1_SHOWDIRTYSTATE=1
    local __user_and_host="\[\033[01;32m\]\u@\h"
	local __cur_date_time="\[\033[01;37m\]\d \t "
    local __cur_location="\[\033[01;33m\]\w"
    local __git_branch_color="\[\033[35m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    ###local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`' 
	#local __git_branch='$(__git_ps1 " (%s)") '
	###local __git_dirty=$(parse_git_dirty)
    local __prompt_tail="\[\033[01;36m\]"
    local __last_color="\[\033[00m\]"
    #export PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color$__git_branch$__prompt_tail  \n$ $__last_color"
    #export PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color$__git_branch$__prompt_tail  \$ $__last_color"
    export PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color$(parse_git_branch)$__prompt_tail  \n$ $__last_color"
    #export PS1="$__user_and_host $__cur_date_time $__cur_location $__git_branch_color$__git_branch"["$__git_dirty"]"$__prompt_tail  \n$ $__last_color"
	###$(parse_git_dirty)]
}

#parse_git_dirty
#parse_git_branch
export PROMPT_COMMAND=color_my_prompt
