import 'package:flutter/material.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/colors.dart';

class AppTheme {
  AppTheme._();
  static final AppTheme theme = AppTheme._();
  ColorScheme scheme({
    required Color backgroundColor,
    required Color onBack,
    required Brightness brightness,
  }) =>
      ColorScheme(
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
        //
        background: backgroundColor,
        onBackground: onBack,
        //
        error: kErrorColor,
        onError: kErrorColor.withOpacity(.7),
        //
        brightness: brightness,
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
      colorScheme: theme.scheme(
        backgroundColor: kLightBackgoundColor,
        brightness: Brightness.light,
        onBack: kBlackColor,
      ),
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
      appBarTheme: theme._appBarTheme.copyWith(
        backgroundColor: kPrimaryLightColor,
      ),
      cardColor: kLightBackgoundColor,
    );
  }

  static ThemeData darkTheme(context) {
    return theme.defaultTheme.copyWith(
      colorScheme: theme.scheme(
        backgroundColor: kDarkBackgroundColor,
        brightness: Brightness.dark,
        onBack: kWhiteColor,
      ),
      dialogBackgroundColor: kBlackColor,
      scaffoldBackgroundColor: kDarkBackgroundColor,
      backgroundColor: kDarkBackgroundColor,
      hintColor: kPlaceholderColor,
      dividerColor: kDividerColor,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: kWhiteColor),
      textTheme: defaultFonts(context).apply(
        decorationColor: kWhiteColor,
        bodyColor: kWhiteColor,
        displayColor: kWhiteColor,
      ),
      selectedRowColor: kBlackColor,
      appBarTheme: theme._appBarTheme.copyWith(
        backgroundColor: kDarkBackgroundColor,
      ),
      cardColor: kDarkBackgroundColor,
    );
  }
}
