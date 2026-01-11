import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/config/theme/app_colors.dart';

/// Creates a beautiful text theme using Google Fonts with font hierarchy
/// - Headings: Montserrat (Bold, Modern)
/// - Body: Poppins (Clean, Readable)
/// - Accent: Playfair Display (Elegant)
TextTheme getLightTextTheme(String fontFamily) {
  return TextTheme(
    // Display styles - Montserrat Bold for Impact
    displayLarge: GoogleFonts.montserrat(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.25,
      color: AppColors.darkText,
      height: 1.12,
    ),
    displayMedium: GoogleFonts.montserrat(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
      color: AppColors.darkText,
      height: 1.16,
    ),
    displaySmall: GoogleFonts.montserrat(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      color: AppColors.darkText,
      height: 1.22,
    ),

    // Headline styles - Montserrat for Strong Headers
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      color: AppColors.darkText,
      height: 1.25,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: AppColors.darkText,
      height: 1.29,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: AppColors.darkText,
      height: 1.33,
    ),

    // Title styles - Poppins for Clean Titles
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: AppColors.darkText,
      height: 1.27,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.darkText,
      height: 1.5,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      color: AppColors.darkText,
      height: 1.43,
    ),

    // Body styles - Poppins for Readability
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
      color: AppColors.darkText,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25,
      color: AppColors.mediumText,
      height: 1.43,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.4,
      color: AppColors.lightText,
      height: 1.33,
    ),

    // Label styles - Poppins Medium for UI Elements
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: AppColors.darkText,
      height: 1.43,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: AppColors.lightText,
      height: 1.33,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: AppColors.lightText,
      height: 1.45,
    ),
  );
}

/// Special text styles for unique elements
class CustomTextStyles {
  CustomTextStyles._();

  /// Elegant serif font for quotes or special sections
  static TextStyle elegant({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return GoogleFonts.playfairDisplay(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.darkText,
      height: 1.4,
      letterSpacing: 0.5,
    );
  }

  /// Modern tech-style font for code or technical content
  static TextStyle tech({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.darkText,
      height: 1.5,
      letterSpacing: 0.3,
    );
  }

  /// Monospace for code snippets
  static TextStyle code({double fontSize = 14, Color? color}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: color ?? AppColors.darkText,
      height: 1.5,
    );
  }

  /// Handwriting style for personal touch
  static TextStyle handwriting({double fontSize = 18, Color? color}) {
    return GoogleFonts.dancingScript(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: color ?? AppColors.darkText,
      height: 1.3,
    );
  }

  /// Gradient text effect
  static TextStyle gradient({
    required double fontSize,
    required FontWeight fontWeight,
    required Gradient gradient,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.2,
      foreground: Paint()
        ..shader = gradient.createShader(const Rect.fromLTWH(0, 0, 200, 70)),
    );
  }
}
