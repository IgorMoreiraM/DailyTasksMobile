import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final double size;

  const AppAvatar({super.key, required this.name, this.size = 34});

  Color _color() {
    const colors = [
      AppColors.primaryGreen, AppColors.teal, AppColors.orange,
      Color(0xFF7C3AED), Color(0xFFDB2777),
    ];
    return colors[name.codeUnitAt(0) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(color: _color(), shape: BoxShape.circle),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: GoogleFonts.darkerGrotesque(
            fontSize: size * 0.38,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
