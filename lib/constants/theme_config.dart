import 'package:flutter/material.dart';

import 'app_colors.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    // useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: ApplicationColors.e00,
    backgroundColor: ApplicationColors.f8f8,
    scaffoldBackgroundColor: ApplicationColors.f8f8,
    appBarTheme: const AppBarTheme(
      backgroundColor: ApplicationColors.e00,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ApplicationColors.e00, // Primary color for buttons
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
    ),
    colorScheme: ColorScheme.light(
      primary: ApplicationColors.e00, // Your primary color (purple)
      onPrimary:
          Colors.white, // Text/icons on primary color (white for contrast)

      primaryContainer:
          ApplicationColors.e7e7, // Light container variation of primary color
      onPrimaryContainer:
          Colors.black, // Text/icons on primary container (black for contrast)

      secondary:
          ApplicationColors.baoa, // Secondary accent color (neutral gray)
      onSecondary:
          Colors.black, // Text/icons on secondary color (black for contrast)

      background:
          ApplicationColors.f8f8, // Light background color for overall app
      onBackground:
          Colors.black, // Content on background (black for readability)

      surface: ApplicationColors
          .e7e7, // Light gray for surfaces like cards and dialogs
      onSurface: Colors.black, // Content on surface (black text/icons)

      error: Colors.redAccent, // Standard error color (can be customized)
      onError:
          Colors.white, // Text/icons on error surfaces (white for contrast)

      outline: ApplicationColors.baoa, // Outline color (neutral gray)
      shadow:
          Colors.black.withOpacity(0.2), // Lighter shadow for elevated elements

      inverseSurface: ApplicationColors.a26, // Dark color for inverse surfaces
      onInverseSurface: ApplicationColors
          .f8f8, // Content on inverse surface (light color for contrast)

      surfaceTint:
          ApplicationColors.e00, // Tint for surfaces based on primary color
    ),
  );

  static ThemeData darkTheme = ThemeData(
    // useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: ApplicationColors.e00,
    backgroundColor: ApplicationColors.a26,
    scaffoldBackgroundColor: ApplicationColors.a26,
    appBarTheme: const AppBarTheme(
      backgroundColor: ApplicationColors.d30,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ApplicationColors.e00, // Primary color for buttons
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: ApplicationColors.f8f8),
      bodyText2: TextStyle(color: ApplicationColors.e7e7),
    ),
    colorScheme: const ColorScheme.dark(
      primary: ApplicationColors.e00, // Your primary color (purple)
      onPrimary:
          Colors.white, // Contrasting color for text/icons on primary color

      primaryContainer:
          ApplicationColors.d30, // A slightly darker container variation
      onPrimaryContainer: Colors.white, // Content on primary container

      secondary:
          ApplicationColors.baoa, // Secondary accent color (gray/neutral)
      onSecondary: Colors.white, // Content on secondary color

      background:
          ApplicationColors.a26, // Darkest background color for overall app
      onBackground: ApplicationColors
          .f8f8, // Content on background (white/light color for contrast)

      surface:
          ApplicationColors.d30, // Surface for elevated elements like cards
      onSurface: ApplicationColors.e7e7, // Content on surface (light gray)

      error: Colors.redAccent, // Default error color (can be customized)
      onError: Colors.white, // Text/icons on error surfaces

      outline:
          ApplicationColors.baoa, // Outline for input fields or borders (gray)
      shadow: Colors.black, // Shadow for elevated elements

      inverseSurface: ApplicationColors
          .f8f8, // Inverse surface color (light color for special cases)
      onInverseSurface: ApplicationColors
          .a26, // Content on inverse surface (dark for contrast)

      surfaceTint:
          ApplicationColors.e00, // Tint for surfaces based on primary color
    ),
  );
}
