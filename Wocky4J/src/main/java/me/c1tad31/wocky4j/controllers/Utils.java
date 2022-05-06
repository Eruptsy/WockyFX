package me.c1tad31.wocky4j.controllers;

import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Utils {

    public boolean checkForWfxFile(String filename) {
        String filePath = "/assets/wockyfx/" + filename + ".wfx";
        if (Files.exists(Path.of(filePath))) {
            return true;
        }

        return false;
    }

    public boolean checkForWfxCmd(String filename) {
        String filePath = "/assets/wockyfx/" + filename + "_cmd.wfx";
        if (Files.exists(Path.of(filePath))) {
            return true;
        }
        return false;
    }
    
    public void charCount(String str, String cha) {
        // byte[] bytes = s.getBytes("US-ASCII");
        int countChar = 0;

        
    }

    public String getStrBetween(String t, String start, String end) throws UnsupportedEncodingException {
        String newStr = "";
        boolean ignore = true;

        // Logic here

        return newStr;
    }

}
