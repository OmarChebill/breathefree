import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// All colors live here. Change them once, the whole app follows.
class AppColors {
  static const mist = Color(0xFFF2F7F6); // screen background
  static const pine = Color(0xFF0E4D52); // primary (buttons, progress)
  static const mint = Color(0xFF7ED6C1); // accent (highlights)
  static const ink = Color(0xFF12262A); // main text
  static const stone = Color(0xFF5F7377); // secondary text
  static const ember = Color(0xFFE8844A); // used later for cravings
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.pine,
        primary: AppColors.pine,
        secondary: AppColors.mint,
      ),
      scaffoldBackgroundColor: AppColors.mist,
    );

    // Two fonts: Fraunces (serif) for headlines, Manrope for everything else.
    final text = GoogleFonts.manropeTextTheme(base.textTheme)
        .apply(bodyColor: AppColors.ink, displayColor: AppColors.ink);

    return base.copyWith(
      textTheme: text.copyWith(
  headlineLarge: GoogleFonts.fraunces(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    height: 1.15,
    color: AppColors.ink,
  ),
  headlineMedium: GoogleFonts.fraunces(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.ink,
  ),
),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.pine, width: 2)),
      ),
    );
  }
}