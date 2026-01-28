import 'package:flutter/material.dart';

/// Jellycat brand colors and application color palette
class AppColors {
  AppColors._();

  // Primary Jellycat brand colors
  static const Color primaryBrand = Color(0xFF8B4789); // Jellycat purple
  static const Color secondaryBrand = Color(0xFF4A90A4); // Jellycat teal
  static const Color accentPink = Color(0xFFF28E87); // Soft pink
  static const Color accentCream = Color(0xFFFDEDD8); // Jellycat cream

  // Semantic colors
  static const Color success = Color(0xFF2ECC71); // Owned items
  static const Color warning = Color(0xFFF39C12); // Wishlist
  static const Color error = Color(0xFFE74C3C); // Retired/Error
  static const Color info = Color(0xFF3498DB); // New/Planned

  // Neutral palette
  static const Color dark = Color(0xFF2C2C2C);
  static const Color light = Color(0xFFF5F5F5);
  static const Color border = Color(0xFFE0E0E0);
  static const Color cardBackground = Color(0xFFFFFFFF);
}
