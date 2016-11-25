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
# CREDITS
#
# Written by Simon Whitaker <sw@netcetera.org>

_gibo()
{
    local local_repo=${GIBO_BOILERPLATES:-"$HOME/.gitignore-boilerplates"}
    local -a boilerplates
    if [ -e "$local_repo" ]; then
        boilerplates=($local_repo/**/*.gitignore(:r:t))
    fi

    _arguments \
        {-l,--list}'[List available boilerplates]' \
        {-u,--upgrade}'[Upgrade list of available boilerplates]' \
        {-h,--help}'[Display this help text]' \
        {-v,--version}'[Display current script version]' \
        "*:boilerplate:($boilerplates)"
}
