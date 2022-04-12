# shellcheck shell=sh
# Initialization script for bash, sh, mksh and ksh

which_declare="declare -f"
which_opt="-f"
which_shell="$(cat /proc/$$/comm)"

if [ "$which_shell" = "ksh" ] || [ "$which_shell" = "mksh" ] || [ "$which_shell" = "zsh" ] ; then
  which_declare="typeset -f"
  which_opt=""
fi
 
which ()
{
(alias; eval ${which_declare}) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot "$@"
}

export which_declare
export ${which_opt} which
