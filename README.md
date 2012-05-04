# gitignore-boilerplates

A shell script for easily accessing gitignore boilerplates from [github.com/github/gitignore](https://github.com/github/gitignore)

## Typical usage

    $ gibo Python TextMate >> .gitignore

For additional usage instructions, run `gibo` without arguments.

## Installation

Copy or symlink `gibo` into your $PATH. Done.

## Bash tab completion

Bash users can enjoy the deluxe gibo experience by enabling tab 
completion of available boilerplate names. 

Copy `gibo-completion.bash` into a `bash_completion.d` folder:

* `/etc/bash_completion.d`
* `/usr/local/etc/bash_completion.d`
* `~/bash_completion.d`

or copy it somewhere (e.g. ~/.gibo-completion.sh) and put the
following in your .bashrc:

    source ~/.gibo-completion.sh

## Credits

gibo was written by Simon Whitaker ([@s1mn](http://twitter.com/s1mn))
