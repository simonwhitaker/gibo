# gibo-go: fast access to .gitignore boilerplates

**gibo-go** (short for .gitignore boilerplates in Go) is a command-line tool to help you easily access .gitignore boilerplates from [github.com/github/gitignore](https://github.com/github/gitignore).

It is a reimplementation of [gibo](https://github.com/simonwhitaker/gibo), in Go.

## Typical usage

```console
$ gibo-go dump Swift Xcode >> .gitignore
```

For additional usage instructions, run `gibo-go help`.

## Installation

### Using Homebrew

```sh
brew install simonwhitaker/tap/gibo-go
```

### Using the Go toolchain

Or install using `go install`:

```sh
go install github.com/simonwhitaker/gibo-go@latest
```

### Building from source

Clone the repo, then:

```sh
cd gibo-go
go install .
```

### Downloading a binary

Download the latest [release](https://github.com/simonwhitaker/gibo-go/releases) for your platform, then put `gibo-go` (or `gibo-go.exe`) somewhere on your path.

### Installation on Docker

Coming soon

## Tab completion in bash, zsh, fish and Powershell

See the instructions at:

```
gibo-go completion
```

## Use gibo-go to generate .hgignore files

The `glob` .hgignore syntax for Mercurial is compatible with .gitignore syntax. This means that you can use gibo-go to generate .hgignore files, as long as the .hgignore files use the `glob` syntax:

```sh
echo 'syntax: glob' > .hgignore
gibo-go dump Python >> .hgignore
```

## Credits

gibo-go was written by Simon Whitaker ([@s1mn](http://twitter.com/s1mn))
