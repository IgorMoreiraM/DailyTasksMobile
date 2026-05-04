import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppDecorations {
  AppDecorations._();

  static InputDecoration inputField(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.darkerGrotesque(fontSize: 13.5, color: AppColors.textMuted),
    filled: true,
    fillColor: AppColors.bgSubtle,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.borderDefault),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.borderDefault),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1.8),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.errorText),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.errorText, width: 1.8),
    ),
  );

  static InputDecoration loginField({
    required String label,
    required IconData icon,
    Widget? suffix,
  }) =>
      InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.darkerGrotesque(fontSize: 13.5, color: AppColors.textMuted),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: AppColors.bgSubtle,
        prefixIcon: Icon(icon, size: 16, color: AppColors.textMuted),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondaryGreen.withValues(alpha: 0.35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorText),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorText, width: 1.8),
        ),
      );

  static BoxDecoration card({double radius = 14}) => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: AppColors.borderDefault),
  );
}
