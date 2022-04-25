module wockyfx

import os
import net
import time
import wockyfx

pub fn (mut wxu WFX_Utils) wfx_clear_socket(mut socket net.TcpConn) {
	socket.write_string("\033[2J\033[1;1H") or { 0 }
}

pub fn (mut wxu WFX_Utils) wfx_hide_cursor_socket(mut socket net.TcpConn) {
	socket.write_string("\033[?25l") or { 0 }
}

pub fn (mut wxu WFX_Utils) wfx_show_cursor_socket(mut socket net.TcpConn) {
	socket.write_string("\033[?25h\033[?0c") or { 0 }
}

pub fn (mut wxu WFX_Utils) wfx_set_term_size_socket(r string, c string, mut socket net.TcpConn) {
	socket.write_string("\033[8;${r};${c}t") or { }
}

pub fn (mut wxu WFX_Utils) wfx_change_term_title_socket(t string, mut socket net.TcpConn) {
	socket.write_string("\033]0;${t}\007") or { 0 }
}

pub fn (mut wxu WFX_Utils) wfx_move_cursor_socket(r string, c string, mut socket net.TcpConn) {
	socket.write_string("\033[${r};${c}f") or { 0 }
}

pub fn (mut wxu WFX_Utils) wfx_place_text_socket(r string, c string, t string, mut socket net.TcpConn) {
	socket.write_string("\033[${r};${c}f${t}") or { 0 }
}