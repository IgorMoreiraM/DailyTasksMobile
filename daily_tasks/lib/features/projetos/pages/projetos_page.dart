import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/models/app_state.dart';
import '../../../shared/models/tarefa.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_decorations.dart';
import '../../../shared/widgets/form_label.dart';

class ProjetosPage extends StatefulWidget {
  final VoidCallback onRefresh;
  const ProjetosPage({super.key, required this.onRefresh});

  @override
  State<ProjetosPage> createState() => _ProjetosPageState();
}

class _ProjetosPageState extends State<ProjetosPage> {
  void _abrirForm([dynamic projeto]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FormProjeto(
        projeto: projeto,
        onSalvar: () { setState(() {}); widget.onRefresh(); },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirForm(),
        backgroundColor: AppColors.primaryGreen,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Novo Projeto', style: GoogleFonts.darkerGrotesque(
          color: Colors.white, fontWeight: FontWeight.w700,
        )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Projetos', style: GoogleFonts.darkerGrotesque(
            fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark,
          )),
          Text('${AppState.projetos.length} projeto(s)', style: GoogleFonts.darkerGrotesque(
            fontSize: 13.5, color: AppColors.textMuted,
          )),
          const SizedBox(height: 20),
          ...AppState.projetos.map((p) {
            final total      = AppState.tarefasDoProjeto(p.id).length;
            final concluidas = AppState.tarefasDoProjeto(p.id)
                .where((t) => t.status == StatusTarefa.concluida).length;
            final progress   = total == 0 ? 0.0 : concluidas / total;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: AppDecorations.card(),
              child: InkWell(
                onTap: () => _abrirForm(p),
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Container(width: 14, height: 14,
                          decoration: BoxDecoration(color: p.cor, shape: BoxShape.circle)),
                      const SizedBox(width: 10),
                      Expanded(child: Text(p.nome, style: GoogleFonts.darkerGrotesque(
                        fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textDark,
                      ))),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, size: 18, color: AppColors.textMuted),
                        onSelected: (v) {
                          if (v == 'editar') { _abrirForm(p); }
                          if (v == 'excluir') {
                            setState(() {
                              AppState.removerProjeto(p.id);
                              widget.onRefresh();
                            });
                          }
                        },
                        itemBuilder: (_) => [
                          PopupMenuItem(value: 'editar',  child: _menuItem(Icons.edit_outlined,   'Editar',  AppColors.textDark)),
                          PopupMenuItem(value: 'excluir', child: _menuItem(Icons.delete_outline,  'Excluir', AppColors.errorText)),
                        ],
                      ),
                    ]),
                    if (p.descricao.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(p.descricao, style: GoogleFonts.darkerGrotesque(
                        fontSize: 12, color: AppColors.textMuted,
                      )),
                    ],
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress, minHeight: 6,
                        backgroundColor: AppColors.borderDefault, color: p.cor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(children: [
                      Text('$concluidas/$total tarefas concluídas', style: GoogleFonts.darkerGrotesque(
                        fontSize: 11, color: AppColors.textMuted,
                      )),
                      const Spacer(),
                      Text('${(progress * 100).toInt()}%', style: GoogleFonts.darkerGrotesque(
                        fontSize: 11, fontWeight: FontWeight.w700, color: p.cor,
                      )),
                    ]),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      children: AppState.listasDoProjeto(p.id).map((l) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: p.cor.withValues(alpha:0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(l.nome, style: GoogleFonts.darkerGrotesque(
                          fontSize: 11, fontWeight: FontWeight.w600, color: p.cor,
                        )),
                      )).toList(),
                    ),
                  ]),
                ),
              ),
            );
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, Color color) => Row(children: [
    Icon(icon, size: 16, color: color),
    const SizedBox(width: 8),
    Text(label, style: GoogleFonts.darkerGrotesque(color: color)),
  ]);
}

// ── Formulário de Projeto ──────────────────────────────────────
class _FormProjeto extends StatefulWidget {
  final dynamic projeto;
  final VoidCallback onSalvar;
  const _FormProjeto({this.projeto, required this.onSalvar});

  @override
  State<_FormProjeto> createState() => _FormProjetoState();
}

class _FormProjetoState extends State<_FormProjeto> {
  final _nomeCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _formKey  = GlobalKey<FormState>();
  Color _cor = AppColors.teal;

  @override
  void initState() {
    super.initState();
    final p = widget.projeto;
    if (p != null) {
      _nomeCtrl.text = p.nome;
      _descCtrl.text = p.descricao;
      _cor           = p.cor;
    }
  }

  @override
  void dispose() { _nomeCtrl.dispose(); _descCtrl.dispose(); super.dispose(); }

  void _salvar() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final p = widget.projeto;
    if (p != null) {
      p.nome      = _nomeCtrl.text.trim();
      p.descricao = _descCtrl.text.trim();
      p.cor       = _cor;
    } else {
      AppState.adicionarProjeto(
        _nomeCtrl.text.trim(), _descCtrl.text.trim(), _cor,
      );
    }
    widget.onSalvar();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24, right: 24, top: 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 40, height: 4,
            decoration: BoxDecoration(color: AppColors.borderDefault, borderRadius: BorderRadius.circular(2)))),
        const SizedBox(height: 20),
        Text(widget.projeto != null ? 'Editar Projeto' : 'Novo Projeto',
            style: GoogleFonts.darkerGrotesque(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark)),
        const SizedBox(height: 20),
        Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const FormLabel('Nome do projeto'),
          TextFormField(controller: _nomeCtrl, style: GoogleFonts.darkerGrotesque(fontSize: 14),
              decoration: AppDecorations.inputField('Ex: App Mobile'),
              validator: (v) => (v ?? '').trim().isEmpty ? 'Informe o nome' : null),
          const SizedBox(height: 16),
          const FormLabel('Descrição (opcional)'),
          TextFormField(controller: _descCtrl, maxLines: 2, style: GoogleFonts.darkerGrotesque(fontSize: 14),
              decoration: AppDecorations.inputField('Descrição do projeto...')),
          const SizedBox(height: 16),
          const FormLabel('Cor'),
          Row(children: AppColors.projectColors.map((c) => GestureDetector(
            onTap: () => setState(() => _cor = c),
            child: Container(
              margin: const EdgeInsets.only(right: 8), width: 30, height: 30,
              decoration: BoxDecoration(color: c, shape: BoxShape.circle,
                  border: Border.all(color: _cor == c ? AppColors.textDark : Colors.transparent, width: 2.5)),
              child: _cor == c ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
          )).toList()),
          const SizedBox(height: 28),
          SizedBox(width: double.infinity, height: 48,
            child: ElevatedButton(onPressed: _salvar,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: Text(widget.projeto != null ? 'Salvar' : 'Criar projeto',
                    style: GoogleFonts.darkerGrotesque(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)))),
          const SizedBox(height: 16),
        ])),
      ]),
    );
  }
}
