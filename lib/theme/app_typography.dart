import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle kicker = GoogleFonts.roboto(
    fontSize: 10.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.8,
    color: AppColors.textSecondary,
  );

  static TextStyle screenTitle = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle largeTitle = GoogleFonts.roboto(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle sectionTitle = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static TextStyle actionLink = GoogleFonts.roboto(
    fontSize: 11.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
    color: AppColors.primary,
  );

  static TextStyle statLabel = GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.3,
    color: AppColors.textSecondary,
  );

  static TextStyle statValue = GoogleFonts.roboto(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle cardTitle = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle cardSubtitle = GoogleFonts.roboto(
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle quickActionLabel = GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
    color: AppColors.textPrimary,
  );

  static TextStyle fieldLabel = GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: AppColors.textPrimary,
  );

  static TextStyle inputPlaceholder = GoogleFonts.roboto(
    fontSize: 13.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static TextStyle inputValue = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle buttonText = GoogleFonts.roboto(
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
  );

  static TextStyle secondaryButtonText = GoogleFonts.roboto(
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle badge = GoogleFonts.roboto(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
  );

  static TextStyle bodyText = GoogleFonts.roboto(
    fontSize: 13.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.45,
  );

  static TextStyle navLabel = GoogleFonts.roboto(
    fontSize: 10.5,
    fontWeight: FontWeight.w500,
  );
}
