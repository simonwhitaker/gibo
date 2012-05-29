# gitignore-boilerplates

A shell script for easily accessing gitignore boilerplates from [github.com/github/gitignore](https://github.com/github/gitignore)

## Typical usage

    $ gibo Python TextMate >> .gitignore

For additional usage instructions, run `gibo` without arguments.

## Installation

Just download `gibo` and put it somewhere on your $PATH. Then:

    chmod +x /path/to/gibo   # Make gibo executable
    gibo -u                  # Initialise gibo

You can automate this with the following one-liner (assuming /usr/local/bin is on your $PATH).

    curl http://git.io/gibo -sLo /usr/local/bin/gibo && chmod +x /usr/local/bin/gibo && gibo -u

## Tab completion in bash and zsh

bash and zsh users can enjoy the deluxe gibo experience by enabling tab 
completion of available boilerplate names. 

### bash instructions

Copy `gibo-completion.bash` into a `bash_completion.d` folder:

* `/etc/bash_completion.d`
* `/usr/local/etc/bash_completion.d`
* `~/bash_completion.d`

or copy it somewhere (e.g. ~/.gibo-completion.bash) and put the
following in your .bashrc:

    source ~/.gibo-completion.bash

### zsh instructions

Copy `gibo-completion.zsh` somewhere (e.g. ~/.gibo-completion.zsh)
and put the following in your .zshrc:

    source ~/.gibo-completion.zsh

Alternatively, you can use `gibo-completion.zsh` as an 
[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) plugin
by following [these instructions](https://github.com/simonwhitaker/gitignore-boilerplates/wiki/Using-gibo-as-an-ohmyzsh-plugin).

## Credits

gibo was written by Simon Whitaker ([@s1mn](http://twitter.com/s1mn))

Thanks to [yevgenko](https://github.com/yevgenko) for adding the curl-based
installation instructions.
