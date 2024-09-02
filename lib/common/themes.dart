import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class Themes {
  static ThemeData brightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme.apply(
              bodyColor: MyColors.activeColor,
              displayColor: MyColors.activeColor,
            ),
      ),
      hintColor: Colors.grey,
      scaffoldBackgroundColor: MyColors.whiteColor,
      appBarTheme: AppBarTheme(color: MyColors.whiteColor),
      useMaterial3: true,
    );
  }
}
