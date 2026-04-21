import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette - Precise HSL Zen Luxury
  static const Color primary = Color(0xFF6366F1); // Elite Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryExtraLight = Color(0xFFF0EFFF);
  static const Color primaryDark = Color(0xFF4F46E5);
  
  static const Color secondary = Color(0xFFF59E0B); // Amber Glow
  static const Color secondaryLight = Color(0xFFFCD34D);
  
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);

  // Dark Colors - Deep Velvet Midnight
  static const Color darkBackground = Color(0xFF020617);
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkSurfaceVariant = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF0F172A);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);

  // Gradients - Aura Transitions (Masterpiece Grade)
  static const LinearGradient auraGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1), // Indigo
      Color(0xFF8B5CF6), // Violet
      Color(0xFFEC4899), // Pink
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient sunsetAura = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFF59E0B), // Amber
      Color(0xFFEF4444), // Red
    ],
  );

  static const LinearGradient zenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF818CF8), // Soft Indigo
      Color(0xFFC084FC), // Soft Purple
    ],
  );

  static const List<Color> mirrorPulse = [
    Color(0xFF6366F1),
    Color(0xFF818CF8),
    Color(0xFF6366F1),
  ];

  static const BoxDecoration glassDecoration = BoxDecoration(
    color: Colors.white12,
    borderRadius: BorderRadius.all(Radius.circular(24)),
    border: Border.fromBorderSide(BorderSide(color: Colors.white24, width: 0.5)),
  );

  static const LinearGradient glassEffect = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white24, Colors.white10],
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: surface,
        surfaceVariant: surfaceVariant,
        error: error,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: background,
      textTheme: _textTheme(const Color(0xFF1E293B)),
      appBarTheme: _appBarTheme(background, const Color(0xFF1E293B)),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      cardTheme: _cardTheme(surface),
      inputDecorationTheme: _inputTheme(const Color(0xFF475569)),
      bottomNavigationBarTheme: _bottomNavTheme(surface, primary, const Color(0xFF94A3B8)),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkBackground,
        contentTextStyle: GoogleFonts.outfit(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: darkSurface,
        surfaceVariant: darkSurfaceVariant,
        error: error,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: darkBackground,
      textTheme: _textTheme(Colors.white),
      appBarTheme: _appBarTheme(darkBackground, Colors.white),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      cardTheme: _cardTheme(darkCard),
      inputDecorationTheme: _inputTheme(Colors.white70),
      bottomNavigationBarTheme: _bottomNavTheme(darkSurface, primary, Colors.white38),
    );
  }

  static TextTheme _textTheme(Color mainColor) => GoogleFonts.outfitTextTheme().copyWith(
    displayLarge: GoogleFonts.outfit(
      fontSize: 42,
      fontWeight: FontWeight.w800,
      color: mainColor,
      letterSpacing: -1.5,
      height: 1.1,
    ),
    displayMedium: GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: mainColor,
      letterSpacing: -1.0,
      height: 1.2,
    ),
    headlineLarge: GoogleFonts.outfit(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: mainColor,
      letterSpacing: -0.5,
    ),
    headlineMedium: GoogleFonts.outfit(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: mainColor,
    ),
    titleLarge: GoogleFonts.outfit(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: mainColor,
    ),
    bodyLarge: GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: mainColor.withOpacity(0.9),
      height: 1.6,
    ),
    bodyMedium: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: mainColor.withOpacity(0.7),
      height: 1.5,
    ),
    labelLarge: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: primary,
      letterSpacing: 1.2,
    ),
  );

  static AppBarTheme _appBarTheme(Color bg, Color text) => AppBarTheme(
    backgroundColor: bg,
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0, // Keeps it clean on scroll
    titleTextStyle: GoogleFonts.outfit(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: text,
      letterSpacing: -0.5,
    ),
    iconTheme: IconThemeData(color: text, size: 22),
  );

  static ElevatedButtonThemeData _elevatedButtonTheme() => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    ).copyWith(
      overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
    ),
  );

  static OutlinedButtonThemeData _outlinedButtonTheme() => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primary,
      side: const BorderSide(color: primary, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  static CardThemeData _cardTheme(Color bg) => CardThemeData(
    color: bg,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  static InputDecorationTheme _inputTheme(Color textColor) => InputDecorationTheme(
    filled: true,
    fillColor: Colors.transparent,
    contentPadding: const EdgeInsets.all(18),
    border: _border(Colors.grey.withOpacity(0.2)),
    enabledBorder: _border(Colors.grey.withOpacity(0.2)),
    focusedBorder: _border(primary),
    errorBorder: _border(error),
    labelStyle: GoogleFonts.outfit(color: textColor, fontWeight: FontWeight.w500),
    hintStyle: GoogleFonts.outfit(color: textColor.withOpacity(0.4)),
  );

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: color, width: 1.5),
  );

  static BottomNavigationBarThemeData _bottomNavTheme(Color bg, Color selected, Color unselected) => 
    BottomNavigationBarThemeData(
      backgroundColor: bg,
      selectedItemColor: selected,
      unselectedItemColor: unselected,
      elevation: 20,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 12),
      unselectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w500, fontSize: 12),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
}
