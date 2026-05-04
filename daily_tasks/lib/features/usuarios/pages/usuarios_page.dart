import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/models/mock_data.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/role_pill.dart';
import '../../../shared/widgets/section_card.dart';

class UsuariosPage extends StatelessWidget {
  const UsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Usuários', style: GoogleFonts.darkerGrotesque(
          fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark,
        )),
        Text('${mockFuncionarios.length} usuários no sistema', style: GoogleFonts.darkerGrotesque(
          fontSize: 13.5, color: AppColors.textMuted,
        )),
        const SizedBox(height: 20),
        SectionCard(
          title: 'Todos os usuários',
          child: Column(
            children: mockFuncionarios.map((f) {
              final empresa = mockEmpresas
                  .where((e) => e.id == f.empresaId)
                  .firstOrNull;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderDefault)),
                ),
                child: Row(children: [
                  AppAvatar(name: f.nomeCompleto),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(f.nomeCompleto, style: GoogleFonts.darkerGrotesque(
                      fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.textDark,
                    )),
                    Text('@${f.username}', style: GoogleFonts.darkerGrotesque(
                      fontSize: 12, color: AppColors.textMuted,
                    )),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    RolePill(role: f.role),
                    const SizedBox(height: 3),
                    Text(empresa?.nome ?? '—', style: GoogleFonts.darkerGrotesque(
                      fontSize: 11, color: AppColors.textMuted,
                    )),
                  ]),
                ]),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
