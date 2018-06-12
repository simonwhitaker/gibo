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
# Initial version written by Sebastian Schulz <https://github.com/yilazius>

function __gibo_wants_subcommand
    set cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

function __gibo_using_subcommand
    set cmd (commandline -opc)
    set subcommand $argv[1]
    if test (count $cmd) -ge 2
        and test $cmd[2] = $subcommand
        return 0
    end
    return 1
end

function __gibo_completion_list
  set gitignores (ls ~/.gitignore-boilerplates/**.gitignore)
  set completions
  for val in $gitignores
    set completions $completions (basename $val | cut -d '.' -f1)
  end
  echo $completions
end

complete -c gibo -n "__gibo_wants_subcommand" -f -a "dump" -d 'Dump one or more boilerplates to STDOUT'
complete -c gibo -n "__gibo_wants_subcommand" -f -a "help" -d 'Show help information'
complete -c gibo -n "__gibo_wants_subcommand" -f -a "list" -d 'Show the list of available boilerplates'
complete -c gibo -n "__gibo_wants_subcommand" -f -a "update" -d 'Update the list of available boilerplates'
complete -c gibo -n "__gibo_wants_subcommand" -f -a "version" -d 'Show the current version of gibo installed'
complete -c gibo -n "__gibo_using_subcommand dump" -f -a (__gibo_completion_list)
