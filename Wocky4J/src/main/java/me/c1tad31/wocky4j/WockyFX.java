package me.c1tad31.wocky4j;

import me.c1tad31.wocky4j.enums.FileRanks;
import me.c1tad31.wocky4j.enums.FileTypes;

import java.io.IOException;
import java.net.ServerSocket;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class WockyFX {
    private ServerSocket socket;
    private boolean socketToggle = false;
    private String file;
    private String fileData;
    private String[] fileLines;
    private FileTypes fileTypes;
    private FileRanks fileRanks;
    private String filefcmd;
    private String filecmd;
    private String[] cmdArgs;
    private String onlineUsers;

    private final Map<String, Integer> perms = new HashMap<>();
    private final Map<String, Integer> functions = new HashMap<>();
    private final Map<String, String> variables = new HashMap<>();
    private final String[] dataTypes = {"int", "string"};

    public void enableSocket(ServerSocket s) {
        socketToggle = true;
        s = socket;
    }

    public void handlePerms(String perm) {
        switch (perm) {
            case "free": perms.put("free", 0);
            case "premium": perms.put("premium", 1);
            case "reseller": perms.put("reseller", 2);
            case "admin": perms.put("admin", 3);
            case "owner": perms.put("owner", 4);
        }
    }

    public void handleFunctions(String func) {
        switch (func) {
            case "sleep": functions.put("sleep", 1);
            case "clear": functions.put("clear", 1);
            case "hide_cursor": functions.put("hide_cursor", 0);
            case "show_cursor": functions.put("show_cursor", 0);
            case "print_text": functions.put("print_text", 1);
            case "place_text": functions.put("place_text", 3);
            case "show_place_text": functions.put("show_place_text", 3);
            case "list_text": functions.put("list_text", 3);
            case "show_list_text": functions.put("show_list_text", 3);
            case "set_term_size": functions.put("set_term_size", 1);
            case "change_term_title": functions.put("change_term_title", 1);
            case "move_cursor": functions.put("move_cursor", 1);
            case "include_wfx": functions.put("include_wfx", 1);
            case "output_wrfx": functions.put("output_wrfx", 1);
            case "get_args": functions.put("get_args", 0);
            case "geo_ip": functions.put("geo_ip", 1);
            case "port_scan": functions.put("port_scan", 1);
            case "send_attack": functions.put("send_attack", 3);
            case "set_max_arg": functions.put("set_max_arg", 1);
            case "set_arg_err_msg": functions.put("set_arg_err_msg", -1);
        }
    }

    public void handleVariables(String color) {
        switch (color) {
            case "default": variables.put("Default", "\\x1b[39m");
            case "black": variables.put("Black", "\\x1b[30m");
            case "red": variables.put("Red", "\\x1b[31m");
            case "green": variables.put("Green", "\\x1b[32m");
            case "yellow": variables.put("Yellow", "\\x1b[33m");
            case "blue": variables.put("Blue", "\\x1b[34m");
            case "purple": variables.put("Purple", "\\x1b[35m");
            case "cyan": variables.put("Cyan", "\\x1b[36m");
            case "lg": variables.put("Light_Grey", "\\x1b[37m");
            case "dg": variables.put("Dark_Grey", "\\x1b[90m");
            case "lr": variables.put("Light_Red", "\\x1b[91m");
            case "lgr": variables.put("Light_Green", "\\x1b[92m");
            case "ly": variables.put("Light_Yellow", "\\x1b[93m");
            case "lb": variables.put("Light_Blue", "\\x1b[94m");
            case "lp": variables.put("Light_Purple", "\\x1b[95m");
            case "lc": variables.put("Light_Cyan", "\\x1b[96m");
            case "white": variables.put("White", "\\x1b[97m");
            case "dbg": variables.put("Default_BG", "\\x1b[49m");
            case "bbg": variables.put("Black_BG", "\\x1b[40m");
            case "rbg": variables.put("Red_BG", "\\x1b[41m");
            case "gbg": variables.put("Green_BG", "\\x1b[42m");
            case "ybg": variables.put("Yellow_BG", "\\x1b[43m");
            case "blbg": variables.put("Blue_BG", "\\x1b[44m");
            case "pbg": variables.put("Purple_BG", "\\x1b[45m");
            case "cbg": variables.put("Cyan_BG", "\\x1b[46m");
            case "lgbg": variables.put("Light_Gray_BG", "\\x1b[47m");
            case "dgbg": variables.put("Dark_Gray_BG", "\\x1b[100m");
            case "lrbg": variables.put("Light_Red_BG", "\\x1b[101m");
            case "light_green_bg": variables.put("Light_Green_BG", "\\x1b[102m");
            case "light_yellow_bg": variables.put("Light_Yellow_BG", "\\x1b[103m");
            case "light_blue_bg": variables.put("Light_Blue_BG", "\\x1b[104m");
            case "light_purple_bg": variables.put("Light_Purple_BG", "\\x1b[105m");
            case "light_cyan_bg": variables.put("Light_Cyan_BG", "\\x1b[106m");
            case "whitebg": variables.put("White_BG", "\\x1b[107m");
            case "clear": variables.put("Clear", "\\033[2J\\033[1;1H");
        }
    }

    public void setFile(String filePath, FileTypes fileTypes1) throws IOException {
        // NPE
        // Path path = Paths.get(getClass().getClassLoader().getResource(filePath).toURI());
        Path path = Paths.get(filePath);

        Stream<String> lines = Files.lines(path);
        String data = lines.collect(Collectors.joining("\n"));

        if (data.equals("")) {
            System.err.println("[x] Error, This WFX files contains no data!");
            return;
        }

        file = filePath;
        fileData = data;
        fileLines = data.split("\n");
    }

    public void setCmdInfo(String fcmd, String cmd, String[] args) {
        filefcmd = fcmd;
        filecmd = cmd;
        cmdArgs = args;

    }

    public void setCurrentInfo() {

    }

    public void parseWfx() {
        if (fileTypes.equals(FileTypes.WFX)) {
            parsePerms(fileLines[0]);
        }

        

    }

    public void checkForMaxArgs() {
        // Info from file
        int maxArgs = 0;
        String maxArgsError = "";

        boolean setMax = false;
        boolean setErrorMessage = false;

    }

    public void fncArg(String line) {
        
    }

    public void parsePerms(String line) {
        if (line.startsWith("perm")) {
            String rank = line.split(" ")[1];
            switch (rank) {
                case "free":
                    fileRanks = FileRanks.FREE;
                case "premium":
                    fileRanks = FileRanks.PREMIUM;
                case "reseller":
                    fileRanks = FileRanks.RESELLER;
                case "admin":
                    fileRanks = FileRanks.ADMIN;
                case "owner":
                    fileRanks = FileRanks.OWNER;
                default:
                    System.err.println("Unknown entry please contact an admin to correct this");
                    System.exit(0);
            }
        }
    }

}
