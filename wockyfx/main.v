module wockyfx

import os
import net
import wockyfx // self module

pub struct WFX {
	pub mut:
		socket_toggle	bool
		socket			net.TcpConn

		file			string
		file_data		string
		file_lines		[]string
		file_type		FileTypes
		file_rank		FileRanks

		perms			map[string]int = {
												'free': 0,
												'premium': 1,
												'reseller': 2,
												'admin': 3,
												'owner': 4
											}

											// If function arguments are these then its a function called
		datatypes		[]string 		  = ['int', 'string']

						// FUNCTION_NAME, FUNCTION_MAX_ARG		// ANSI Functions
		functions		map[string]int = {'sleep':				1,
											 'clear':				1,
											 'hide_cursor': 		0,
											 'show_cursor': 		0,
											 'print_text':			1,
											 'place_text': 			3,
											 'slow_place_text': 	3,
											 'list_text': 			3,
											 'slow_list_text':		3,
											 'set_term_size': 		1,
											 'change_term_title':	1,
											 'move_cursor':			2,
											 'include_wfx':			1,
											 'output_wrfx':			1,
											 // Returning Functions
											 'get_args': 			0,
											 // Special Functions
											 'geo_ip':				1,
											 'port_scan':			1,
											 'send_attack':			3,
											 // Error Handlers
											 'set_max_arg':			1,
											 'set_arg_err_msg':		-1 // Do not detect the amount of argument for this function
											}

		variables 		map[string]string = {
												'Default': '\x1b[39m'
												'Black': '\x1b[30m'
												'Red': '\x1b[31m'
												'Green': '\x1b[32m'
												'Yellow': '\x1b[33m'
												'Blue': '\x1b[34m'
												'Purple': '\x1b[35m'
												'Cyan': '\x1b[36m'
												'Light_Grey': '\x1b[37m'
												'Dark_Grey': '\x1b[90m'
												'Light_Red': '\x1b[91m'
												'Light_Green': '\x1b[92m'
												'Light_Yellow': '\x1b[93m'
												'Light_Blue': '\x1b[94m'
												'Light_Purple': '\x1b[95m'
												'Light_Cyan': '\x1b[96m'
												'White': '\x1b[97m'
												'Default_BG': '\x1b[49m'
												'Black_BG': '\x1b[40m'
												'Red_BG': '\x1b[41m'
												'Green_BG': '\x1b[42m'
												'Yellow_BG': '\x1b[43m'
												'Blue_BG': '\x1b[44m'
												'Purple_BG': '\x1b[45m'
												'Cyan_BG': '\x1b[46m'
												'Light_Gray_BG': '\x1b[47m'
												'Dark_Gray_BG': '\x1b[100m'
												'Light_Red_BG': '\x1b[101m'
												'Light_Green_BG': '\x1b[102m'
												'Light_Yellow_BG': '\x1b[103m'
												'Light_Blue_BG': '\x1b[104m'
												'Light_Purple_BG': '\x1b[105m'
												'Light_Cyan_BG': '\x1b[106m'
												'White_BG': '\x1b[107m'
												'Clear': '\033[2J\033[1;1H'
		}

		fcmd			string
		cmd 			string
		cmd_args		[]string

		online_users	string
}

pub enum FileTypes {
	wfx
	whfx
	wrfx
}

pub enum FileRanks {
	free
	premium
	reseller
	admin
	owner
}

pub fn (mut wx WFX) set_file(filepath string, file_type FileTypes) {
	data := os.read_file(filepath) or {
		println("[x] Error, Unable to locate file or read file!")
		return
	}
	if data == "" {
		println("[x] Error, This WFX files contains no data!")
		return
	}
	wx.file = filepath
	wx.file_data = data
	wx.file_lines = data.split("\n")
}

pub fn (mut wx WFX) set_cmd_info(fcmd string, cmd string, args []string) {
	wx.fcmd = fcmd
	wx.cmd = cmd
	wx.cmd_args = args
}

pub fn (mut wx WFX) set_current_info() {

}

pub fn (mut wx WFX) parse_wfx() {
	// Check for perm keyword and remove
	if wx.file_type == FileTypes.wfx {
		wx.parse_perm(wx.file_lines[0])
	}

	// Check for max_arguments 
	
} 

pub fn (mut wx WFX) check_for_max_arg() {
	for i, line in wx.file_lines {
		if line.starts_with("set_max_arg") {
			// validate function here
			if wx.file_lines[i+1].starts_with("set_arg_err_msg") {
				// validate function here
			}
		}
	}
}

pub fn (mut wx WFX) parse_perm(line string) {
	if line.starts_with("perm") {
		rank := line.split(" ")[1]
		match rank {
			"free" {
				wx.file_rank = FileRanks.free
			}
			"premium" {
				wx.file_rank = FileRanks.premium
			}
			"reseller" {
				wx.file_rank = FileRanks.reseller
			}
			"admin" {
				wx.file_rank = FileRanks.admin
			}
			"owner" {
				wx.file_rank = FileRanks.owner
			} else {}
		}
	}
}