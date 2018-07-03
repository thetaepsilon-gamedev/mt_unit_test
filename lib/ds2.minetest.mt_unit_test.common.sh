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

debugid="";
if test -n "$debugname"; then debugid="[$(basename "$debugname")]"; fi;

debug() {
	if test -n "$DEBUG"; then {
		err "[debug]" "$debugid" "$@";
	}; fi;
}
warn() {
	err "warning:" "$@";
}

expect_env() {
	_msg="$2";
	if test -z "$_msg"; then {
		_msg="required environment variable not set";
	}; fi;
	_data="$(eval "echo \$$1")"
	test -n "$_data" || {
		die "${_msg}: $1";
	};
	echo "$_data";
	debug "shell variable $1 = $_data";
	unset _data;
	unset _msg;
}
debugvar() {
	# not quite backslash hell, but this never fails to get me in a tangle
	eval "debug shell variable $1 = \$$1";
}
# shortcut for the above for the path loading convention.
# essentially, to learn the locations of where dist files have been installed,
# the scripts will try to source a namespaced script,
# which should set (scoped_with_underscores) variables containing the relevant paths.
# it is possible some none-path variables could be loaded too.
expect_cfg_var() {
	expect_env "$1" "required variable not set by configuration files";
};

expect_path_bin() {
	# according to shellcheck, "which" is non-POSIX.
	# command -v isn't quite the same, but for non-aliases it does what we want;
	# namely, produces a string which we use as a command name,
	# or echoes nothing in the event of nothing matching.
	_msg="required program not found in PATH or functions: $1";
	_data="$(command -v "$1")" \
		|| die "$_msg";
	test -n "$_data" \
		|| die "$_msg";
	echo "$_data";
	unset _data;
	unset _msg;	
}



# temporary directory related
nuketmp() {
	debug "nuking temporary directory $1";
	rm -rf "$1" || warn "unable to clean up temporary directory $1";
}

# executing programs
debugexec() {
	debug "running command:" "$@";
	"$@";
}

