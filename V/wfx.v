import os

import wockyfx

fn main() {
	mut wfx := wockyfx.WFX{wfx_u: &wockyfx.WFX_Utils}
	for {
		cmd_in := os.input(">>> ")
		
		wfx.set_file(cmd_in, wockyfx.FileTypes.wfx)
		wfx.parse_wfx()
	}
}