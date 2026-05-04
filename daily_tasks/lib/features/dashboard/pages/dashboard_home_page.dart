import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/models/app_state.dart';
import '../../../shared/models/mock_data.dart';
import '../../../shared/models/tarefa.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/app_chip.dart';
import '../../../shared/widgets/section_card.dart';
import '../../../shared/widgets/stat_card.dart';

class DashboardHomePage extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const DashboardHomePage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final pendentes  = AppState.tarefas.where((t) => t.status == StatusTarefa.pendente).length;
    final andamento  = AppState.tarefas.where((t) => t.status == StatusTarefa.emAndamento).length;
    final concluidas = AppState.tarefas.where((t) => t.status == StatusTarefa.concluida).length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Visão Global', style: GoogleFonts.darkerGrotesque(
          fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark,
        )),
        Text('Resumo geral do sistema DailyTasks', style: GoogleFonts.darkerGrotesque(
          fontSize: 13.5, color: AppColors.textMuted,
        )),
        const SizedBox(height: 20),

        LayoutBuilder(builder: (_, constraints) {
          final cols = constraints.maxWidth > 500 ? 4 : 2;
          return GridView.count(
            crossAxisCount: cols, crossAxisSpacing: 12, mainAxisSpacing: 12,
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.4,
            children: [
              StatCard(label: 'Projetos',     value: '${AppState.projetos.length}', icon: Icons.folder_rounded,         color: AppColors.teal),
              StatCard(label: 'Pendentes',    value: '$pendentes',                  icon: Icons.pending_actions_rounded, color: AppColors.orange),
              StatCard(label: 'Em andamento', value: '$andamento',                  icon: Icons.play_circle_rounded,    color: AppColors.primaryGreen),
              StatCard(label: 'Concluídas',   value: '$concluidas',                 icon: Icons.check_circle_rounded,   color: AppColors.successGreen),
            ],
          );
        }),

        const SizedBox(height: 20),

        SectionCard(
          title: 'Tarefas recentes',
          subtitle: '${AppState.tarefas.length} no total',
          action: TextButton(
            onPressed: () => onNavigate(1),
            child: Text('Ver todas', style: GoogleFonts.darkerGrotesque(
              color: AppColors.primaryGreen, fontWeight: FontWeight.w700, fontSize: 12,
            )),
          ),
          child: Column(
            children: AppState.tarefas.take(4).map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.borderDefault)),
              ),
              child: Row(children: [
                Container(width: 8, height: 8,
                    decoration: BoxDecoration(color: t.prioridade.color, shape: BoxShape.circle)),
                const SizedBox(width: 10),
                Expanded(child: Text(t.titulo, style: GoogleFonts.darkerGrotesque(
                  fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.textDark,
                ), maxLines: 1, overflow: TextOverflow.ellipsis)),
                const SizedBox(width: 8),
                AppChip(label: t.status.label, color: t.status.color),
              ]),
            )).toList(),
          ),
        ),

        const SizedBox(height: 16),

        SectionCard(
          title: 'Projetos ativos',
          subtitle: '${AppState.projetos.length} projetos',
          action: TextButton(
            onPressed: () => onNavigate(2),
            child: Text('Ver todos', style: GoogleFonts.darkerGrotesque(
              color: AppColors.primaryGreen, fontWeight: FontWeight.w700, fontSize: 12,
            )),
          ),
          child: Column(
            children: AppState.projetos.map((p) {
              final total = AppState.tarefasDoProjeto(p.id).length;
              final done  = AppState.tarefasDoProjeto(p.id).where((t) => t.status == StatusTarefa.concluida).length;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderDefault)),
                ),
                child: Row(children: [
                  Container(width: 10, height: 10,
                      decoration: BoxDecoration(color: p.cor, shape: BoxShape.circle)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(p.nome, style: GoogleFonts.darkerGrotesque(
                    fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.textDark,
                  ))),
                  Text('$done/$total', style: GoogleFonts.darkerGrotesque(
                    fontSize: 12, color: AppColors.textMuted,
                  )),
                ]),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        SectionCard(
          title: 'Empresas',
          subtitle: '${mockEmpresas.length} no sistema',
          action: TextButton(
            onPressed: () => onNavigate(4),
            child: Text('Ver todas', style: GoogleFonts.darkerGrotesque(
              color: AppColors.primaryGreen, fontWeight: FontWeight.w700, fontSize: 12,
            )),
          ),
          child: Column(
            children: mockEmpresas.map((emp) {
              final gestor = mockFuncionarios
                  .where((f) => f.role == 'GESTOR' && f.empresaId == emp.id)
                  .firstOrNull;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderDefault)),
                ),
                child: Row(children: [
                  AppAvatar(name: emp.nome),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(emp.nome, style: GoogleFonts.darkerGrotesque(
                      fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.textDark,
                    )),
                    Text(emp.cnpj, style: GoogleFonts.darkerGrotesque(
                      fontSize: 12, color: AppColors.textMuted,
                    )),
                  ])),
                  gestor != null
                      ? Text(gestor.nomeCompleto, style: GoogleFonts.darkerGrotesque(
                          fontSize: 12, color: AppColors.textSecondary))
                      : Text('Sem gestor', style: GoogleFonts.darkerGrotesque(
                          fontSize: 12, color: Colors.amber.shade700)),
                ]),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

