# Fish completion for gibo
#
# INSTALLATION
#
# First install gibo from
# https://github.com/simonwhitaker/gitignore-boilerplates
#
# Then copy this file to ~/.config/fish/completions
#
# CREDITS
#
# Written by Sebastian Schulz <https://github.com/yilazius>

function __fish_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq (count $argv) ]
        for i in (seq (count $argv))
            if [ $cmd[$i] != $argv[$i] ]
                return 1
            end
        end
        return 0
    end
    return 1
end

function gibocompletionlist
  set gitignores (ls ~/.gitignore-boilerplates/**.gitignore)
  set completions
  for val in $gitignores
    set completions $completions (basename $val | cut -d '.' -f1)
  end
  echo $completions
end

complete -c gibo -n "__fish_using_command gibo" -f -a "dump" -d 'Dump one or more boilerplates to STDOUT'
complete -c gibo -n "__fish_using_command gibo" -f -a "help" -d 'Show help information'
complete -c gibo -n "__fish_using_command gibo" -f -a "list" -d 'Show the list of available boilerplates'
complete -c gibo -n "__fish_using_command gibo" -f -a "update" -d 'Update the list of available boilerplates'
complete -c gibo -n "__fish_using_command gibo" -f -a "version" -d 'Show the current version of gibo installed'
complete -c gibo -n "__fish_using_command gibo dump" -f -a (gibocompletionlist)
