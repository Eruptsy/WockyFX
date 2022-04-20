package me.c1tad31.wocky4j;

import me.c1tad31.wocky4j.enums.FileRanks;
import me.c1tad31.wocky4j.enums.FileTypes;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.ServerSocket;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

    // trying to find a better way to do this
    // private final Map<String, Integer> perms = new HashMap<>();
    // private final String[] dataTypes = {"int", "for"};

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
