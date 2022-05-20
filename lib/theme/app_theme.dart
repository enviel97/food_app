import 'package:flutter/material.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/colors.dart';

class AppTheme {
  AppTheme._();
  static final AppTheme theme = AppTheme._();
  ColorScheme scheme() => ColorScheme(
        // primary
        primary: kPrimaryColor,
        primaryContainer: kPrimaryLightColor,
        onPrimaryContainer: kPrimaryDarkColor,
        onPrimary: kBlackColor,
        // secondary
        secondary: kSecondaryColor,
        secondaryContainer: kSecondaryLightColor,
        onSecondaryContainer: kSecondaryDarkColor,
        onSecondary: kWhiteColor,

        // surface
        surface: kPlaceholderDarkColor,
        onSurface: kPlaceholderColor,

        // teriaty
        tertiary: kTertiaryColor,
        onTertiary: kWhiteColor,

        //
        background: kLightBackgoundColor,
        onBackground: kBlackColor,
        //
        error: kErrorColor,
        onError: kErrorColor.withOpacity(.7),
        //
        brightness: Brightness.light,
      );

  final ThemeData defaultTheme = ThemeData(
    hintColor: kPlaceholderColor,
    focusColor: kSecondaryColor,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: kPrimaryColor,
        textStyle: const TextStyle(
          fontSize: Spacing.m,
          fontWeight: FontWeight.bold,
        ), // button text color
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kPrimaryColor,
      selectionColor: kPrimaryColor.withOpacity(.7),
      selectionHandleColor: kPrimaryColor.withOpacity(.7),
    ),
  );

  AppBarTheme get _appBarTheme => const AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: Spacing.lg,
          fontWeight: FontWeight.bold,
          color: kWhiteColor,
        ),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: kWhiteColor),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(25.0))),
      );

  static TextTheme defaultFonts(BuildContext context) {
    return GoogleFonts.robotoTextTheme(Theme.of(context).textTheme);
  }

  static ThemeData lightTheme(context) {
    return theme.defaultTheme.copyWith(
      colorScheme: theme.scheme(),
      dialogBackgroundColor: kBlackColor,
      scaffoldBackgroundColor: kLightBackgoundColor,
      backgroundColor: kLightBackgoundColor,
      hintColor: kPlaceholderDarkColor,
      dividerColor: kDividerColor,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: kBlackColor),
      textTheme: defaultFonts(context).apply(
        bodyColor: kBlackColor,
        displayColor: kBlackColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: kTertiaryColor,
        selectionColor: kTertiaryColor.withOpacity(.2),
        selectionHandleColor: kTertiaryColor.withOpacity(.2),
      ),
      appBarTheme: theme._appBarTheme.copyWith(
        backgroundColor: kPrimaryLightColor,
      ),
      cardColor: kLightBackgoundColor,
    );
  }
}
