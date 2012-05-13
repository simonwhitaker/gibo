#!bash
# 
# Bash completion for gibo
# 
# INSTALLATION
# 
# First install gibo from 
# https://github.com/simonwhitaker/gitignore-boilerplates
# 
# Then copy this file into a bash_completion.d folder:
# 
#     /etc/bash_completion.d
#     /usr/local/etc/bash_completion.d
#     ~/bash_completion.d
# 
# or copy it somewhere (e.g. ~/.gibo-completion.bash) and put the
# following in your .bashrc:
# 
#     source ~/.gibo-completion.bash
# 
# CREDITS
# 
# Written by Simon Whitaker <simon@goosoftware.co.uk>

_gibo()
{
    local cur opts
    opts=$( find $HOME/.gitignore-boilerplates -name "*.gitignore" -exec basename \{\} .gitignore \; )
    cur="${COMP_WORDS[COMP_CWORD]}"
    
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}
complete -F _gibo gibo
