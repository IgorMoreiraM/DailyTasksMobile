import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_routes.dart';
import '../../../shared/theme/app_colors.dart';
import '../widgets/nav_item.dart';
import '../widgets/dashboard_sidebar.dart';
import '../widgets/dashboard_topbar.dart';
import 'dashboard_home_page.dart';
import '../../tarefas/pages/tarefas_page.dart';
import '../../projetos/pages/projetos_page.dart';
import '../../listas/pages/listas_page.dart';
import '../../empresas/pages/empresas_page.dart';
import '../../usuarios/pages/usuarios_page.dart';

class MasterDashboardPage extends StatefulWidget {
  const MasterDashboardPage({super.key});

  @override
  State<MasterDashboardPage> createState() => _MasterDashboardPageState();
}

class _MasterDashboardPageState extends State<MasterDashboardPage> {
  int _selectedIndex = 0;

  static const _navItems = <NavItem>[
    NavItem(icon: Icons.dashboard_rounded,  label: 'Dashboard'),
    NavItem(icon: Icons.task_alt_rounded,   label: 'Tarefas'),
    NavItem(icon: Icons.folder_rounded,     label: 'Projetos'),
    NavItem(icon: Icons.list_alt_rounded,   label: 'Listas'),
    NavItem(icon: Icons.business_rounded,   label: 'Empresas'),
    NavItem(icon: Icons.people_rounded,     label: 'Usuários'),
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardHomePage(onNavigate: (i) => setState(() => _selectedIndex = i)),
      TarefasPage(onRefresh: () => setState(() {})),
      ProjetosPage(onRefresh: () => setState(() {})),
      ListasPage(onRefresh: () => setState(() {})),
      const EmpresasPage(),
      const UsuariosPage(),
    ];
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Sair', style: GoogleFonts.darkerGrotesque(fontWeight: FontWeight.w800)),
        content: Text('Deseja encerrar sua sessão?', style: GoogleFonts.darkerGrotesque()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: GoogleFonts.darkerGrotesque(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Sair', style: GoogleFonts.darkerGrotesque(
              color: Colors.white, fontWeight: FontWeight.w700,
            )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: Row(children: [
        if (isWide)
          DashboardSidebar(
            items: _navItems.toList(),
            selectedIndex: _selectedIndex,
            onSelect: (i) => setState(() => _selectedIndex = i),
            onLogout: _logout,
          ),
        Expanded(
          child: Column(children: [
            DashboardTopBar(
              title: _navItems[_selectedIndex].label,
              onLogout: _logout,
              showMenuIcon: !isWide,
              navItems: _navItems.toList(),
              selectedIndex: _selectedIndex,
              onSelect: (i) => setState(() => _selectedIndex = i),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: KeyedSubtree(
                  key: ValueKey(_selectedIndex),
                  child: _pages[_selectedIndex],
                ),
              ),
            ),
          ]),
        ),
      ]),
      bottomNavigationBar: isWide ? null : NavigationBar(
        selectedIndex: _selectedIndex.clamp(0, 3),
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primaryGreen.withValues(alpha: 0.12),
        destinations: _navItems.take(4).map((n) => NavigationDestination(
          icon: Icon(n.icon, color: AppColors.textMuted),
          selectedIcon: Icon(n.icon, color: AppColors.primaryGreen),
          label: n.label,
        )).toList(),
      ),
    );
  }
}
