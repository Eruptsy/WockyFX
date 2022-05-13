from distutils import text_file
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

def char_count(text: str, find_char: str) -> int:
    char_count = 0
    for i in range(len(text)):
        char = text[i]
        if char == find_char:
            char_count+=1
    return char_count

def get_str_between(text:str, start: str, end: str) -> str:
    new_str = ""
    ignore = True
    for i in range(len(text)):
        char = text[i]
        if char == start and ignore == True:
            ignore = False
        elif char == end and ignore == False:
            return new_str
        elif ignore == False:
            new_str += char
    return new_str