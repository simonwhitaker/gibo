#!/zsh
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
# Then copy this file somewhere (e.g. ~/.gibo-completion.zsh) and put the
# following in your .zshrc:
# 
#     source ~/.gibo-completion.zsh
# 
# CREDITS
# 
# Written by Simon Whitaker <simon@goosoftware.co.uk>

_gibo()
{
    local_repo="$HOME/.gitignore-boilerplates"
    if [ -e "$local_repo" ]; then
        compadd -M 'm:{[:lower:]}={[:upper:]}' $( find "$local_repo" -name "*.gitignore" -exec basename \{\} .gitignore \; )
    fi
}
compdef _gibo gibo
