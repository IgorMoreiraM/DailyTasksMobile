import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/models/app_state.dart';
import '../../../shared/models/tarefa.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_decorations.dart';
import '../../../shared/widgets/form_label.dart';

class FormTarefa extends StatefulWidget {
  final Tarefa? tarefa;
  final VoidCallback onSalvar;

  const FormTarefa({super.key, this.tarefa, required this.onSalvar});

  @override
  State<FormTarefa> createState() => _FormTarefaState();
}

class _FormTarefaState extends State<FormTarefa> {
  final _tituloCtrl = TextEditingController();
  final _descCtrl   = TextEditingController();
  final _formKey    = GlobalKey<FormState>();

  Prioridade _prioridade = Prioridade.media;
  String?    _projetoId;
  String?    _listaId;
  DateTime?  _prazo;

  @override
  void initState() {
    super.initState();
    final t = widget.tarefa;
    if (t != null) {
      _tituloCtrl.text = t.titulo;
      _descCtrl.text   = t.descricao;
      _prioridade      = t.prioridade;
      _projetoId       = t.projetoId;
      _listaId         = t.listaId;
      _prazo           = t.prazo;
    }
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final t = widget.tarefa;
    if (t != null) {
      t.titulo     = _tituloCtrl.text.trim();
      t.descricao  = _descCtrl.text.trim();
      t.prioridade = _prioridade;
      t.projetoId  = _projetoId;
      t.listaId    = _listaId;
      t.prazo      = _prazo;
    } else {
      AppState.adicionarTarefa(
        titulo:     _tituloCtrl.text.trim(),
        descricao:  _descCtrl.text.trim(),
        prioridade: _prioridade,
        projetoId:  _projetoId,
        listaId:    _listaId,
        prazo:      _prazo,
      );
    }
    widget.onSalvar();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final listasDisponiveis = _projetoId != null
        ? AppState.listasDoProjeto(_projetoId!)
        : <dynamic>[];

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      builder: (_, ctrl) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          controller: ctrl,
          padding: const EdgeInsets.all(24),
          children: [
            _buildHandle(),
            const SizedBox(height: 20),
            Text(
              widget.tarefa != null ? 'Editar Tarefa' : 'Nova Tarefa',
              style: GoogleFonts.darkerGrotesque(
                fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const FormLabel('Título'),
                TextFormField(
                  controller: _tituloCtrl,
                  style: GoogleFonts.darkerGrotesque(fontSize: 14),
                  decoration: AppDecorations.inputField('Ex: Revisar pull request'),
                  validator: (v) => (v ?? '').trim().isEmpty ? 'Informe o título' : null,
                ),
                const SizedBox(height: 16),

                const FormLabel('Descrição (opcional)'),
                TextFormField(
                  controller: _descCtrl,
                  maxLines: 3,
                  style: GoogleFonts.darkerGrotesque(fontSize: 14),
                  decoration: AppDecorations.inputField('Detalhes da tarefa...'),
                ),
                const SizedBox(height: 16),

                const FormLabel('Prioridade'),
                Row(
                  children: Prioridade.values.map((p) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _prioridade = p),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _prioridade == p
                                ? p.color.withValues(alpha: 0.12)
                                : AppColors.bgPage,
                            border: Border.all(
                              color: _prioridade == p ? p.color : AppColors.borderDefault,
                              width: _prioridade == p ? 1.5 : 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(children: [
                            Icon(p.icon, size: 16,
                                color: _prioridade == p ? p.color : AppColors.textMuted),
                            const SizedBox(height: 4),
                            Text(p.label, style: GoogleFonts.darkerGrotesque(
                              fontSize: 11, fontWeight: FontWeight.w700,
                              color: _prioridade == p ? p.color : AppColors.textMuted,
                            )),
                          ]),
                        ),
                      ),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 16),

                const FormLabel('Projeto (opcional)'),
                DropdownButtonFormField<String>(
                  initialValue: _projetoId,
                  style: GoogleFonts.darkerGrotesque(fontSize: 14, color: AppColors.textDark),
                  decoration: AppDecorations.inputField('Selecione um projeto'),
                  items: [
                    DropdownMenuItem(value: null, child: Text('Sem projeto',
                        style: GoogleFonts.darkerGrotesque(color: AppColors.textMuted))),
                    ...AppState.projetos.map((p) => DropdownMenuItem(
                      value: p.id,
                      child: Row(children: [
                        Container(width: 10, height: 10,
                            decoration: BoxDecoration(color: p.cor, shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        Text(p.nome),
                      ]),
                    )),
                  ],
                  onChanged: (v) => setState(() { _projetoId = v; _listaId = null; }),
                ),
                const SizedBox(height: 16),

                if (listasDisponiveis.isNotEmpty) ...[
                  const FormLabel('Lista (opcional)'),
                  DropdownButtonFormField<String>(
                    initialValue: _listaId,
                    style: GoogleFonts.darkerGrotesque(fontSize: 14, color: AppColors.textDark),
                    decoration: AppDecorations.inputField('Selecione uma lista'),
                    items: [
                      DropdownMenuItem(value: null, child: Text('Sem lista',
                          style: GoogleFonts.darkerGrotesque(color: AppColors.textMuted))),
                      ...listasDisponiveis.map((l) => DropdownMenuItem(
                        value: l.id, child: Text(l.nome),
                      )),
                    ],
                    onChanged: (v) => setState(() => _listaId = v),
                  ),
                  const SizedBox(height: 16),
                ],

                const FormLabel('Prazo (opcional)'),
                _buildPrazoPicker(context),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity, height: 48,
                  child: ElevatedButton(
                    onPressed: _salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      widget.tarefa != null ? 'Salvar alterações' : 'Criar tarefa',
                      style: GoogleFonts.darkerGrotesque(
                        fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() => Center(
    child: Container(width: 40, height: 4,
        decoration: BoxDecoration(
            color: AppColors.borderDefault, borderRadius: BorderRadius.circular(2))),
  );

  Widget _buildPrazoPicker(BuildContext context) => GestureDetector(
    onTap: () async {
      final d = await showDatePicker(
        context: context,
        initialDate: _prazo ?? DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (d != null) setState(() => _prazo = d);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderDefault),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.bgSubtle,
      ),
      child: Row(children: [
        const Icon(Icons.calendar_today_rounded, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 10),
        Text(
          _prazo != null
              ? '${_prazo!.day}/${_prazo!.month}/${_prazo!.year}'
              : 'Selecionar data',
          style: GoogleFonts.darkerGrotesque(
            fontSize: 14,
            color: _prazo != null ? AppColors.textDark : AppColors.textMuted,
          ),
        ),
        const Spacer(),
        if (_prazo != null)
          GestureDetector(
            onTap: () => setState(() => _prazo = null),
            child: const Icon(Icons.close, size: 16, color: AppColors.textMuted),
          ),
      ]),
    ),
  );
}
