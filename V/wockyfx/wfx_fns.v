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

pub fn (mut wxu WFX_Utils) wfx_slow_place_text(r string, c string, tme string, milli_or_seconds string, gg string) {
	mut start_c := c.int()
	mut t := wockyfx.replace_code(gg)
	for i, letter in t {
		current_c := letter.ascii_str()
		print("\033[${r};${start_c}f${current_c}")
		if milli_or_seconds == "millisecond" {
			time.sleep(tme.int()*time.millisecond)
		} else {
			time.sleep(tme.int()*time.second)
		}
		start_c++
	}
}


pub fn (mut wxu WFX_Utils) wfx_list_text(r string, c string, gg string) {
	mut start_c := r.int()
	mut t := wockyfx.replace_code(gg)
	for i, letter in t.split("\n") {
		print("\033[${start_c};${c}f${letter}")
		start_c++
	}
}

pub fn (mut wxu WFX_Utils) wfx_output_wrfx(file string) {
	mut file_data := os.read_lines(file) or { 
		println("error reading file") 
		return
	}

	for i, line in file_data {
		mut fix := wockyfx.replace_code(line) // replacing_veriables
		if i == file_data.len-1 {
			print(fix.trim_space())
		} else {
			fix += "\r\n"
			print(fix)
		}
	}
}