import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/theme/app_colors.dart';
import 'nav_item.dart';

class DashboardTopBar extends StatelessWidget {
  final String title;
  final VoidCallback onLogout;
  final bool showMenuIcon;
  final List<NavItem> navItems;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const DashboardTopBar({
    super.key,
    required this.title,
    required this.onLogout,
    required this.showMenuIcon,
    required this.navItems,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.borderDefault)),
      ),
      child: Row(children: [
        if (showMenuIcon) _buildMenuButton(),
        Text(title, style: GoogleFonts.darkerGrotesque(
          fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark,
        )),
        const Spacer(),
        _buildUserBadge(),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onLogout,
          icon: const Icon(Icons.logout_rounded, size: 18, color: AppColors.textMuted),
          tooltip: 'Sair',
        ),
      ]),
    );
  }

  Widget _buildMenuButton() => PopupMenuButton<int>(
    icon: const Icon(Icons.menu_rounded, color: AppColors.textDark),
    onSelected: onSelect,
    itemBuilder: (_) => navItems.asMap().entries.map((e) => PopupMenuItem(
      value: e.key,
      child: Row(children: [
        Icon(e.value.icon, size: 16, color: AppColors.primaryGreen),
        const SizedBox(width: 10),
        Text(e.value.label, style: GoogleFonts.darkerGrotesque(fontWeight: FontWeight.w600)),
      ]),
    )).toList(),
  );

  Widget _buildUserBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.primaryGreen.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(children: [
      Container(
        width: 26, height: 26,
        decoration: const BoxDecoration(color: AppColors.primaryGreen, shape: BoxShape.circle),
        child: Center(child: Text('A', style: GoogleFonts.darkerGrotesque(
          fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white,
        ))),
      ),
      const SizedBox(width: 8),
      Text('admin', style: GoogleFonts.darkerGrotesque(
        fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryGreen,
      )),
    ]),
  );
}
