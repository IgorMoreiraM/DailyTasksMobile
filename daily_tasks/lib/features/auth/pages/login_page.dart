import 'package:flutter/material.dart';

import '../../../core/app_routes.dart';
import '../widgets/login_card.dart';
import '../../../shared/theme/app_colors.dart';

const _kUsuario = 'admin';
const _kSenha   = 'admin123';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usuarioCtrl  = TextEditingController();
  final _senhaCtrl    = TextEditingController();
  final _formKey      = GlobalKey<FormState>();

  bool   _esconderSenha = true;
  bool   _carregando    = false;
  String _erro          = '';

  @override
  void dispose() {
    _usuarioCtrl.dispose();
    _senhaCtrl.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() { _carregando = true; _erro = ''; });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    if (_usuarioCtrl.text.trim() == _kUsuario &&
        _senhaCtrl.text.trim()   == _kSenha) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else {
      setState(() => _erro = 'Usuário ou senha incorretos.');
    }
    setState(() => _carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: LoginCard(
                formKey:       _formKey,
                usuarioCtrl:   _usuarioCtrl,
                senhaCtrl:     _senhaCtrl,
                esconderSenha: _esconderSenha,
                onToggleSenha: () =>
                    setState(() => _esconderSenha = !_esconderSenha),
                carregando: _carregando,
                erro:       _erro,
                onEntrar:   _entrar,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
