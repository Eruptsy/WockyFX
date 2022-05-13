import os, sys, time

def get_callback_code(function_name: str, file_data: list) -> list:
    new_code = []
    for i, line in file_data:
        if line != "":
            if line.startswith(function):
                if line.contains("(fnc() => {") == False: return []
                start_here = i+1
                for new_line in range(start_here, len(file_data)):
                    if file_data[new_line] == "});" | file_data[new_line].contains("});"):
                        return new_code
                    else:
                        new_code.append(file_data[new_line])
    return []