import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF0057FF);
  static const Color backgroundColor = Color(0xFFE8EEFC);
  static const Color fontBlackColor = Color(0xFF030617);
  static const Color fontBlueColor = Color(0xFF2878EF);
  static const Color backgroundMeterColor = Color.fromARGB(255, 193, 212, 255);
  static const Color cardItemBgColor = Color(0xFFCED9F0);
  static const Color subtitleTextColor = Color(0xFF807777);
  static const Color chatbotBubbleColor = Color.fromARGB(255, 193, 212, 255);
  static const serebotPath = 'assets/images/home/menu/serebot.png';

  // Dark theme colors
  static const Color darkPrimaryColor = Color(0xFF4685FF);
  static const Color darkBackgroundColor = Color.fromARGB(255, 49, 55, 70);
  static const Color darkFontBlackColor = Color(0xFFF4F5F7);
  static const Color darkFontBlueColor = Color(0xFF5A9BFF);
  static const Color darkBackgroundMeterColor = Color.fromARGB(255, 50, 60, 85);
  static const Color darkCardItemBgColor = Color(0xFF3A4358);
  static const Color darkSubtitleTextColor = Color(0xFFB0B3BC);
  static const Color darkChatbotBubbleColor = Color.fromARGB(255, 75, 77, 79);
  static const darkSerebotPath = 'assets/images/home/menu/serebot_dark.png';

  // Theme data
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: fontBlueColor,
      surface: backgroundColor,
      // background: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: fontBlackColor,
      // onBackground: fontBlackColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: fontBlackColor,
      elevation: 0,
    ),
    cardTheme: const CardTheme(
      color: cardItemBgColor,
      elevation: 2,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: fontBlackColor),
      bodyMedium: TextStyle(color: fontBlackColor),
      titleLarge: TextStyle(color: fontBlackColor),
      titleMedium: TextStyle(color: fontBlackColor),
      titleSmall: TextStyle(color: subtitleTextColor),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: fontBlueColor,
      surface: darkBackgroundColor,
      // background: darkBackgroundColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: darkFontBlackColor,
      // onBackground: darkFontBlackColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackgroundColor,
      foregroundColor: darkFontBlackColor,
      elevation: 0,
    ),
    cardTheme: const CardTheme(
      color: darkCardItemBgColor,
      elevation: 2,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkFontBlackColor),
      bodyMedium: TextStyle(color: darkFontBlackColor),
      titleLarge: TextStyle(color: darkFontBlackColor),
      titleMedium: TextStyle(color: darkFontBlackColor),
      titleSmall: TextStyle(color: darkSubtitleTextColor),
    ),
  );

  // Helper methods to get colors based on current theme
  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkPrimaryColor
        : primaryColor;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundColor
        : backgroundColor;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCardItemBgColor
        : cardItemBgColor;
  }

  static Color getFontColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkFontBlackColor
        : fontBlackColor;
  }

  static Color getSubtitleColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSubtitleTextColor
        : subtitleTextColor;
  }

  static Color getMeterBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundMeterColor
        : backgroundMeterColor;
  }

  static Color getOutlineButtonColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundMeterColor
        : backgroundColor;
  }

  static Color getChatbotBubbleColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkChatbotBubbleColor
        : chatbotBubbleColor;
  }

  static String getSerebotPath(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSerebotPath
        : serebotPath;
  }
}
