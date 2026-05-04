import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/models/mock_data.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/section_card.dart';

class EmpresasPage extends StatelessWidget {
  const EmpresasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Empresas', style: GoogleFonts.darkerGrotesque(
          fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark,
        )),
        Text('${mockEmpresas.length} empresas cadastradas', style: GoogleFonts.darkerGrotesque(
          fontSize: 13.5, color: AppColors.textMuted,
        )),
        const SizedBox(height: 20),
        SectionCard(
          title: 'Todas as empresas',
          child: Column(
            children: mockEmpresas.map((emp) {
              final gestor = mockFuncionarios
                  .where((f) => f.role == 'GESTOR' && f.empresaId == emp.id)
                  .firstOrNull;
              final total = mockFuncionarios
                  .where((f) => f.empresaId == emp.id).length;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderDefault)),
                ),
                child: Row(children: [
                  AppAvatar(name: emp.nome),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(emp.nome, style: GoogleFonts.darkerGrotesque(
                      fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark,
                    )),
                    Text('CNPJ: ${emp.cnpj}', style: GoogleFonts.darkerGrotesque(
                      fontSize: 12, color: AppColors.textMuted,
                    )),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('$total usuários', style: GoogleFonts.darkerGrotesque(
                      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryGreen,
                    )),
                    Text(
                      gestor != null ? gestor.nomeCompleto : 'Sem gestor',
                      style: GoogleFonts.darkerGrotesque(
                        fontSize: 11.5, color: AppColors.textMuted,
                      ),
                    ),
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
