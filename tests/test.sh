#!/bin/bash

GIBO_BOILERPLATES=$(dirname "$0")/mock-boilerplates
export GIBO_BOILERPLATES
gibo=$(dirname "$0")/../gibo

fail() {
    echo "$1"
    exit 1
}

# Create a dummy .git directory inside $GIBO_BOILERPLATES to placate gibo's
# clone function.
(cd "$GIBO_BOILERPLATES" && mkdir -p .git)

# Calling gibo without subcommand exits with non-zero exit status
if $gibo >/dev/null 2>&1; then
    fail "Got successful (zero) exit status when run without subcommand"
fi

# It fails when the boilerplate file doesn't exist
if $gibo dump UnknownBoilerplate >/dev/null 2>&1; then
    fail "Got successful (zero) exit status for unknown boilerplate"
fi

# It succeeds when the boilerplate file exists
if ! $gibo dump Foo >/dev/null; then
    fail "Got unsuccessful (non-zero) exit status for known boilerplate"
fi

# `gibo dump Foo` outputs 7 lines
expected=7
lines=$($gibo dump Foo | wc -l)
if [[ $lines -ne $expected ]]; then
    fail "Expected $expected lines in output of 'gibo dump Foo', got $lines"
fi

# `gibo dump Foo Bar` outputs 14 lines
expected=14
lines=$($gibo dump Foo Bar | wc -l)
if [[ $lines -ne $expected ]]; then
    fail "Expected $expected lines in output of 'gibo dump Foo Bar', got $lines"
fi
