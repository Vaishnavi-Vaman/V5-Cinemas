package com.V5.util;



public class DurationUtil {

    // Convert minutes → "Xh Ym"
    public static String formatDuration(int minutes) {
        int hours = minutes / 60;
        int mins = minutes % 60;
        if (hours > 0) {
            return hours + "h " + (mins > 0 ? mins + "m" : "");
        } else {
            return mins + "m";
        }
    }

    // Optional: Convert "2h 15m" → minutes
    public static int parseDuration(String input) {
        int totalMinutes = 0;
        input = input.toLowerCase().trim();

        String[] parts = input.split(" ");
        for (String part : parts) {
            if (part.endsWith("h")) {
                totalMinutes += Integer.parseInt(part.replace("h", "")) * 60;
            } else if (part.endsWith("m")) {
                totalMinutes += Integer.parseInt(part.replace("m", ""));
            } else {
                totalMinutes += Integer.parseInt(part); // raw minutes
            }
        }
        return totalMinutes;
    }
}
