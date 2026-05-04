class Validators {
  // ── E-mail ───────────────────────────────────────────────────
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o e-mail';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  // ── Senha ────────────────────────────────────────────────────
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe a senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  // ── Confirmação de senha ─────────────────────────────────────
  /// [original] deve ser o valor do campo "Senha" para comparação.
  static String? Function(String?) validateConfirmPassword(String? original) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Confirme sua senha';
      }
      if (value != original) {
        return 'As senhas não coincidem';
      }
      return null;
    };
  }

  // ── Nome ─────────────────────────────────────────────────────
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o nome';
    }
    return null;
  }
}