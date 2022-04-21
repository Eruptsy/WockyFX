package me.c1tad31.wocky4j;

import me.c1tad31.wocky4j.enums.FileRanks;
import me.c1tad31.wocky4j.enums.FileTypes;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class WockyFX {
    private ServerSocket socket;
    private boolean socketToggle;
    private String file;
    private String fileData;
    private String[] fileLines;
    private FileTypes fileTypes;
    private FileRanks fileRanks;
    private String filefcmd;
    private String filecmd;
    private String[] cmdArgs;
    private String onlineUsers;

    // trying to find a better way to do this
    private final Map<String, Integer> perms = new HashMap<>();
    private final Map<String, Integer> functions = new HashMap<>();
    private final Map<String, String> variables = new HashMap<>();
    // private final String[] dataTypes = {"int", "for"};

    public void handlePerms() {
        perms.put("free", 0);
        perms.put("premium", 1);
        perms.put("reseller", 2);
        perms.put("admin", 3);
        perms.put("owner", 4);
    }

    public void handleFunctions() {
        functions.put("sleep", 1);
        functions.put("clear", 1);
        functions.put("hide_cursor", 0);
        functions.put("show_cursor", 0);
        functions.put("print_text", 1);
        functions.put("place_text", 3);
        functions.put("show_place_text", 3);
        functions.put("list_text", 3);
        functions.put("show_list_text", 3);
        functions.put("set_term_size", 1);
        functions.put("change_term_title", 1);
        functions.put("move_cursor", 1);
        functions.put("include_wfx", 1);
        functions.put("output_wrfx", 1);
        functions.put("get_args", 0);
        functions.put("geo_ip", 1);
        functions.put("port_scan", 1);
        functions.put("send_attack", 3);
        functions.put("set_max_arg", 1);
        functions.put("set_arg_err_msg", -1);
    }

    public void handleVariables() {
        variables.put("Default", "\\x1b[39m");
        variables.put("Black", "\\x1b[30m");
        variables.put("Red", "\\x1b[31m");
        variables.put("Green", "\\x1b[32m");
        variables.put("Yellow", "\\x1b[33m");
        variables.put("Blue", "\\x1b[34m");
        variables.put("Purple", "\\x1b[35m");
        variables.put("Cyan", "\\x1b[36m");
        variables.put("Light_Grey", "\\x1b[37m");
        variables.put("Dark_Grey", "\\x1b[90m");
        variables.put("Light_Red", "\\x1b[91m");
        variables.put("Light_Green", "\\x1b[92m");
        variables.put("Light_Yellow", "\\x1b[93m");
        variables.put("Light_Blue", "\\x1b[94m");
        variables.put("Light_Purple", "\\x1b[95m");
        variables.put("Light_Cyan", "\\x1b[96m");
        variables.put("White", "\\x1b[97m");
        variables.put("Default_BG", "\\x1b[49m");
        variables.put("Black_BG", "\\x1b[40m");
        variables.put("Red_BG", "\\x1b[41m");
        variables.put("Green_BG", "\\x1b[42m");
        variables.put("Yellow_BG", "\\x1b[43m");
        variables.put("Blue_BG", "\\x1b[44m");
        variables.put("Purple_BG", "\\x1b[45m");
        variables.put("Cyan_BG", "\\x1b[46m");
        variables.put("Light_Gray_BG", "\\x1b[47m");
        variables.put("Dark_Gray_BG", "\\x1b[100m");
        variables.put("Light_Red_BG", "\\x1b[101m");
        variables.put("Light_Green_BG", "\\x1b[102m");
        variables.put("Light_Yellow_BG", "\\x1b[103m");
        variables.put("Light_Blue_BG", "\\x1b[104m");
        variables.put("Light_Purple_BG", "\\x1b[105m");
        variables.put("Light_Cyan_BG", "\\x1b[106m");
        variables.put("White_BG", "\\x1b[107m");
        variables.put("Clear", "\\033[2J\\033[1;1H");
    }

    public void wfxFile(String filePath, FileTypes fileTypes1) throws IOException, URISyntaxException {
        Path path = Paths.get(getClass().getClassLoader().getResource(filePath).toURI());

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

        // Check for max arguments

    }

    public void checkforMaxArgs() {
        // Info from file
        int maxArgs = 0;
        String maxArgsError = "";

        boolean setMax = false;
        boolean setErrorMessage = false;
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
            }
        }
    }

}
