import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daily_tasks/features/auth/pages/login_page.dart';
import 'package:daily_tasks/core/app_routes.dart';

Widget _buildApp() {
  return MaterialApp(
    initialRoute: AppRoutes.login,
    routes: {
      AppRoutes.login:     (_) => const LoginPage(),
      AppRoutes.dashboard: (_) => const Scaffold(body: Text('DASHBOARD')),
    },
  );
}

void main() {
  group('LoginPage', () {
    testWidgets('exibe campo de usuário', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.widgetWithText(TextFormField, 'seu.usuario'), findsOneWidget);
    });

    testWidgets('exibe campo de senha', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.widgetWithText(TextFormField, '••••••••'), findsOneWidget);
    });

    testWidgets('exibe botão Entrar', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.widgetWithText(ElevatedButton, 'Entrar'), findsOneWidget);
    });

    testWidgets('mostra erro com campos vazios', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
      await tester.pump();
      expect(find.text('Informe seu usuário'), findsOneWidget);
    });

    testWidgets('navega para dashboard com admin/admin123', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.enterText(find.widgetWithText(TextFormField, 'seu.usuario'), 'admin');
      await tester.enterText(find.widgetWithText(TextFormField, '••••••••'), 'admin123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
      await tester.pumpAndSettle();
      expect(find.text('DASHBOARD'), findsOneWidget);
    });
  });
}
