#!/bin/sh
# shebang to appease shellcheck. not runnable standalone.

# common functions from the various shell scripts.
# some of these (like die()) could in theory form their own libs,
# however sometimes it's not worth the lines of code to source.

usage() {
	usage_desc >&2;
	exit 1;
}

err() { echo "#" "$@" >&2; };
die() {
	err "$@";
	err "abort!";
	exit 1;
}

