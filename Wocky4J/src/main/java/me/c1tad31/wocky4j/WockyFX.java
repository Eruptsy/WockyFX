package me.c1tad31.wocky4j;

import me.c1tad31.wocky4j.enums.FileRanks;
import me.c1tad31.wocky4j.enums.FileTypes;

import java.net.ServerSocket;

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

    // trying to find a better way to do this
    // private final Map<String, Integer> perms = new HashMap<>();
    // private final String[] dataTypes = {"int", "for"};

    public void wfxFile(String filePath, FileTypes fileTypes1) {
        // Logic for wfx files
    }

    public void setCmdInfo(String fcmd, String cmd, String[] args) {
        filefcmd = fcmd;
        filecmd = cmd;
        cmdArgs = args;

    }

    public void setCurrentInfo() {

    }

    public void parseWfx() {
        // Check for perm keyword and remove

    }

    public void checkforMaxArgs() {
        // Info from file
        int maxArgs = 0;
        String maxArgsError = "";

        boolean setMax = false;
        boolean setErrorMessage = false;

        // Logic for checking max args
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
