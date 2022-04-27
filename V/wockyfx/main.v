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

		// Current Function Info
		fn_current_arg	[]string
		fn_args_count	int

		// WHFX SHIT
		whfx_file		string
		whfx_fnc		string
		whfx_fnc_data	[]string

		perms			map[string]int = {
												'free': 0,
												'premium': 1,
												'reseller': 2,
												'admin': 3,
												'owner': 4
											}

											// If function arguments are these then its a function called
		datatypes		[]string 		  = ['int', 'string']

						// FUNCTION_NAME, FUNCTION_MAX_ARG(1==0)		// ANSI Functions
		functions		map[string]int = {'sleep':				1,
											 'clear':				0,
											 'hide_cursor': 		0,
											 'show_cursor': 		0,
											 'print_text':			1,
											 'place_text': 			3,
											 'slow_place_text': 	5,
											 'list_text': 			3,
											 'slow_list_text':		3,
											 'set_term_size': 		1,
											 'change_term_title':	1,
											 'move_cursor':			1,
											 'include_whfx':		1,
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

		variables 		map[string][]string = {
												'Default': ['\x1b[39m', 'str']
												'Black': ['\x1b[30m', 'str']
												'Red': ['\x1b[31m', 'str']
												'Green': ['\x1b[32m', 'str']
												'Yellow': ['\x1b[33m', 'str']
												'Blue': ['\x1b[34m', 'str']
												'Purple': ['\x1b[35m', 'str']
												'Cyan': ['\x1b[36m', 'str']
												'Light_Grey': ['\x1b[37m', 'str']
												'Dark_Grey': ['\x1b[90m', 'str']
												'Light_Red': ['\x1b[91m', 'str']
												'Light_Green': ['\x1b[92m', 'str']
												'Light_Yellow': ['\x1b[93m', 'str']
												'Light_Blue': ['\x1b[94m', 'str']
												'Light_Purple': ['\x1b[95m', 'str']
												'Light_Cyan': ['\x1b[96m', 'str']
												'White': ['\x1b[97m', 'str']
												'Default_BG': ['\x1b[49m', 'str']
												'Black_BG': ['\x1b[40m', 'str']
												'Red_BG': ['\x1b[41m', 'str']
												'Green_BG': ['\x1b[42m', 'str']
												'Yellow_BG': ['\x1b[43m', 'str']
												'Blue_BG': ['\x1b[44m', 'str']
												'Purple_BG': ['\x1b[45m', 'str']
												'Cyan_BG': ['\x1b[46m', 'str']
												'Light_Gray_BG': ['\x1b[47m', 'str']
												'Dark_Gray_BG': ['\x1b[100m', 'str']
												'Light_Red_BG': ['\x1b[101m', 'str']
												'Light_Green_BG': ['\x1b[102m', 'str']
												'Light_Yellow_BG': ['\x1b[103m', 'str']
												'Light_Blue_BG': ['\x1b[104m', 'str']
												'Light_Purple_BG': ['\x1b[105m', 'str']
												'Light_Cyan_BG': ['\x1b[106m', 'str']
												'White_BG': ['\x1b[107m', 'str']
												'Clear': ['\033[2J\033[1;1H', 'str']
		}
		// Buffer Info
		fcmd			string
		cmd 			string
		cmd_args		[]string

		user_info		map[string]string
		online_users	string

		wfx_u 			&wockyfx.WFX_Utils
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

pub enum Datatypes {
	str
	intger
	fnc
}

pub fn start_session() WFX {
	mut wxu := wockyfx.WFX_Utils{}
	mut wfx := WFX{wfx_u: &wxu}
	return wfx
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

pub fn (mut wx WFX) set_new_wfx_code(code []string) {
	wx.file_lines = code
}

pub fn (mut wx WFX) set_buffer(fcmd string, cmd string, args []string) {
	wx.fcmd = fcmd
	wx.cmd = cmd
	wx.cmd_args = args
}

pub fn (mut wx WFX) enable_socket_mode(mut socket net.TcpConn) {
	wx.socket_toggle = true
	wx.socket = socket
}

pub fn (mut wx WFX) disable_socket_mode() {
	wx.socket_toggle = false
}

pub fn (mut wx WFX) set_current_info() {

}

// Adding file variables to the list of global variables!
pub fn (mut wx WFX) add_variable(var_name string, var_type string, var_value string) {
	wx.variables[var_name] = [var_value, var_type]
}

pub fn (mut wx WFX) append_variable(var_name string, var_value string) {

}

pub fn (mut wx WFX) get_var_info(var_name string) (string, string, string) {
	return "", "", ""
}

// Not Done!
pub fn (mut wx WFX) check_for_max_arg() (int, string) {
	mut updated_code := []string // New file's code removing the 2 argument functions from content

	// For loop check points
	mut max_arg := 0
	mut max_arg_err := ""

	// Check points for the loop
	mut set_max := false
	mut set_err_msg := false

	for i, line in wx.file_lines {
		if line.starts_with("set_max_arg") {
			// validate function here
			println(line)
			if wx.file_lines[i+1].starts_with("set_arg_err_msg") {
				// validate function here
				println(line)
			}
		}
	}
	return 0, ""
}

pub fn (mut wx WFX) parse_wfx() {
	// Check for perm keyword and remove
	if wx.file_type == FileTypes.wfx {
		wx.parse_perm(wx.file_lines[0])
	}

	// Check for cmd max_arguments 
	exit_c, args := wx.check_for_max_arg()

	for i, line in wx.file_lines {
		if line != "" && line.starts_with("//") == false {
			if line.starts_with("var") {
				mut var_name := ""
				mut var_type := ""
				mut var_value := ""
				//              0      1  2   3
				// Example: var[str] test = "lawl";
				split_line := line.split(" ")
				if line.contains(";") != true { 
					println("[x] Error, Expected ';' semi-colon at the end of line...")
					exit(0)
				}
				if line.replace("var", "").starts_with("[") {
					if split_line[0].ends_with("]") {
						var_type = split_line[0].replace("var[", "").replace("]", "")
						println(var_type)
						if var_type != "str" && var_type != "int" {
							println("[x] Error, Invalid datatype. str, int or fn....")
						}
					} else { 
						println("[x] Error, Expecting 'var[datatype]' datatype index for variable...")
						exit(0)
					}
				}
				var_name = split_line[1]
				match var_type {
					"int" {
						var_value = split_line[3].replace(";", "")
					}
					"str" {
						if wockyfx.char_count(line, "\"") != 2 {
							println("[x] Error, Broken quoted string. Expecting a '\"'.")
							exit(0)
						}
						var_value = wockyfx.get_str_between(line, "\"", "\"")
					}
					"fnc" {
						// parse this for the value
					} else {}
				}
				wx.add_variable(var_name, var_type, var_value)
			} else if line.starts_with("include_whfx") {
				wx.parse_whfx(i)
			} else {
				mut fn_found := false
				for fn_n, fn_max_arg in wx.functions {
					if line.starts_with(fn_n) {
						
						lul := wx.get_fnc_arg(line, fn_n)
						wx.handle_fn(fn_n, wx.fn_current_arg)
					
						fn_found = true
					}
				}
				fn_found = false
			}
		}
	}
}

pub fn (mut wx WFX) handle_fn(fn_name string, fn_args []string) {
	match fn_name {
		"sleep" {
			wx.wfx_u.wfx_sleep(fn_args[0].int())
		}
		"clear" {
			if wx.socket_toggle == true {
				wx.wfx_u.wfx_clear_socket(mut wx.socket)
			} else {
				wx.wfx_u.wfx_clear()
			}
		}
		"output_wrfx" {
			if wx.socket_toggle == true {
				// wx.wfx_u.wfx
			} else {
				wx.wfx_u.wfx_output_wrfx(wx.replace_var_code(fn_args[0].replace("\"", "")))
			}
		}
		"hide_cursor" {
			if wx.socket_toggle == true {

			} else {
				wx.wfx_u.wfx_hide_cursor()
			}
		} 
		"show_cursor" {
			if wx.socket_toggle == true {

			} else {
				wx.wfx_u.wfx_show_cursor()
			}
		} 
		"print_text" {
			if wx.socket_toggle == true {
				wx.socket.write_string(wx.replace_var_code(fn_args[0].replace("\"", ""))) or { 0 }
			} else {
				print(wx.replace_var_code(fn_args[0].replace("\"", "")))
			}
		}
		"place_text" {
			if wx.socket_toggle == true {
				wx.wfx_u.wfx_place_text_socket(fn_args[0], fn_args[1], wfx.replace_var_code(fn_args[2].replace("\"", ""), mut wx.socket))
			} else {
				wx.wfx_u.wfx_place_text(fn_args[0], fn_args[1], wfx.replace_var_code(fn_args[2].replace("\"", "")))
			}
		}
		"slow_place_text" {
			if wx.socket_toggle == true {
				
			} else {
				wx.wfx_u.wfx_slow_place_text(fn_args[0], fn_args[1], fn_args[2], fn_args[3], wfx.replace_var_code(fn_args[4].replace("\"", "")))
			}
		}
		"list_text" {
			if wx.socket_toggle == true {

			} else {
				wx.wfx_u.wfx_list_text(fn_args[0], fn_args[1], wfx.replace_var_code(fn_args[2].replace("\"", "")))
			}
		} else {}
	}
}

pub fn (mut wx WFX) parse_whfx(line_number int) {
	line := wx.file_lines[line_number]
	if line.contains("(") {} else { 
		println("[x] Error, Expecting '(' after 'include_whfx' on line ${line_number}")
		return
	}
	if line.contains(")") {} else {
		println("[x] Error, Missing ')' after include_whfx first function argument")
		return
	} 
	if line.contains(").") {} else {
		println("[x] Error, Missing '.' after include_whfx function call")
		return
	} 
	if line.contains("();") {} else {
		println("[x] Error, Missing (); at the end of the second function chain call")
		return
	}

	// get external function name
	whfx_filepath := get_str_between(line, "\"", "\"")
	ext_fn_name := get_str_between_alt(line, 2, ".", "(")

	mut whfx_filedata := os.read_lines(whfx_filepath) or { 
		println("[x] Error, Unable to read whfx file!")
		return
	}

	mut new_wfx_code := []string
	for i, whfx_line in whfx_filedata {
		if whfx_line.starts_with(ext_fn_name) {
			for ln_n in i+1..whfx_filedata.len {
				c_ln := whfx_filedata[ln_n]
				if c_ln == "}" { break }
				new_wfx_code << c_ln.trim_space()
			}
			if new_wfx_code.len > 2 {
				old_file := wx.file
				old_code := wx.file_lines
				wx.set_new_wfx_code(new_wfx_code)
				wx.parse_wfx()
				wx.file = old_file
				wx.file_lines = old_code
				return 
			}
		}
	}

	println(new_wfx_code)

	// run wfx parser now 
	old_file := wx.file
	old_code := wx.file_lines
	wx.set_new_wfx_code(new_wfx_code)
	wx.parse_wfx()
	wx.file = old_file
	wx.file_lines = old_code
}


// This function cannot stay like this. splitting between 'space' or ',' will corupt strings!
pub fn (mut wx WFX) get_fnc_arg(line string, fn_n string) int {
	// parse function here
	if line.ends_with("();") { return 1 }
	args := get_str_between(line, "(", ")").split(",")
	mut args_count := args.len
	
	if args_count == 1 && args[0] == "" { 
		args_count--
	}

	if args_count < wx.functions[fn_n] {
		println("[x] Error, Missing function arguments")
		exit(0)
	} else if args_count > wx.functions[fn_n] {
		println("Here: [x] Error, Supplied to much function arguments")
		exit(0)
	}

	wx.fn_current_arg = args
	wx.fn_args_count = args_count
	return 0
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

// returning exit_code, arg_count, []arguments
pub fn (mut wx WFX) parse_fn(line string) (int, int, []string) {
	args 			:= []string // Function arguments
	args_count 		:= 0 // Function argument count

	if line != "" {
		if line.contains("(") {} else { return 0, args_count, args }

		if line.ends_with(");") {

		} else if line.ends_with("fn() => {")  {

		} else { return 0, args_count, args }
	}
	return 1, args_count, args
}

pub fn (mut wx WFX) parse_callback_fn(file string, function string) (int, []string) {
	return 0, [""]
}

pub fn (mut wx WFX) execute_fn() {

}

pub fn (mut wx WFX) execute_callback_fn() {

}

pub fn (mut wx WFX) replace_var_code(line string) string {
	mut t := replace_code(line)
	for key, val_arr in wx.variables {
		if t.contains("{${key}}") {
			t = t.replace("{${key}}", val_arr[0])
		}
	}
	t = t.replace("{ONLINEUSERS}", wx.online_users)
	if wx.user_info != 0 {
		t = t.replace("{USERID}", wx.user_info['USERID'])
		t = t.replace("{USERNAME}", wx.user_info['username'])
		t = t.replace("{USERIP}", wx.user_info['ip'])
		t = t.replace("{PLAN}", wx.user_info['plan'])
		t = t.replace("{MAXTIME}", wx.user_info['maxtime'])
		t = t.replace("{CONN}", wx.user_info['conn'])
		t = t.replace("{ONGOING}", wx.user_info['ongoing'])
		t = t.replace("{ADMIN}", wx.user_info['admin'])
		t = t.replace("{EXPIRY}", wx.user_info['expiry'])
	}
	return t
}

pub fn replace_code(line string) string {
	mut wfxu := wockyfx.WFX_Utils{}
	mut wfx := WFX{wfx_u: &wfxu}

	mut fix := line.replace("{Default}", 			wfx.variables['Default'][0])
	fix = fix.replace(		"{Black}", 				wfx.variables['Black'][0])
	fix = fix.replace(		"{Red}", 				wfx.variables['Red'][0])
	fix = fix.replace(		"{Green}", 				wfx.variables['Green'][0])
	fix = fix.replace(		"{Yellow}", 			wfx.variables['Yellow'][0])
	fix = fix.replace(		"{Blue}", 				wfx.variables['Blue'][0])
	fix = fix.replace(		"{Purple}", 			wfx.variables['Purple'][0])
	fix = fix.replace(		"{Cyan}", 				wfx.variables['Cyan'][0])
	fix = fix.replace(		"{Light_Grey}", 		wfx.variables['Light_Grey'][0])
	fix = fix.replace(		"{Dark_Grey}", 			wfx.variables['Dark_Grey'][0])
	fix = fix.replace(		"{Light_Red}", 			wfx.variables['Light_Red'][0])
	fix = fix.replace(		"{Light_Green}", 		wfx.variables['Light_Green'][0])
	fix = fix.replace(		"{Light_Yellow}", 		wfx.variables['Light_Yellow'][0])
	fix = fix.replace(		"{Light_Blue}", 		wfx.variables['Light_Blue'][0])
	fix = fix.replace(		"{Light_Purple}", 		wfx.variables['Light_Purple'][0])
	fix = fix.replace(		"{White}", 				wfx.variables['White'][0])
	fix = fix.replace(		"{Default_BG}", 		wfx.variables['Default_BG'][0])
	fix = fix.replace(		"{Black_BG}", 			wfx.variables['Black_BG'][0])
	fix = fix.replace(		"{Red_BG}", 			wfx.variables['Red_BG'][0])
	fix = fix.replace(		"{Green_BG}", 			wfx.variables['Green_BG'][0])
	fix = fix.replace(		"{Yellow_BG}", 			wfx.variables['Yellow_BG'][0])
	fix = fix.replace(		"{Purple_BG}", 			wfx.variables['Purple_BG'][0])
	fix = fix.replace(		"{Cyan_BG}", 			wfx.variables['Cyan_BG'][0])
	fix = fix.replace(		"{Light_Gray_BG}", 		wfx.variables['Light_Gray_BG'][0])
	fix = fix.replace(		"{Dark_Gray_BG}", 		wfx.variables['Dark_Gray_BG'][0])
	fix = fix.replace(		"{Light_Red_BG}", 		wfx.variables['Light_Red_BG'][0])
	fix = fix.replace(		"{Light_Green_BG}", 	wfx.variables['Light_Green_BG'][0])
	fix = fix.replace(		"{Light_Yellow_BG}", 	wfx.variables['Light_Yellow_BG'][0])
	fix = fix.replace(		"{Light_Blue_BG}", 		wfx.variables['Light_Blue_BG'][0])
	fix = fix.replace(		"{Light_Purple_BG}", 	wfx.variables['Light_Purple_BG'][0])
	fix = fix.replace(		"{Light_Cyan_BG}", 		wfx.variables['Light_Cyan_BG'][0])
	fix = fix.replace(		"{White_BG}", 			wfx.variables['White_BG'][0])
	fix = fix.replace(		"{NEWLINE}", 			"\r\n")
	fix = fix.replace(		"{BOL}", 				"\r")
	return fix
}