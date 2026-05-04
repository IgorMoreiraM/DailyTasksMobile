import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/models/app_state.dart';
import '../../../shared/models/tarefa.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/app_chip.dart';

class TarefaCard extends StatelessWidget {
  final Tarefa tarefa;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;
  final ValueChanged<StatusTarefa> onStatusChanged;

  const TarefaCard({
    super.key,
    required this.tarefa,
    required this.onEditar,
    required this.onExcluir,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final projeto   = tarefa.projetoId != null ? AppState.projetoPorId(tarefa.projetoId!) : null;
    final concluida = tarefa.status == StatusTarefa.concluida;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: InkWell(
        onTap: onEditar,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () => onStatusChanged(
                concluida ? StatusTarefa.pendente : StatusTarefa.concluida,
              ),
              child: Container(
                width: 22, height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: concluida ? AppColors.successGreen : AppColors.borderDefault,
                    width: 2,
                  ),
                  color: concluida ? AppColors.successGreen : Colors.transparent,
                ),
                child: concluida
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                tarefa.titulo,
                style: GoogleFonts.darkerGrotesque(
                  fontSize: 14, fontWeight: FontWeight.w700,
                  color: concluida ? AppColors.textMuted : AppColors.textDark,
                  decoration: concluida ? TextDecoration.lineThrough : null,
                ),
              ),
              if (tarefa.descricao.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(tarefa.descricao, style: GoogleFonts.darkerGrotesque(
                  fontSize: 12, color: AppColors.textMuted,
                ), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 4, children: [
                AppChip(label: tarefa.prioridade.label, icon: tarefa.prioridade.icon, color: tarefa.prioridade.color),
                AppChip(label: tarefa.status.label, color: tarefa.status.color),
                if (projeto != null) AppChip(label: projeto.nome, color: projeto.cor),
                if (tarefa.prazo != null)
                  AppChip(
                    label: '${tarefa.prazo!.day}/${tarefa.prazo!.month}/${tarefa.prazo!.year}',
                    icon: Icons.calendar_today_rounded,
                    color: AppColors.textSecondary,
                  ),
              ]),
            ])),

            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, size: 18, color: AppColors.textMuted),
              onSelected: (v) {
                if (v == 'editar')    onEditar();
                if (v == 'excluir')   onExcluir();
                if (v == 'andamento') onStatusChanged(StatusTarefa.emAndamento);
              },
              itemBuilder: (_) => [
                PopupMenuItem(value: 'editar',    child: _menuItem(Icons.edit_outlined,       'Editar',       AppColors.textDark)),
                PopupMenuItem(value: 'andamento', child: _menuItem(Icons.play_circle_outline, 'Em andamento', AppColors.teal)),
                PopupMenuItem(value: 'excluir',   child: _menuItem(Icons.delete_outline,      'Excluir',      AppColors.errorText)),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, Color color) => Row(children: [
    Icon(icon, size: 16, color: color),
    const SizedBox(width: 8),
    Text(label, style: GoogleFonts.darkerGrotesque(color: color)),
  ]);
}
