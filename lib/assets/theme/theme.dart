import 'package:flutter/material.dart';
import 'package:fluttertest/assets/theme/widget_theme/appbar_theme.dart';
import 'package:fluttertest/assets/theme/widget_theme/bottomsheet_theme.dart';
import 'package:fluttertest/assets/theme/widget_theme/outlinedbottom_theme.dart';
import 'package:fluttertest/assets/theme/widget_theme/textfield_theme.dart';
import 'constants/colors.dart';
import 'widget_theme/checkbox_theme.dart';
import 'widget_theme/chip_theme.dart';
import 'widget_theme/elevatedButton_theme.dart';
import 'widget_theme/text_theme.dart';
class appTheme {
  appTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Kanit',
    disabledColor: TColors.grey,
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    // scaffoldBackgroundColor: TColors.white,
    textTheme: textTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    chipTheme: chipTheme.lightChipTheme,
    appBarTheme: appBarTheme.lightAppBarTheme,
    checkboxTheme: checkboxTheme.lightcheckboxTheme,
    bottomSheetTheme: bottomsheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: outlinedbuttonTheme.lightOutlinedButtonTheme,
    // inputDecorationTheme: textfieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Kanit',
    disabledColor: TColors.grey,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    // scaffoldBackgroundColor: TColors.black,
    textTheme: textTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    chipTheme: chipTheme.darkChipTheme,
    appBarTheme: appBarTheme.darkAppBarTheme,
    checkboxTheme: checkboxTheme.darkcheckboxTheme,
    bottomSheetTheme: bottomsheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: outlinedbuttonTheme.darkOutlinedButtonTheme,
    // inputDecorationTheme: textfieldTheme.darkInputDecorationTheme,
  );
}

mixin appbarTheme {
}
