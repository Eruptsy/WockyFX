import cmd
from math import perm
import os, sys, time, enum


class FileTypes(enum.Enum):
    wfx = 0
    whfx = 1
    wrfx = 2

class Perms(enum.Enum):
    free = 0
    premium = 1
    reseller = 2
    admin = 3
    owner = 4

class WFX():
    __socket_toggle = False
    __socket = None

    __file = ""
    __file_data = ""
    __file_lines = ['']
    __file_type = None
    __file_rank = None
    __file_current_ln = 0
    __fn_current_arg = ['']
    __fn_args_count = 0

    __whfx_file = ""
    __whrx_fnc = ""
    __whfx_fnc_data = ""

    perm = {
        "free": 0,
        "premium": 1,
        "reseller": 2,
        "admin": 3,
        "owner": 4
    }

    datatyes = ['int, string', 'fnc']

    """
        FUNCTION NAME: [FUNCTION_TYPE, FUNCTION_ARGUMENT]
    """
    functions = {
        'sleep': ['void', 2],
        'clear': ['void', 0],
        'hide_cursor': ['void', 0],
        'show_cursor': ['void', 0],
        'print_text': ['void', 1],
        'place_text': ['void', 3],
        'slow_place_text': ['void', 5],
        'list_text': ['void', 3],
        'slow_list_text': ['void', 3],
        'set_term_size': ['void', 2],
        'change_term_title': ['void', 1],
        'move_cursor': ['void', 1],
        'include_whfx': ['void', 1],  ## inside parse_wfx() ( not handler_fn() )
        'output_wrfx': ['void', 1],
        ## Returning Functions
        'get_args': ['str', 0],
        ## Special Functions
        'geo_ip': ['str', 1],
        'port_scan': ['str', 1],
        'send_attack': ['void', 3], ## Might change to returning string
        ## Error Handlers
        'set_max_arg': ['void', 1],
        'set_arg_err_msg': ['void' -1]  ## Do not detect the amount of argument for this function
    }

    """
        VARIABLE_NAME: [VARIABLE_VALUE, VARIABLE_TYPE]
    """
    variables = {
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

    __fcmd = ""
    __cmd = ""
    __cmd_args = ['']

    __user_info = None
    __online_users = ""

    def __init__(self, file: str):
        self.__file = file
        if os.path.exists(file) != True:
            print("[x] Error, Unable to read or locate file!")
            exit(0)

        try:
            self.__file_data = open(self.__file, "r").read()
        except:
            print("[x] Error, Unable to read file!")
            exit(0)

        if self.__file_data == "" | len(self.__file_data) == 0: 
            print("[x] Error, No file data to parse!")
            exit(0)

        self.__file_lines = self.__file_data.split("\n")

        if "_cmd.wfx" in self.__file | self.__file.endswith(".wfx"):
            self.__file_type = FileTypes.wfx
        elif self.__file.endswith(".whfx"):
            self.__file_type = FileTypes.whfx
        elif self.__file.endswith(".wrfx"):
            self.__file_type = FileTypes.wrfx
    
    def set_buffer(self, fcmd: str, cmd: str, args: str) -> None:
        self.__fcmd = fcmd
        self.__cmd = cmd
        self.__cmd_args = args

    def parse(self) -> None:
        if self.__file_lines[0].startswith("perm"):
            self.parse_perm(self.__file_lines[0])
        
        for i, line in self.__file_lines:
            if line != "" and line.startswith("//") == False:
                if line.startswith("var"):
                    ## Variable found
                    pass
                elif line.startswith("include_whfx"):
                    pass
                elif line.contains("(fnc() => {"):
                    pass
            self.__file_current_ln = i

    def parse_perm(self, line: str) -> None:
        """ 
            This can be optimized later using a match statement with Python3.10
        """
        if line.endswith("free;"):
            self.__file_rank = Perms.free
        elif line.endswith("premium;"):
            self.__file_rank = Perms.premium
        elif line.endswith("reseller;"):
            self.__file_rank = Perms.reseller
        elif line.endswith("admin"):
            self.__file_rank = Perms.admin
