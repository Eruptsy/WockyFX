package me.c1tad31.wocky4j.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;

public class WfxSocketFns extends Utils {

    private PrintWriter writer;

    public void wfxClearSocket(Socket socket) {
        setUni("\033[2J\033[1;1H", socket);
    }

    public void wfxHideCursorSocket(Socket socket) {
        setUni("\033[?25l", socket);
    }

    public void wfxShowCursorSocket(Socket socket) {
        setUni("\033[?25h\033[?0c", socket);
    }

    public void wfxSetTermSizeSocket(String r, String c, Socket socket) {
        setUni("\033[8;${r};${c}t", socket);
    }

    public void wfxChangeTermTitleSocket(String t, Socket socket) {
        setUni("\033]0;${t}\007", socket);
    }

    public void wfxMoveCursorSocket(String r, String c, Socket socket) {
        setUni("\033[${r};${c}f", socket);
    }

    public void wfxPlaceTextSocket(String r, String c, String t, Socket socket) {
        setUni("\033[${r};${c}f${t}", socket);
    }

    public void setUni(String uni, Socket socket) {
        try {
            writer = new PrintWriter(socket.getOutputStream(), true);
            writer.write(uni);
        } catch (IOException e) {
            System.exit(0);
            e.printStackTrace();
        }
    }
}
