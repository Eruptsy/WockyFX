import cmd
from math import perm
import os, sys, time, enum

class FileTypes(enum.Enum):
    wfx = 0
    whfx = 1
    wrfx = 2

class WFX():
    __socket_toggle     = False
    __socket            = None

    __file              = ""
    __file_data         = ""
    __file_lines        = ['']
    __file_type         = None
    __file_rank         = None
    __file_current_ln   = 0
    __fn_current_arg    = ['']
    __fn_args_count     = 0

    __whfx_file         = ""
    __whrx_fnc          = ""
    __whfx_fnc_data     = ""

    perm                = {
        "free": 0,
        "premium": 1,
        "reseller": 2,
        "admin": 3,
        "owner": 4
    }

    datatyes            = ['int, string']

    functions           = {
        'sleep': 2,
        'clear':				0,
		'hide_cursor': 		0,
		'show_cursor': 		0,
		'print_text':			1,
		'place_text': 			3,
		'slow_place_text': 	5,
		'list_text': 			3,
		'slow_list_text':		3,
		'set_term_size': 		2,
		'change_term_title':	1,
		'move_cursor':			1,
		'include_whfx':		1, ## inside parse_wfx() ( not handler_fn() )
		'output_wrfx':			1,
		## Returning Functions
		'get_args': 			0,
		## Special Functions
		'geo_ip':				1,
		'port_scan':			1,
		'send_attack':			3,
		## Error Handlers
		'set_max_arg':			1,
		'set_arg_err_msg':		-1 ## Do not detect the amount of argument for this function
    }

    variables 	        = {
		'Default': ['\x1b[39m', 'str'],
		'Black': ['\x1b[30m', 'str'],
		'Red': ['\x1b[31m', 'str'],
		'Green': ['\x1b[32m', 'str'],
		'Yellow': ['\x1b[33m', 'str'],
		'Blue': ['\x1b[34m', 'str'],
		'Purple': ['\x1b[35m', 'str'],
		'Cyan': ['\x1b[36m', 'str'],
		'Light_Grey': ['\x1b[37m', 'str'],
		'Dark_Grey': ['\x1b[90m', 'str'],
		'Light_Red': ['\x1b[91m', 'str'],
		'Light_Green': ['\x1b[92m', 'str'],
		'Light_Yellow': ['\x1b[93m', 'str'],
		'Light_Blue': ['\x1b[94m', 'str'],
		'Light_Purple': ['\x1b[95m', 'str'],
		'Light_Cyan': ['\x1b[96m', 'str'],
		'White': ['\x1b[97m', 'str'],
		'Default_BG': ['\x1b[49m', 'str'],
		'Black_BG': ['\x1b[40m', 'str'],
		'Red_BG': ['\x1b[41m', 'str'],
		'Green_BG': ['\x1b[42m', 'str'],
		'Yellow_BG': ['\x1b[43m', 'str'],
		'Blue_BG': ['\x1b[44m', 'str'],
		'Purple_BG': ['\x1b[45m', 'str'],
		'Cyan_BG': ['\x1b[46m', 'str'],
		'Light_Gray_BG': ['\x1b[47m', 'str'],
		'Dark_Gray_BG': ['\x1b[100m', 'str'],
		'Light_Red_BG': ['\x1b[101m', 'str'],
		'Light_Green_BG': ['\x1b[102m', 'str'],
		'Light_Yellow_BG': ['\x1b[103m', 'str'],
		'Light_Blue_BG': ['\x1b[104m', 'str'],
		'Light_Purple_BG': ['\x1b[105m', 'str'],
		'Light_Cyan_BG': ['\x1b[106m', 'str'],
		'White_BG': ['\x1b[107m', 'str'],
		'Clear': ['\033[2J\033[1;1H', 'str']
    }

    __fcmd                = ""
    __cmd                 = ""
    __cmd_args            = ['']

    __user_info           = None
    __online_users        = ""

    def __init__(self, file: str):
        self.__filepath = file
        if os.path.exists(file) != True:
            print("[x] Error, Unable to read or locate file!")
            exit(0)
            

    def parse() -> None:
        pass

class WFX_Core:
    def sleep(c: int) -> None:
        time.sleep(c)
    
    def clear() -> None:
        print("")

    def hide_cursor() -> None:
