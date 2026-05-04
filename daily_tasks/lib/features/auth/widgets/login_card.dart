import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_decorations.dart';

class LoginCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usuarioCtrl;
  final TextEditingController senhaCtrl;
  final bool esconderSenha;
  final VoidCallback onToggleSenha;
  final bool carregando;
  final String erro;
  final VoidCallback onEntrar;

  const LoginCard({
    super.key,
    required this.formKey,
    required this.usuarioCtrl,
    required this.senhaCtrl,
    required this.esconderSenha,
    required this.onToggleSenha,
    required this.carregando,
    required this.erro,
    required this.onEntrar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 40, offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLogo(),
            const SizedBox(height: 22),
            _buildTitle(),
            const SizedBox(height: 20),
            if (erro.isNotEmpty) ...[_buildErro(), const SizedBox(height: 16)],
            _buildFieldLabel('Usuário'),
            const SizedBox(height: 6),
            _buildUsuarioField(),
            const SizedBox(height: 14),
            _buildFieldLabel('Senha'),
            const SizedBox(height: 6),
            _buildSenhaField(),
            const SizedBox(height: 22),
            _buildBotao(),
            const SizedBox(height: 20),
            _buildRodape(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() => Row(children: [
    Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen, borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.task_alt_rounded, color: Colors.white, size: 20),
    ),
    const SizedBox(width: 10),
    RichText(
      text: TextSpan(
        style: GoogleFonts.darkerGrotesque(
          fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark,
        ),
        children: const [
          TextSpan(text: 'Daily'),
          TextSpan(text: 'Tasks', style: TextStyle(color: AppColors.orange)),
        ],
      ),
    ),
  ]);

  Widget _buildTitle() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Bem-vindo de volta', style: GoogleFonts.darkerGrotesque(
      fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textDark, height: 1.1,
    )),
    const SizedBox(height: 4),
    Text('Entre com suas credenciais para acessar.', style: GoogleFonts.darkerGrotesque(
      fontSize: 13.5, color: AppColors.textMuted,
    )),
  ]);

  Widget _buildErro() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: AppColors.errorBg,
      border: Border.all(color: AppColors.errorBorder),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(children: [
      const Icon(Icons.error_outline_rounded, size: 15, color: AppColors.errorText),
      const SizedBox(width: 8),
      Expanded(child: Text(erro, style: GoogleFonts.darkerGrotesque(
        fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.errorText,
      ))),
    ]),
  );

  Widget _buildFieldLabel(String text) => Text(text, style: GoogleFonts.darkerGrotesque(
    fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textDark,
  ));

  Widget _buildUsuarioField() => TextFormField(
    controller: usuarioCtrl,
    textInputAction: TextInputAction.next,
    style: GoogleFonts.darkerGrotesque(fontSize: 13.5, color: AppColors.textDark),
    decoration: AppDecorations.loginField(
      label: 'seu.usuario', icon: Icons.person_outline_rounded,
    ),
    validator: (v) => (v ?? '').trim().isEmpty ? 'Informe seu usuário' : null,
  );

  Widget _buildSenhaField() => TextFormField(
    controller: senhaCtrl,
    obscureText: esconderSenha,
    textInputAction: TextInputAction.done,
    onFieldSubmitted: (_) => onEntrar(),
    style: GoogleFonts.darkerGrotesque(fontSize: 13.5, color: AppColors.textDark),
    decoration: AppDecorations.loginField(
      label: '••••••••',
      icon: Icons.lock_outline_rounded,
      suffix: IconButton(
        onPressed: onToggleSenha,
        icon: Icon(
          esconderSenha ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 16, color: AppColors.textMuted,
        ),
      ),
    ),
    validator: (v) => (v ?? '').trim().isEmpty ? 'Informe sua senha' : null,
  );

  Widget _buildBotao() => SizedBox(
    width: double.infinity, height: 46,
    child: ElevatedButton(
      onPressed: carregando ? null : onEntrar,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,
        disabledBackgroundColor: AppColors.orange.withValues(alpha: 0.6),
        foregroundColor: Colors.white, elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: carregando
          ? const SizedBox(height: 18, width: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Entrar', style: GoogleFonts.darkerGrotesque(
                fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white,
              )),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white),
            ]),
    ),
  );

  Widget _buildRodape() => Center(
    child: Text(
      'Contas são criadas pelo administrador da empresa.',
      textAlign: TextAlign.center,
      style: GoogleFonts.darkerGrotesque(fontSize: 11, color: AppColors.textMuted),
    ),
  );
}
