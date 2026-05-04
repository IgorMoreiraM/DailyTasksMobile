import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class RolePill extends StatelessWidget {
  final String role;
  const RolePill({super.key, required this.role});

  static const _map = <String, List<Color>>{
    'MASTER':      [Color(0xFFFFFBEB), Color(0xFFB45309)],
    'GESTOR':      [Color(0xFFECFDF5), Color(0xFF0D9488)],
    'GERENTE':     [Color(0xFFF5F3FF), Color(0xFF7C3AED)],
    'FUNCIONARIO': [Color(0xFFFFF7ED), Color(0xFFEA580C)],
  };

  @override
  Widget build(BuildContext context) {
    final colors = _map[role] ?? [const Color(0xFFF1F5F9), AppColors.textMuted];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors[1].withValues(alpha: 0.3)),
      ),
      child: Text(
        role,
        style: GoogleFonts.darkerGrotesque(
          fontSize: 10, fontWeight: FontWeight.w700, color: colors[1],
        ),
      ),
    );
  }
}
