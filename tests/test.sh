#!/bin/bash

export GIBO_BOILERPLATES=$(dirname $0)/mock-boilerplates
gibo=$(dirname $0)/../gibo
known=Foo
unknown=Bar

fail() {
    echo $1
    exit 1
}

# Calling gibo without subcommand exits with non-zero exit status
$gibo >/dev/null 2>&1

if [[ $? -eq 0 ]]; then
    fail "Got zero exit status when run without subcommand"
fi

# It fails when the boilerplate file doesn't exist
$gibo dump $unknown >/dev/null 2>&1

if [[ $? -eq 0 ]]; then
    fail "Got zero exit status for unknown boilerplate"
fi

# It succeeds when the boilerplate file exists
$gibo dump $known >/dev/null

if [[ $? -ne 0 ]]; then
    fail "Got non-zero exit status for known boilerplate"
fi

# `gibo dump Foo` outputs 7 lines
expected=7
lines=$($gibo dump $known | wc -l)
if [[ $lines -ne $expected ]]; then
    fail "Expected $expected lines in output of 'gibo dump $known', got $lines"
fi
