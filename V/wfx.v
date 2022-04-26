import os

import wockyfx

fn main() {
	mut wfxu := wockyfx.WFX_Utils{}
	mut wfx := wockyfx.WFX{wfx_u: &wfxu}

	// wfx.enable_socket_mode(mut socket) // Enable socket mode
	// wfx.disable_socket_mode() // disable socket mode

	args := os.args.clone()

	if args.len < 2 {
		println("[x] Error, Invalid argument\r\nUsage: ${args[0]} <wfx_filepath>")
		exit(0)
	} 
	println(args[1])
	wfx.set_file(args[1], wockyfx.FileTypes.wfx) // set file to parse
	wfx.parse_wfx() // parse it
}