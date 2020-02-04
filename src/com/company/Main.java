package com.company;

import com.company.lexer.Lexer;
import com.company.lexer.Symbol;

import java.io.File;
import java.io.FileReader;
import java.io.PrintWriter;

public class Main {

    public static void main(String[] args) throws Exception {
        if (args.length < 2) {
            System.err.println("USAGE: java Main <OPTION> <FILENAME>");
            System.exit(1);
        }

        Main main = new Main();

        switch (args[0]) {
            case "--lex": {
                main.lex(args);
            }
            break;
            case "--ast": {
                throw new Exception();
            }
            default: {
                System.err.println("Invalid option " + args[0]);
            }
        }
    }

    private void lex(String[] args) {
        for (int i = 1; i < args.length; i++) {
            try {
                if (!isFileValid(args[i])) {
                    continue;
                }

                System.out.println("Lexing file [" + args[i] + "]");

                Lexer lexer = new Lexer(new FileReader(args[i]));
                PrintWriter printWriter = new PrintWriter(getFileName(args[i]) + ".lexed", "UTF-8");

                Symbol symbol = lexer.yylex();
                while (symbol != null)
                {
                    printWriter.println(symbol);
                    symbol = lexer.yylex();
                }

                printWriter.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
                System.exit(1);
            }

            System.out.println("Generated output file");
        }
    }

    private boolean isFileValid(String filename) {
        File file = new File(filename);

        if (!file.exists()) {
            System.err.println(filename + ": No such file!");
            return false;
        }

        String fileExtension = getFileExtension(file);
        if (!"pas".equals(fileExtension)) {
            System.err.println(filename + ": Invalid file extension!");
            return false;
        }

        return true;
    }

    private String getFileExtension(File file) {
        String name = file.getName();

        try {
            return name.substring(name.lastIndexOf(".") + 1);
        } catch (Exception e) {
            return "";
        }
    }

    private String getFileName(String filename) {
        try {
            return filename.substring(0, filename.lastIndexOf("."));
        } catch (Exception e) {
            return "";
        }
    }

    private String getFileDirPath(String filename) {
        try {
            File f = new File(filename);
            String path = f.getParent();
            if (path == null) {
                return "";
            }
            return path + File.separator;
        } catch (Exception e) {
            return "";
        }
    }
}
