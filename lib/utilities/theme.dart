import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

import 'constants/constants.dart';

class AppTheme {
  ThemeData lightTheme(Color primaryColor, fontSize) {
    final lightTheme = ThemeData.light();
    return lightTheme.copyWith(
      primaryColor: primaryColor,
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: CrColors.primaryColorswatch),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        iconTheme: const IconThemeData(
          color: Color(0xFFFFFFFF),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarTextStyle: GoogleFonts.poppinsTextTheme().bodyText2,
        titleTextStyle: GoogleFonts.poppinsTextTheme().headline6,
      ),
      // cardTheme: CardTheme(color: CrColors.tertiaryolor),
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(
            fontSize: fontSize + 13,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w600),
        headline2: GoogleFonts.poppins(
            fontSize: fontSize + 6.0,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w600),
        subtitle1: GoogleFonts.poppins(
            fontSize: fontSize + 1.0,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w700),
        subtitle2: GoogleFonts.poppins(
            fontSize: fontSize + 3.0,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w500),
        bodyText1: GoogleFonts.poppins(
            fontSize: fontSize + 3.0,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w400),
        bodyText2: GoogleFonts.poppins(
            fontSize: fontSize + 1.0,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w500),
        caption: GoogleFonts.poppins(
            fontSize: fontSize + 1,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w400),
        headline5: GoogleFonts.poppins(
            fontSize: fontSize + 1,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w300),
        headline6: GoogleFonts.poppins(
            fontSize: fontSize - 1,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w300),
        button: GoogleFonts.poppins(
            fontSize: fontSize,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w700),
      ),
      errorColor: const Color.fromARGB(255, 237, 81, 70),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade500,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white.withOpacity(0.95),
      ),
   
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: CrColors.primaryColor),
    );
  }

  ThemeData darkTheme(Color primaryColor, fontSize) {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: CrColors.primaryColorswatch, 
          
          ),
      appBarTheme: AppBarTheme(
        color: const Color.fromARGB(255, 11, 66, 87),
        iconTheme: IconThemeData(
          color: Colors.grey.shade100,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarTextStyle: GoogleFonts.poppinsTextTheme()
            .apply(
              displayColor: Colors.white,
              bodyColor: Colors.grey[100],
            )
            .bodyText2,
        titleTextStyle: GoogleFonts.poppinsTextTheme()
            .apply(
              displayColor: Colors.white,
              bodyColor: Colors.grey[100],
            )
            .headline6,
      ),
      // cardTheme: CardTheme(color: Colors.grey[800]),
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(
            fontSize: fontSize + 13,
            color: Colors.grey[200],
            fontWeight: FontWeight.w600),
        headline2: GoogleFonts.poppins(
            fontSize: fontSize + 6.0,
            color: Colors.grey[200],
            fontWeight: FontWeight.w600),
        subtitle1: GoogleFonts.poppins(
            fontSize: fontSize + 1.0,
            color: Colors.grey[200],
            fontWeight: FontWeight.w700),
        subtitle2: GoogleFonts.poppins(
            fontSize: fontSize + 3.0,
            color: Colors.grey[200],
            fontWeight: FontWeight.w500),
        bodyText1: GoogleFonts.poppins(
            fontSize: fontSize + 3.0,
            color: Colors.grey[200],
            fontWeight: FontWeight.w400),
        bodyText2: GoogleFonts.poppins(
            fontSize: fontSize + 1.0,
            color: Colors.grey[200],
            fontWeight: FontWeight.w500),
        caption: GoogleFonts.poppins(
            fontSize: fontSize + 1,
            color: Colors.grey[200],
            fontWeight: FontWeight.w400),
        headline5: GoogleFonts.poppins(
            fontSize: fontSize + 1,
            color: Colors.grey[200],
            fontWeight: FontWeight.w300),
        headline6: GoogleFonts.poppins(
            fontSize: fontSize - 1,
            color: Colors.grey[200],
            fontWeight: FontWeight.w300),
        button: GoogleFonts.poppins(
            fontSize: fontSize,
            color: Colors.grey[200],
            fontWeight: FontWeight.w700),
      ),
      errorColor: const Color.fromARGB(255, 220, 145, 140),
      dividerTheme: const DividerThemeData(
        color: Colors.white60,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.grey.shade800.withOpacity(0.95),
      ),
    
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: CrColors.primaryColor),
    );
  }
}
