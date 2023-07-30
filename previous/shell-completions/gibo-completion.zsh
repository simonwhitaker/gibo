#compdef gibo
#
# Zsh completion for gibo
#
# INSTALLATION
#
# First install gibo from
# https://github.com/simonwhitaker/gitignore-boilerplates
#
# Make sure autocompletion is enabled in your shell, typically
# by adding this to your .zshrc:
#
#     autoload -U compinit && compinit
#
# Then copy this file somewhere (e.g. ~/.zsh/_gibo) and put the
# following in your .zshrc:
#
#     fpath=(~/.zsh $fpath)
#
#
# CONTRIBUTING
#
# See https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
# for tips on writing and testing zsh completion functions.
#
# CREDITS
#
# Written by Simon Whitaker <sw@netcetera.org>

_gibo_commands()
{
    _gibo_commands=(
        'dump:Dump one or more boilerplates' \
        'help:Display this help text' \
        'list:List available boilerplates' \
        'root:Show the directory where gibo stores its boilerplates' \
        'search:Search for boilerplates' \
        'update:Update list of available boilerplates' \
        'version:Display current script version'
    )
    _describe 'command' _gibo_commands
}

_gibo_dump_commands()
{
    local local_repo=${GIBO_BOILERPLATES:-"$HOME/.gitignore-boilerplates"}
    local -a boilerplates
    if [ -e "$local_repo" ]; then
        boilerplates=($local_repo/**/*.gitignore(:r:t))
    fi

    _arguments "*:boilerplate:($boilerplates)"
}

_gibo()
{
    local ret=1

    _arguments -C \
        '1: :_gibo_commands' \
        '*::arg:->args' \
        && ret=0

    case $state in
        args )
            case $line[1] in
                dump )
                    _arguments \
                        '*: :_gibo_dump_commands' \
                        && ret=0
                    ;;
            esac
    esac
}
