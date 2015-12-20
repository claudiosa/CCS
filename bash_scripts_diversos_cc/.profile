# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
PATH="$PATH:/usr/local/eclipse/bin/x86_64_linux:/usr/local/minizinc-1.6/bin:/usr/local/minizinc-1.6/doc/man:/usr/local/minizinc-1.6/examples:/usr/local/minizinc-1.6/lib:/usr/local/minizinc-1.6/tools:/usr/local/minizinc-1.6/MiniZincIDE"
#fi
export PATH
echo    $PATH
echo     " ..."


alias path="echo $PATH"