import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/models/app_state.dart';
import '../../../shared/models/tarefa.dart';
import '../../../shared/theme/app_colors.dart';
import '../widgets/tarefa_card.dart';
import '../widgets/form_tarefa.dart';

class TarefasPage extends StatefulWidget {
  final VoidCallback onRefresh;
  const TarefasPage({super.key, required this.onRefresh});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  StatusTarefa? _filtroStatus;
  Prioridade?   _filtroPrioridade;

  List<Tarefa> get _tarefasFiltradas => AppState.tarefas.where((t) {
    if (_filtroStatus    != null && t.status    != _filtroStatus)    return false;
    if (_filtroPrioridade != null && t.prioridade != _filtroPrioridade) return false;
    return true;
  }).toList();

  void _abrirForm([Tarefa? tarefa]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FormTarefa(
        tarefa: tarefa,
        onSalvar: () { setState(() {}); widget.onRefresh(); },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tarefas = _tarefasFiltradas;

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirForm(),
        backgroundColor: AppColors.primaryGreen,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Nova Tarefa', style: GoogleFonts.darkerGrotesque(
          color: Colors.white, fontWeight: FontWeight.w700,
        )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Tarefas', style: GoogleFonts.darkerGrotesque(
            fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark,
          )),
          Text('${tarefas.length} tarefa(s) encontrada(s)', style: GoogleFonts.darkerGrotesque(
            fontSize: 13.5, color: AppColors.textMuted,
          )),
          const SizedBox(height: 16),

          // Filtros
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              ...StatusTarefa.values.map((s) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(s.label, style: GoogleFonts.darkerGrotesque(
                    fontSize: 12, fontWeight: FontWeight.w600,
                  )),
                  selected: _filtroStatus == s,
                  onSelected: (v) => setState(() => _filtroStatus = v ? s : null),
                  selectedColor: AppColors.primaryGreen.withValues(alpha:0.15),
                  checkmarkColor: AppColors.primaryGreen,
                ),
              )),
              const SizedBox(width: 8),
              ...Prioridade.values.map((p) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Row(children: [
                    Icon(p.icon, size: 12,
                        color: _filtroPrioridade == p ? p.color : AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(p.label, style: GoogleFonts.darkerGrotesque(
                      fontSize: 12, fontWeight: FontWeight.w600,
                    )),
                  ]),
                  selected: _filtroPrioridade == p,
                  onSelected: (v) => setState(() => _filtroPrioridade = v ? p : null),
                  selectedColor: p.color.withValues(alpha:0.12),
                  checkmarkColor: p.color,
                ),
              )),
            ]),
          ),
          const SizedBox(height: 16),

          if (tarefas.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(children: [
                  Icon(Icons.task_alt_rounded, size: 48,
                      color: AppColors.textMuted.withValues(alpha:0.4)),
                  const SizedBox(height: 12),
                  Text('Nenhuma tarefa encontrada', style: GoogleFonts.darkerGrotesque(
                    fontSize: 14, color: AppColors.textMuted,
                  )),
                ]),
              ),
            )
          else
            ...tarefas.map((t) => TarefaCard(
              tarefa: t,
              onEditar:  () => _abrirForm(t),
              onExcluir: () => setState(() {
                AppState.removerTarefa(t.id);
                widget.onRefresh();
              }),
              onStatusChanged: (s) => setState(() {
                t.status = s;
                widget.onRefresh();
              }),
            )),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
