module wockyfx

import os
import net
import time
import wockyfx

pub type Result = string | int

pub struct WFX_Utils {
	pub mut:
		t 		string
}

pub fn (mut wxu WFX_Utils) wfx_sleep(c int) {
	time.sleep(c*time.second)
}

pub fn (mut wxu WFX_Utils) wfx_clear() {
	print("\033[2J\033[1;1H")
}

pub fn (mut wxu WFX_Utils) wfx_hide_cursor() {
	print("\x1b[?25l")
}

pub fn (mut wxu WFX_Utils) wfx_show_cursor() {
	print("\033[?25h\033[?0c")
}

pub fn (mut wxu WFX_Utils) wfx_set_term_size(r string, c string) {
	print("\033[8;${r};${c}t")
}

pub fn (mut wxu WFX_Utils) wfx_change_term_title(t string) {
	print("\033]0;${t}\007")
}

pub fn (mut wxu WFX_Utils) wfx_move_cursor(r string, c string) {
	print("\033[${r};${c}f")
}

pub fn (mut wxu WFX_Utils) wfx_place_text(r string, c string, t string) {
	print("\033[${r};${c}f${t}")
}