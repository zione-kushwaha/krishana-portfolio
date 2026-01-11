import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/config/theme/text_theme.dart';

ThemeData createLightTheme() {
  const String fontFamily = 'Poppins';
  const List<String> fontFamilyFallback = ['Roboto', 'Arial', 'sans-serif'];

  return ThemeData(
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    useMaterial3: true,

    // Primary colors
    primaryColor: AppColors.primaryBlue,
    primaryColorLight: AppColors.primaryBlueLight,
    primaryColorDark: AppColors.primaryBlueDark,

    scaffoldBackgroundColor: AppColors.backgroundLight,

    // Color scheme - Enhanced with modern colors
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryBlue,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.primaryBlueLight,
      onPrimaryContainer: AppColors.white,

      secondary: AppColors.accentOrange,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.accentOrangeLight,
      onSecondaryContainer: AppColors.white,

      tertiary: AppColors.vibrantPurple,
      onTertiary: AppColors.white,

      error: AppColors.error,
      onError: AppColors.white,
      errorContainer: AppColors.errorLight,
      onErrorContainer: AppColors.white,

      surface: AppColors.surfaceLight,
      onSurface: AppColors.darkText,
      surfaceContainerHighest: AppColors.concreteLight,

      outline: AppColors.concreteDark,
      outlineVariant: AppColors.concrete,

      shadow: AppColors.shadowLight,
      scrim: AppColors.black,

      inverseSurface: AppColors.charcoal,
      onInverseSurface: AppColors.white,
      inversePrimary: AppColors.primaryBlueLight,
    ),

    // App bar theme - Modern & Clean
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(color: AppColors.darkText, size: 24),
      titleTextStyle: GoogleFonts.montserrat(
        color: AppColors.darkText,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
      ),
    ),

    // Card theme - Enhanced with shadows and borders
    cardTheme: CardThemeData(
      elevation: 0,
      shadowColor: AppColors.shadowMedium,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.concrete, width: 1),
      ),
      color: AppColors.white,
      margin: const EdgeInsets.all(8),
    ),

    // Elevated button theme - Modern with gradients
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
        shadowColor: AppColors.shadowColored,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        side: const BorderSide(color: AppColors.primaryBlue, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentOrange,
      foregroundColor: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Input decoration theme - Enhanced with better visuals
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.concreteLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.concrete, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: GoogleFonts.poppins(color: AppColors.mutedText, fontSize: 14),
      labelStyle: GoogleFonts.poppins(
        color: AppColors.mediumText,
        fontSize: 14,
      ),
    ),

    // Chip theme - Modern styling
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.concreteLight,
      deleteIconColor: AppColors.mediumText,
      labelStyle: GoogleFonts.poppins(
        color: AppColors.darkText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Icon theme
    iconTheme: const IconThemeData(color: AppColors.darkText, size: 24),

    // Divider theme
    dividerTheme: const DividerThemeData(
      color: AppColors.concrete,
      thickness: 1,
      space: 1,
    ),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primaryBlue,
      unselectedItemColor: AppColors.lightText,
      selectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Tooltip theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.poppins(color: AppColors.white, fontSize: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Text theme with Google Fonts
    textTheme: getLightTextTheme(fontFamily),
  );
}
