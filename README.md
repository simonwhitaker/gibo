# gibo: fast access to .gitignore boilerplates

**gibo** (short for .gitignore boilerplates in Go) is a command-line tool to help you easily access .gitignore boilerplates from [github.com/github/gitignore](https://github.com/github/gitignore).

## Typical usage

```console
$ gibo dump Swift Xcode >> .gitignore
```

For additional usage instructions, run `gibo help`.

## Installation

### Using Homebrew

```sh
brew install gibo
```

Or use the tap, which is slightly more up-to-date:

```sh
brew install simonwhitaker/tap/gibo
```

<!-- ### Using Chocolatey

```
choco install gibo
``` -->

### Using the Go toolchain

```sh
go install github.com/simonwhitaker/gibo@latest
```

### Building from source

Clone the repo, then:

```sh
cd gibo
go install .
```

### Downloading a binary

Download the latest [release](https://github.com/simonwhitaker/gibo/releases) for your platform, then put `gibo` (or `gibo.exe`) somewhere on your path.

### Installation on Docker

Coming soon

## Tab completion in bash, zsh, fish and Powershell

See the instructions at:

```
gibo completion
```

## Use gibo to generate .hgignore files

The `glob` .hgignore syntax for Mercurial is compatible with .gitignore syntax. This means that you can use gibo to generate .hgignore files, as long as the .hgignore files use the `glob` syntax:

```sh
echo 'syntax: glob' > .hgignore
gibo dump Python >> .hgignore
```

## Credits

gibo was written by Simon Whitaker ([@s1mn](http://twitter.com/s1mn))
