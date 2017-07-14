source ~/git-prompt.sh
alias ll="ls -la" 
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
alias gp="color_my_prompt"

function parse_git_dirty {

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
	 echo ":"$git_flags
  fi	 
  ##export GITFLAGS=$git_flags
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

export PS1="\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[0;37m\]\d \t \[\033[0;33m\w"

# 100% pure Bash (no forking) function to determine the name of the current git branch
gitbranch() {
    export GITBRANCH=""

    local repo="${_GITBRANCH_LAST_REPO-}"
    local gitdir=""
    [[ ! -z "$repo" ]] && gitdir="$repo/.git"

    # If we don't have a last seen git repo, or we are in a different directory
    if [[ -z "$repo" || "$PWD" != "$repo"* || ! -e "$gitdir" ]]; then
        local cur="$PWD"
        while [[ ! -z "$cur" ]]; do
            if [[ -e "$cur/.git" ]]; then
                repo="$cur"
                gitdir="$cur/.git"
                break
            fi
            cur="${cur%/*}"
        done
    fi

    if [[ -z "$gitdir" ]]; then
        unset _GITBRANCH_LAST_REPO
        return 0
    fi
    export _GITBRANCH_LAST_REPO="${repo}"
    local head=""
    local branch=""
    read head < "$gitdir/HEAD"
    case "$head" in
        ref:*)
            branch="${head##*/}"
            ;;
        "")
            branch=""
            ;;
        *)
            branch="d:${head:0:7}"
            ;;
    esac
    if [[ -z "$branch" ]]; then
        return 0
    fi
    export GITBRANCH="$branch"
}

PS1_green='\[\e[32m\]'
PS1_blue='\[\e[34m\]'
PS1_reset='\[\e[0m\]'
PS1_cyan="\[\033[01;36m\]"
PS1_magenta="\[\033[01;35m\]"
PS1_yellow="\[\033[0;33m\]"
PS1_bright_yellow="\[\033[01;33m\]"


_mk_prompt() {
    # Change the window title of X terminals 
    case $TERM in
        xterm*|rxvt*|Eterm)
            echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"
           ;;
        screen)
            echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"
          ;;
    esac

    # Un-screw virtualenv stuff
    if [[ ! -z "${_OLD_VIRTUAL_PS1-}" ]]; then
        export PS1="$_OLD_VIRTUAL_PS1"
        unset _OLD_VIRTUAL_PS1
    fi

    if [[ -z "${_MK_PROMPT_ORIG_PS1-}" ]]; then
        export _MK_PROMPT_ORIG_PS1="$PS1"
    fi

    local prefix=()
    local jobcount="$(jobs -p | wc -l)"
    if [[ "$jobcount" -gt 0 ]]; then
        local job="${jobcount##* } job"
        [[ "$jobcount" -gt 1 ]] && job="${job}s"
        prefix+=("$job")
    fi

    gitbranch
    if [[ ! -z "$GITBRANCH" ]]; then
        prefix+=("${PS1_magenta}$GITBRANCH")
    fi

    local virtualenv="${VIRTUAL_ENV##*/}"
    if [[ ! -z "$virtualenv" ]]; then
        prefix+=("${PS1_blue}$virtualenv")
    fi

	export GITFLAGS=$(parse_git_dirty)
	
    PS1="$_MK_PROMPT_ORIG_PS1"
    if [[ ! -z "$prefix" ]]; then
        ##PS1="$PS1 [${prefix[@]} \$(parse_git_dirty) ]  "
        PS1+=" [${prefix[@]}$PS1_bright_yellow$GITFLAGS$PS1_yellow]  "
    fi
    PS1+=" \n"  # buggy - creates bash error on call to parse_git_dirty
	PS1+="$PS1_cyan$ $PS1_reset"
    export PS1
}
export PROMPT_COMMAND=_mk_prompt