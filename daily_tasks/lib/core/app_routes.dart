import 'package:flutter/material.dart';

import '../features/auth/pages/login_page.dart';
import '../features/dashboard/pages/master_dashboard_page.dart';

class AppRoutes {
  static const String login     = '/';
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> get routes => {
    login:     (_) => const LoginPage(),
    dashboard: (_) => const MasterDashboardPage(),
  };
}
