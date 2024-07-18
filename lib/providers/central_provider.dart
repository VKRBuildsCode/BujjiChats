import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class CentralProvider extends ChangeNotifier{
  ThemeData darkTheme=ThemeData(
    brightness: Brightness.dark,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.getFont(
            'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color:Colors.white
        ),
        displayMedium: GoogleFonts.getFont(
            'Outfit',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color:Colors.white
        ),
        displaySmall: GoogleFonts.getFont(
            'Outfit',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color:Colors.white
        ),
        titleLarge: GoogleFonts.getFont(
            'Outfit',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color:Colors.white
        ),
        titleMedium: GoogleFonts.getFont(
            'Outfit',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color:Colors.white
        ),
        titleSmall: GoogleFonts.getFont(
            'Outfit',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color:Colors.white
        ),
        bodyLarge:GoogleFonts.getFont(
            'Outfit',
            fontSize: 16,
            color:Colors.white
        ),
        bodyMedium: GoogleFonts.getFont(
            'Outfit',
            fontSize: 14,
            color:Colors.white
        ),
        bodySmall: GoogleFonts.getFont(
            'Outfit',
            fontSize: 12,
            color:Colors.white
        ),
      ),
  );
  ThemeData lightTheme=ThemeData(
      brightness: Brightness.light,

    textTheme: TextTheme(
      displayLarge: GoogleFonts.getFont(
          'Outfit',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color:Colors.black
      ),
      displayMedium: GoogleFonts.getFont(
          'Outfit',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color:Colors.black
      ),
      displaySmall: GoogleFonts.getFont(
          'Outfit',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color:Colors.black
      ),
      titleLarge: GoogleFonts.getFont(
          'Outfit',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color:Colors.black
      ),
      titleMedium: GoogleFonts.getFont(
          'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color:Colors.black
      ),
      titleSmall: GoogleFonts.getFont(
          'Outfit',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color:Colors.black
      ),
      bodyLarge:GoogleFonts.getFont(
          'Outfit',
          fontSize: 16,
          color:Colors.black
      ),
      bodyMedium: GoogleFonts.getFont(
          'Outfit',
          fontSize: 14,
          color:Colors.black
      ),
      bodySmall: GoogleFonts.getFont(
          'Outfit',
          fontSize: 12,
          color:Colors.black
      ),
    ),
  );
}