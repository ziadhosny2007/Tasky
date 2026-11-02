import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    primaryTextTheme: TextTheme(
        
      bodyLarge: TextStyle(
        fontSize: 32,
        fontWeight: .bold,
        color: Colors.black,
      ),

      bodyMedium: TextStyle(
        color: Colors.grey,
        fontWeight: .w400,
        fontSize: 16,
      ),
    ),
appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xffffffff),
),
    textTheme: GoogleFonts.latoTextTheme(),

    primaryColor: Color(0xffffffff),
    secondaryHeaderColor: Color(0xff5F33E1),
  );
}
