# gibo-go: fast access to .gitignore boilerplates

**gibo-go** (short for .gitignore boilerplates in Go) is a command-line tool to help you easily access .gitignore boilerplates from [github.com/github/gitignore](https://github.com/github/gitignore).

It is a reimplementation in Go of [gibo](https://github.com/simonwhitaker/gibo).

## Typical usage

    $ gibo-go dump Swift Xcode >> .gitignore

For additional usage instructions, run `gibo help`.

## Installation

Either check out the repo and build it yourself:

```sh
go install .
```

Or install using `go install`:

```sh
go install github.com/simonwhitaker/gibo-go@latest
```

Or download the latest [release](https://github.com/simonwhitaker/gibo-go/releases).

### Installation on Docker

Coming soon

## Tab completion in bash, zsh and fish

See the instructions at:

```
gibo-go completion
```

## Use gibo to generate .hgignore files

The `glob` .hgignore syntax for Mercurial is compatible with .gitignore syntax. This means that you can use gibo to generate .hgignore files, as long as the .hgignore files use the `glob` syntax:

    echo 'syntax: glob' > .hgignore
    $ gibo dump Python TextMate >> .hgignore

## Credits

gibo was written by Simon Whitaker ([@s1mn](http://twitter.com/s1mn))

Thanks to [yevgenko](https://github.com/yevgenko) for adding the curl-based installation instructions.

Thanks to [kodybrown](https://github.com/kodybrown) for adding the gibo.bat batch file for Windows.
