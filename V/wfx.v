import os

import wockyfx

fn main() {
	mut wfxu := wockyfx.WFX_Utils{}
	mut wfx := wockyfx.WFX{wfx_u: &wfxu}

	// wfx.enable_socket_mode(mut socket) // Enable socket mode
	// wfx.disable_socket_mode() // disable socket mode

	for {
		cmd_in := os.input(">>> ")
		
		wfx.set_file(cmd_in, wockyfx.FileTypes.wfx) // set file to parse
		wfx.parse_wfx() // parse it
	}
}