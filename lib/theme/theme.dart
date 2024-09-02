import 'palette.dart';
import 'package:flutter/material.dart';

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);

ThemeData lightMode = ThemeData.light().copyWith(
  primaryColor: PaletteLight.primaryColor,
  scaffoldBackgroundColor: PaletteLight.backgroundColor,
  appBarTheme: appBarTheme.copyWith(backgroundColor: PaletteLight.backgroundColor),
  iconTheme: const IconThemeData(color: PaletteLight.contentColor),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: PaletteLight.contentColor,
        displayColor: PaletteLight.contentColor,
      ),
  colorScheme: const ColorScheme.light(
    primary: PaletteLight.primaryColor,
    secondary: PaletteLight.secondaryColor,
    error: PaletteLight.errorColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: PaletteLight.backgroundColor,
    selectedItemColor: PaletteLight.contentColor.withOpacity(0.7),
    unselectedItemColor: PaletteLight.contentColor.withOpacity(0.32),
    selectedIconTheme: const IconThemeData(color: PaletteLight.primaryColor),
    showUnselectedLabels: true,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: PaletteLight.backgroundColor,
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: PaletteLight.backgroundColor,
    rangeSelectionBackgroundColor: PaletteLight.primaryColor.withOpacity(0.1),
    rangeSelectionOverlayColor: WidgetStateProperty.all(PaletteLight.primaryColor),
    headerBackgroundColor: PaletteLight.backgroundColor,
    headerForegroundColor: PaletteLight.contentColor,
    dayForegroundColor: WidgetStateProperty.all(PaletteLight.contentColor),
    todayForegroundColor: WidgetStateProperty.all(PaletteLight.contentColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: PaletteLight.primaryColor,
      foregroundColor: PaletteLight.secondaryColor,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: PaletteLight.primaryColor,
    foregroundColor: PaletteLight.secondaryColor,
  ),
);

ThemeData darkMode = ThemeData.dark().copyWith(
  primaryColor: PaletteDark.primaryColor,
  scaffoldBackgroundColor: PaletteDark.backgroundColor,
  appBarTheme: appBarTheme.copyWith(backgroundColor: PaletteDark.backgroundColor),
  iconTheme: const IconThemeData(color: PaletteDark.contentColor),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: PaletteDark.contentColor,
        displayColor: PaletteDark.contentColor,
      ),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: PaletteDark.primaryColor,
    secondary: PaletteDark.secondaryColor,
    error: PaletteDark.errorColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: PaletteDark.backgroundColor,
    selectedItemColor: PaletteDark.contentColor.withOpacity(0.7),
    unselectedItemColor: PaletteDark.contentColor.withOpacity(0.32),
    selectedIconTheme: const IconThemeData(color: PaletteDark.primaryColor),
    showUnselectedLabels: true,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: PaletteDark.backgroundColor,
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: PaletteDark.backgroundColor,
    rangeSelectionBackgroundColor: PaletteDark.primaryColor.withOpacity(0.1),
    rangeSelectionOverlayColor: WidgetStateProperty.all(PaletteDark.primaryColor),
    headerBackgroundColor: PaletteDark.backgroundColor,
    headerForegroundColor: PaletteDark.contentColor,
    dayForegroundColor: WidgetStateProperty.all(PaletteDark.contentColor),
    todayForegroundColor: WidgetStateProperty.all(PaletteDark.contentColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: PaletteDark.primaryColor,
      foregroundColor: PaletteDark.secondaryColor,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: PaletteDark.primaryColor,
    foregroundColor: PaletteDark.secondaryColor,
  ),
);
