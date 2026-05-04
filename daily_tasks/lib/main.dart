import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/app_routes.dart';
import 'shared/theme/app_colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        primary: AppColors.primaryGreen,
        secondary: AppColors.secondaryGreen,
      ),
      textTheme: GoogleFonts.darkerGrotesqueTextTheme(
        ThemeData.light().textTheme,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DailyTasks',
      theme: base,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
