module wockyfx

import os
import net
import time
import wockyfx

pub type Result = string | int

pub struct WFX_Utils {}

pub fn wfx_sleep(c int) {
	time.sleep(c*time.second)
}

pub fn wfx_clear() {
	print("\033[2J\033[1;1H")
}
