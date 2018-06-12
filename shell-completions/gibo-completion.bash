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
# Written by Simon Whitaker <sw@netcetera.org>

_gibo()
{
    local cur prev opts
    cur="${COMP_WORDS[COMP_CWORD]}"

    case $COMP_CWORD in
        1)
            COMPREPLY=($(compgen -W "dump help list update version" -- ${cur}))
            ;;
        *)
            subcommand="${COMP_WORDS[1]}"
            case $subcommand in
                dump)
                    opts=$( find ${GIBO_BOILERPLATES:-"$HOME/.gitignore-boilerplates"} -name "*.gitignore" -exec basename \{\} .gitignore \; )
                    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            ;;
    esac
}

complete -F _gibo gibo
