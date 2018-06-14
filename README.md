# gibo: fast access to .gitignore boilerplates

**gibo** (short for .gitignore boilerplates) is a shell script to help you easily access .gitignore boilerplates from [github.com/github/gitignore](https://github.com/github/gitignore).

## Typical usage

    $ gibo dump Swift Xcode >> .gitignore

For additional usage instructions, run `gibo help`.

## Installation

### Installation on OS X using [Homebrew](http://mxcl.github.com/homebrew/)

    brew install gibo

### Installation on Fedora Linux

`gibo` is avaiable as a [COPR repository](https://copr.fedorainfracloud.org/). It provides packages for main script and bash / zsh completions:

    dnf copr enable saschpe/gibo
    dnf install gibo gibo-bash-completion gibo-zsh-completion

### Installation on other (*nix) platforms

Just download `gibo` and put it somewhere on your $PATH. Then:

    chmod +x /path/to/gibo   # Make gibo executable
    gibo update              # Initialise gibo

You can automate this with the following one-liner (assuming ~/bin is on your $PATH).

    curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo \
        -so ~/bin/gibo && chmod +x ~/bin/gibo && gibo update

### Installation on Windows

#### Using scoop

The easiest way to install `gibo` on Windows is to use [scoop](https://github.com/lukesampson/scoop), a PowerShell-based package-manager of sorts for Windows:

    scoop update
    scoop install gibo

A great benefit to using scoop, is that it provides an easy way to update its packages, including gibo:

    scoop update
    scoop update gibo

#### git installation

You can download the whole `gibo` repo directly from GitHub:

    md "C:\Users\<Your User>\bin"
    cd /D "C:\Users\<Your User>\bin"
    git clone https://github.com/simonwhitaker/gibo.git gibo

Then add the full gibo directory (`C:\Users\<Your User>\bin\gibo`) to your system's PATH environment variable.

#### Manual installation

To manually install only the `gibo.bat` file, download it to your computer and save it to any directory that is in your PATH.

Right-click [this link](https://raw.githubusercontent.com/simonwhitaker/gibo/master/gibo.bat) and select 'Save target as...' (or 'Save link as...' depending on your browser) to save it to your computer.

A good directory to put the file is `C:\Users\<Your User>\bin` and add that directory to your system's PATH environment variable. Where ever you put it, make sure the batch file is accessible via `where gibo`.

### Installation on Docker

Just type the following command.

    $ docker run --rm simonwhitaker/gibo

## Tab completion in bash, zsh and fish

bash, zsh and fish users can enjoy the deluxe gibo experience by enabling tab completion of available boilerplate names.

Sorry, there is no tab completion support in Windows.

### bash instructions

Copy `gibo-completion.bash` into a `bash_completion.d` folder:

* `/etc/bash_completion.d`
* `/usr/local/etc/bash_completion.d`
* `~/bash_completion.d`

or copy it somewhere (e.g. ~/.gibo-completion.bash) and put the following in your .bashrc:

    source ~/.gibo-completion.bash

### zsh instructions

Copy `gibo-completion.zsh` somewhere in your `$fpath`. The convention for autoloaded functions used in completion is that they start with an underscore, so I suggest you rename it to `_gibo`.

Alternatively, you can use `gibo-completion.zsh` as an [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) plugin by following [these instructions](https://github.com/simonwhitaker/gitignore-boilerplates/wiki/Using-gibo-as-an-ohmyzsh-plugin).

### fish instructions

Copy `gibo.fish` to somewhere in your `$fish_complete_path`.

## Use gibo to generate .hgignore files

The `glob` .hgignore syntax for Mercurial is compatible with .gitignore syntax. This means that you can use gibo to generate .hgignore files, as long as the .hgignore files use the `glob` syntax:

    echo 'syntax: glob' > .hgignore
    $ gibo dump Python TextMate >> .hgignore

## Credits

gibo was written by Simon Whitaker ([@s1mn](http://twitter.com/s1mn))

Thanks to [yevgenko](https://github.com/yevgenko) for adding the curl-based installation instructions.

Thanks to [kodybrown](https://github.com/kodybrown) for adding the gibo.bat batch file for Windows.
