package me.c1tad31.wocky4j.controllers;

import me.c1tad31.wocky4j.enums.FileRanks;
import me.c1tad31.wocky4j.enums.FileTypes;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
    private String[] fnCurrentArg;
    private int fnArgsCount;
    private Map<String, String> userInfo = new HashMap<>();

    private Utils utils = new Utils();

    private final Map<String, Integer> perms = new HashMap<>() {{
        put("free", 0);
        put("premium", 1);
        put("reseller", 2);
        put("admin", 3);
        put("owner", 4);
    }};
    private final Map<String, Integer> functions = new HashMap<>() {{
        put("sleep", 1);
        put("clear", 1);
        put("hide_cursor", 0);
        put("show_cursor", 0);
        put("print_text", 1);
        put("place_text", 3);
        put("show_place_text", 3);
        put("list_text", 3);
        put("show_list_text", 3);
        put("set_term_size", 1);
        put("change_term_title", 1);
        put("move_cursor", 1);
        put("include_wfx", 1);
        put("output_wrfx", 1);
        put("get_args", 0);
        put("geo_ip", 1);
        put("port_scan", 1);
        put("send_attack", 3);
        put("set_max_arg", 1);
        put("set_arg_err_msg", -1);
    }};
    private final Map<String, String> variables = new HashMap<>() {{
        put("Default", "\\x1b[39m");
        put("Default", "\\x1b[39m");
        put("Black", "\\x1b[30m");
        put("Red", "\\x1b[31m");
        put("Green", "\\x1b[32m");
        put("Yellow", "\\x1b[33m");
        put("Blue", "\\x1b[34m");
        put("Purple", "\\x1b[35m");
        put("Cyan", "\\x1b[36m");
        put("Light_Grey", "\\x1b[37m");
        put("Dark_Grey", "\\x1b[90m");
        put("Light_Red", "\\x1b[91m");
        put("Light_Green", "\\x1b[92m");
        put("Light_Yellow", "\\x1b[93m");
        put("Light_Blue", "\\x1b[94m");
        put("Light_Purple", "\\x1b[95m");
        put("Light_Cyan", "\\x1b[96m");
        put("White", "\\x1b[97m");
        put("Default_BG", "\\x1b[49m");
        put("Black_BG", "\\x1b[40m");
        put("Red_BG", "\\x1b[41m");
        put("Green_BG", "\\x1b[42m");
        put("Yellow_BG", "\\x1b[43m");
        put("Blue_BG", "\\x1b[44m");
        put("Purple_BG", "\\x1b[45m");
        put("Cyan_BG", "\\x1b[46m");
        put("Light_Gray_BG", "\\x1b[47m");
        put("Dark_Gray_BG", "\\x1b[100m");
        put("Light_Red_BG", "\\x1b[101m");
        put("Light_Green_BG", "\\x1b[102m");
        put("Light_Yellow_BG", "\\x1b[103m");
        put("Light_Blue_BG", "\\x1b[104m");
        put("Light_Purple_BG", "\\x1b[105m");
        put("Light_Cyan_BG", "\\x1b[106m");
        put("White_BG", "\\x1b[107m");
        put("Clear", "\\033[2J\\033[1;1H");
    }};
    private final String[] dataTypes = {"int", "string"};

    public void enableSocket(ServerSocket s) {
        socketToggle = true;
        s = socket;
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

    public void fncArg(String line, String fnN) throws UnsupportedEncodingException {
        String args = utils.getStrBetween(line, "(", ")");
        int argCount = args.length();

        // if (argCount < functions[fnN]) {
        //     System.out.println("[x] Error, Missing function arguments");
        //     System.exit(0);
        // } else if (argCount > functions[fnN]) {
        //     System.out.println("[x] Error, Supplied to much function arguments");
        //     System.exit(0);
        // } else {
        //     System.out.println("[x] Error, Unknown error please contact an admin to correct this issue!");
        // }

        // fnCurrentArg = args;
        fnArgsCount = argCount;

    }

    /**
     * @author Citadel
     * @param line tells the library what permission to set the file to
     */

    public void parsePerms(String permission) {
        if (permission.startsWith("perm")) {
            String rank = permission.split(" ")[1];
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
        System.out.println(String.format("your file is set to \"%s\" permission", fileRanks));
    }

    /**
     * @author Citadel
     * @param set the pers
     */

    public int parseFn(String function) {
        String[] args;
        int argsCount = 0;

        if (!function.equals("")) {
            if (function.contains("(")) {

            } else {
                return 0;

            }
        }

        return 1;

    }

    public void executeFn() {

    }

    public void executeCallbackFn() {

    }

    public void replaceCode(String line) {
        String newValue = "";
    }

}
