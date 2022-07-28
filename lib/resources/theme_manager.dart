import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManger.black,
        selectionColor: ColorManger.black,
        selectionHandleColor: ColorManger.black //<-- SEE HERE
        ),
    //?main colors
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightPrimary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey1,
    splashColor: ColorManger.lightPrimary,
    //ripple effect

    //?cardview theme
    cardTheme: CardTheme(
      color: ColorManger.white,
      shadowColor: ColorManger.grey,
      elevation: AppSize.s4,
    ),
    //?appBar theme
    appBarTheme: AppBarTheme(
      //centerTitle: true,
      color: ColorManger.white,
      elevation: AppSize.s0,
      shadowColor: ColorManger.lightPrimary,
      titleTextStyle: getSemiBoldStyle(
        fontSize: FontSize.s30,
        color: ColorManger.black,
      ),
    ),

    //?elevated theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManger.white,
          fontSize: FontSize.s18,
        ),
        primary: ColorManger.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
      ),
    )
    //?text theme
    ,
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(
        color: ColorManger.black,
        fontSize: FontSize.s18,
      ),
      headlineMedium: getSemiBoldStyle(
        color: ColorManger.white,
        fontSize: FontSize.s18,
      ),
      headlineSmall: getRegularStyle(
        color: ColorManger.black,
        fontSize: FontSize.s16,
      ),
      displaySmall: getRegularStyle(
        color: ColorManger.darkGrey,
        fontSize: FontSize.s18,
      ),
      displayMedium: getRegularStyle(
        color: ColorManger.black,
        fontSize: FontSize.s20,
      ),
    ),

    //?input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManger.lightGrey,
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        color: ColorManger.darkGrey,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManger.darkGrey,
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
          color: ColorManger.error,
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
          color: ColorManger.errorLight,
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
