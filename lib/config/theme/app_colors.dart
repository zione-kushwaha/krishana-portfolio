import 'package:flutter/material.dart';

/// Modern & Professional Color scheme for Portfolio
class AppColors {
  AppColors._();

  // Primary colors - Deep Professional Blues
  static const Color primaryBlue = Color(0xFF0A66C2);
  static const Color primaryBlueDark = Color(0xFF004182);
  static const Color primaryBlueLight = Color(0xFF3B8ED0);
  static const Color electricBlue = Color(0xFF00D4FF);

  // Accent colors - Vibrant & Eye-catching
  static const Color accentOrange = Color(0xFFFF6B35);
  static const Color accentOrangeLight = Color(0xFFFF8E53);
  static const Color accentOrangeDark = Color(0xFFE64A19);
  static const Color vibrantPurple = Color(0xFF6C5CE7);
  static const Color vibrantPink = Color(0xFFFF006E);
  static const Color vibrantTeal = Color(0xFF00D9C0);
  static const Color vibrantYellow = Color(0xFFFFD60A);

  // Secondary colors - Modern Grays
  static const Color steelGray = Color(0xFF546E7A);
  static const Color steelGrayLight = Color(0xFF90A4AE);
  static const Color steelGrayDark = Color(0xFF263238);
  static const Color charcoal = Color(0xFF2D3436);
  static const Color slate = Color(0xFF374151);

  // Background & Surface colors
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceTint = Color(0xFFF5F7FA);
  static const Color concreteLight = Color(0xFFF8F9FA);
  static const Color concrete = Color(0xFFE9ECEF);
  static const Color concreteDark = Color(0xFFCED4DA);

  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color darkText = Color(0xFF1A1A1A);
  static const Color mediumText = Color(0xFF4A5568);
  static const Color lightText = Color(0xFF718096);
  static const Color mutedText = Color(0xFFA0AEC0);

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);

  // Premium Gradients - Modern & Stylish
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0A66C2), Color(0xFF3B8ED0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFFD60A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFF006E), Color(0xFF8338EC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient oceanGradient = LinearGradient(
    colors: [Color(0xFF00D4FF), Color(0xFF0A66C2), Color(0xFF6C5CE7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient forestGradient = LinearGradient(
    colors: [Color(0xFF00D9C0), Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient royalGradient = LinearGradient(
    colors: [Color(0xFF6C5CE7), Color(0xFF8338EC), Color(0xFFFF006E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient modernDarkGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [Color(0xFFEBEBEB), Color(0xFFF4F4F4), Color(0xFFEBEBEB)],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );

  // Card gradients
  static const LinearGradient cardGradient1 = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient2 = LinearGradient(
    colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glass morphism effect colors
  static Color glassMorphismBackground = Colors.white.withOpacity(0.1);
  static Color glassMorphismBorder = Colors.white.withOpacity(0.2);
  static Color glassDark = Colors.black.withOpacity(0.1);
  static Color glassLight = Colors.white.withOpacity(0.15);

  // Overlay colors
  static Color darkOverlay = Colors.black.withOpacity(0.6);
  static Color lightOverlay = Colors.white.withOpacity(0.8);
  static Color blurOverlay = Colors.black.withOpacity(0.3);

  // Shadow colors
  static Color shadowLight = Colors.black.withOpacity(0.08);
  static Color shadowMedium = Colors.black.withOpacity(0.15);
  static Color shadowDark = Colors.black.withOpacity(0.25);
  static Color shadowColored = primaryBlue.withOpacity(0.3);
  static Color shadowAccent = accentOrange.withOpacity(0.3);

  // Text colors (aliases for consistency)
  static const Color textPrimary = darkText;
  static const Color textSecondary = mediumText;
  static const Color textTertiary = lightText;

  // Border colors
  static const Color borderLight = concrete;
  static const Color borderMedium = concreteDark;
  static const Color borderDark = steelGrayLight;
}
