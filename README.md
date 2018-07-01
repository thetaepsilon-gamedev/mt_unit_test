## mt_unit_test: run automated tests in the minetest world

This is a set of scripts for running test cases that need to run on a server.
You can specify a lua script which will be run on the server after load,
written using assert statements to check conditions;
errors from this script are allowed to halt the server,
causing it (and the test runner) to exit with an error code.

The server is run in an isolated directory and state is not saved between tests,
ensuring that incorrect results cannot arise from left-over nodes etc. in the world.
Instructions on how to write test scripts Coming Soon (tm).

