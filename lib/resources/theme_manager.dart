import 'dart:math';

import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationLightTheme() {
  return ThemeData();
}

ThemeData getApplicationDarkTheme() {
  return ThemeData(
    iconTheme: IconThemeData(
      color: ColorManger.white,
      size: AppSize.s30,
    ),
    popupMenuTheme: PopupMenuThemeData(color: ColorManger.veryLightBlack),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorManger.taskColors[Random().nextInt(10)]),
    indicatorColor: ColorManger.white,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManger.splash,
        selectionColor: ColorManger.darkPrimary,
        selectionHandleColor: ColorManger.darkPrimary //<-- SEE HERE
        ),
    backgroundColor: ColorManger.lightBlack,
    applyElevationOverlayColor: false,
    scaffoldBackgroundColor: ColorManger.lightBlack,
    //?main colors
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightPrimary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.lightGrey,
    splashColor: ColorManger.splash,
    //ripple effect

    //?cardview theme
    cardTheme: CardTheme(
      color: ColorManger.lightBlack,
      shadowColor: ColorManger.grey,
      elevation: AppSize.s4,
    ),
    //?appBar theme
    appBarTheme: AppBarTheme(
      //centerTitle: true,
      color: ColorManger.lightBlack,
      elevation: AppSize.s0,
      shadowColor: ColorManger.lightPrimary,
      titleTextStyle: getSemiBoldStyle(
        fontSize: FontSize.s30,
        color: ColorManger.white,
      ),
    ),

    //?elevated theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (states) => getRegularStyle(
            color: ColorManger.white,
            fontSize: FontSize.s18,
          ),
        ),
        surfaceTintColor: MaterialStateProperty.resolveWith<Color>(
          (states) => Colors.transparent,
        ),
        elevation:
            MaterialStateProperty.resolveWith<double>((states) => AppSize.s0),
        shadowColor: MaterialStateProperty.resolveWith<Color>(
          (states) => Colors.transparent,
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) =>
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12))),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.transparent),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Colors.transparent),
      ),
    )
    //?text theme
    ,
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(
        color: ColorManger.white,
        fontSize: FontSize.s18,
      ),
      headlineMedium: getSemiBoldStyle(
        color: ColorManger.white,
        fontSize: FontSize.s18,
      ),
      headlineSmall: getRegularStyle(
        color: ColorManger.white,
        fontSize: FontSize.s16,
      ),
      displaySmall: getRegularStyle(
        color: ColorManger.black,
        fontSize: FontSize.s16,
      ),
    ),

    //?input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManger.veryLightBlack,
      contentPadding: const EdgeInsets.all(AppSize.s10),
      hintStyle: getRegularStyle(
        color: ColorManger.white,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManger.white,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(
        color: ColorManger.errorLight,
        fontSize: FontSize.s14,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.white,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s4,
          ),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.white,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s4,
          ),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.errorLight,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s4,
          ),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.error,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s4,
          ),
        ),
      ),
    ),
  );
}
