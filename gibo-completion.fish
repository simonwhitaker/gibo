# Fish completion for gibo
#
# INSTALLATION
#
# First install gibo from
# https://github.com/simonwhitaker/gitignore-boilerplates
#
# Then copy this file to the folder ~/.config/fish/completions/ .
# In case the folder doesn't exist create it with
#   mkdir ~/.config/fish/completions
#
# CREDITS
#
# Written by Sebastian Schulz <https://github.com/yilazius>

function gibocompletionlist
  set gitignores (ls ~/.gitignore-boilerplates/**.gitignore)
  set completions
  for val in $gitignores
    set completions $completions (basename $val | cut -d '.' -f1)
  end
  echo $completions
end

complete -c gibo -a (gibocompletionlist)
