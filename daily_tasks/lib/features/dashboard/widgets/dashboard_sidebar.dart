import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/theme/app_colors.dart';
import 'nav_item.dart';

class DashboardSidebar extends StatelessWidget {
  final List<NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogout;

  const DashboardSidebar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColors.primaryGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          _buildLogo(),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Admin Master', style: GoogleFonts.darkerGrotesque(
              fontSize: 11, color: Colors.white54, fontWeight: FontWeight.w600,
            )),
          ),
          const SizedBox(height: 28),
          ...items.asMap().entries.map((e) => _buildItem(e.key, e.value)),
          const Spacer(),
          _buildLogout(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLogo() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(children: [
      Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.task_alt_rounded, color: Colors.white, size: 18),
      ),
      const SizedBox(width: 10),
      RichText(
        text: TextSpan(
          style: GoogleFonts.darkerGrotesque(
            fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white,
          ),
          children: const [
            TextSpan(text: 'Daily'),
            TextSpan(text: 'Tasks', style: TextStyle(color: AppColors.orange)),
          ],
        ),
      ),
    ]),
  );

  Widget _buildItem(int index, NavItem item) {
    final isActive = index == selectedIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Icon(item.icon, size: 17, color: isActive ? Colors.white : Colors.white60),
          const SizedBox(width: 10),
          Text(item.label, style: GoogleFonts.darkerGrotesque(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? Colors.white : Colors.white70,
          )),
        ]),
      ),
    );
  }

  Widget _buildLogout() => GestureDetector(
    onTap: onLogout,
    child: Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        const Icon(Icons.logout_rounded, size: 17, color: Colors.white60),
        const SizedBox(width: 10),
        Text('Sair', style: GoogleFonts.darkerGrotesque(fontSize: 14, color: Colors.white70)),
      ]),
    ),
  );
}
