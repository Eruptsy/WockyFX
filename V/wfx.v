import os

import wockyfx

fn main() {
	mut wfx := wockyfx.start_session()

	// wfx.enable_socket_mode(mut socket) // Enable socket mode
	// wfx.disable_socket_mode() // disable socket mode

	args := os.args.clone()

	if args.len < 2 {
		println("[x] Error, Invalid argument\r\nUsage: ${args[0]} <wfx_filepath>")
		exit(0)
	}

	wfx.cmd_args = args
	println(args[1])
	wfx.set_file(args[1], wockyfx.FileTypes.wfx) // set file to parse
	wfx.parse_wfx() // parse it
}