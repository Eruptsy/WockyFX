package me.c1tad31.wocky4j;

import me.c1tad31.wocky4j.enums.FileTypes;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException, URISyntaxException {
        // For Debugging purposes only (not for production use)
        // System.out.println("Hello World!");

        WockyFX wockyFX = new WockyFX();

        while (true) {
            Scanner scanner = new Scanner(System.in);
            System.out.print(">>> ");
            String cmdIn = scanner.nextLine();

            wockyFX.setFile(cmdIn, FileTypes.WFX);
            wockyFX.parseWfx();
        }
    }
}
