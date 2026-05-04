import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/models/app_state.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_decorations.dart';
import '../../../shared/widgets/form_label.dart';

class ListasPage extends StatefulWidget {
  final VoidCallback onRefresh;
  const ListasPage({super.key, required this.onRefresh});

  @override
  State<ListasPage> createState() => _ListasPageState();
}

class _ListasPageState extends State<ListasPage> {
  String? _projetoFiltro;

  void _abrirForm([dynamic lista]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FormLista(
        lista: lista,
        onSalvar: () { setState(() {}); widget.onRefresh(); },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listas = _projetoFiltro != null
        ? AppState.listasDoProjeto(_projetoFiltro!)
        : AppState.listas;

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirForm(),
        backgroundColor: AppColors.primaryGreen,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Nova Lista', style: GoogleFonts.darkerGrotesque(
          color: Colors.white, fontWeight: FontWeight.w700,
        )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Listas', style: GoogleFonts.darkerGrotesque(
            fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark,
          )),
          Text('${listas.length} lista(s)', style: GoogleFonts.darkerGrotesque(
            fontSize: 13.5, color: AppColors.textMuted,
          )),
          const SizedBox(height: 16),

          // Filtro por projeto
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text('Todos', style: GoogleFonts.darkerGrotesque(
                    fontSize: 12, fontWeight: FontWeight.w600,
                  )),
                  selected: _projetoFiltro == null,
                  onSelected: (_) => setState(() => _projetoFiltro = null),
                  selectedColor: AppColors.primaryGreen.withValues(alpha:0.15),
                  checkmarkColor: AppColors.primaryGreen,
                ),
              ),
              ...AppState.projetos.map((p) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Row(children: [
                    Container(width: 8, height: 8,
                        decoration: BoxDecoration(color: p.cor, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text(p.nome, style: GoogleFonts.darkerGrotesque(
                      fontSize: 12, fontWeight: FontWeight.w600,
                    )),
                  ]),
                  selected: _projetoFiltro == p.id,
                  onSelected: (v) => setState(() => _projetoFiltro = v ? p.id : null),
                  selectedColor: p.cor.withValues(alpha:0.12),
                  checkmarkColor: p.cor,
                ),
              )),
            ]),
          ),
          const SizedBox(height: 16),

          ...listas.map((l) {
            final projeto = AppState.projetoPorId(l.projetoId);
            final qtd     = AppState.tarefasDaLista(l.id).length;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: AppDecorations.card(),
              child: InkWell(
                onTap: () => _abrirForm(l),
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: (projeto?.cor ?? AppColors.textMuted).withValues(alpha:0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.list_alt_rounded,
                          color: projeto?.cor ?? AppColors.textMuted, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(l.nome, style: GoogleFonts.darkerGrotesque(
                        fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark,
                      )),
                      if (projeto != null)
                        Text(projeto.nome, style: GoogleFonts.darkerGrotesque(
                          fontSize: 12, color: AppColors.textMuted,
                        )),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('$qtd', style: GoogleFonts.darkerGrotesque(
                        fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark,
                      )),
                      Text('tarefas', style: GoogleFonts.darkerGrotesque(
                        fontSize: 11, color: AppColors.textMuted,
                      )),
                    ]),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 18, color: AppColors.textMuted),
                      onSelected: (v) {
                        if (v == 'editar') { _abrirForm(l); }
                        if (v == 'excluir') {
                          setState(() {
                            AppState.removerLista(l.id);
                            widget.onRefresh();
                          });
                        }
                      },
                      itemBuilder: (_) => [
                        PopupMenuItem(value: 'editar',  child: _menuItem(Icons.edit_outlined,  'Editar',  AppColors.textDark)),
                        PopupMenuItem(value: 'excluir', child: _menuItem(Icons.delete_outline, 'Excluir', AppColors.errorText)),
                      ],
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

// ── Formulário de Lista ────────────────────────────────────────
class _FormLista extends StatefulWidget {
  final dynamic lista;
  final VoidCallback onSalvar;
  const _FormLista({this.lista, required this.onSalvar});

  @override
  State<_FormLista> createState() => _FormListaState();
}

class _FormListaState extends State<_FormLista> {
  final _nomeCtrl = TextEditingController();
  final _formKey  = GlobalKey<FormState>();
  String? _projetoId;

  @override
  void initState() {
    super.initState();
    final l = widget.lista;
    if (l != null) { _nomeCtrl.text = l.nome; _projetoId = l.projetoId; }
  }

  @override
  void dispose() { _nomeCtrl.dispose(); super.dispose(); }

  void _salvar() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_projetoId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Selecione um projeto', style: GoogleFonts.darkerGrotesque()),
        backgroundColor: AppColors.errorText,
      ));
      return;
    }
    final l = widget.lista;
    if (l != null) {
      l.nome      = _nomeCtrl.text.trim();
      l.projetoId = _projetoId!;
    } else {
      AppState.adicionarLista(_nomeCtrl.text.trim(), _projetoId!);
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
        Text(widget.lista != null ? 'Editar Lista' : 'Nova Lista',
            style: GoogleFonts.darkerGrotesque(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark)),
        const SizedBox(height: 20),
        Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const FormLabel('Nome da lista'),
          TextFormField(controller: _nomeCtrl, style: GoogleFonts.darkerGrotesque(fontSize: 14),
              decoration: AppDecorations.inputField('Ex: Sprint 1'),
              validator: (v) => (v ?? '').trim().isEmpty ? 'Informe o nome' : null),
          const SizedBox(height: 16),
          const FormLabel('Projeto'),
          DropdownButtonFormField<String>(
            initialValue: _projetoId,
            style: GoogleFonts.darkerGrotesque(fontSize: 14, color: AppColors.textDark),
            decoration: AppDecorations.inputField('Selecione o projeto'),
            items: AppState.projetos.map((p) => DropdownMenuItem(
              value: p.id,
              child: Row(children: [
                Container(width: 10, height: 10,
                    decoration: BoxDecoration(color: p.cor, shape: BoxShape.circle)),
                const SizedBox(width: 8), Text(p.nome),
              ]),
            )).toList(),
            onChanged: (v) => setState(() => _projetoId = v),
          ),
          const SizedBox(height: 28),
          SizedBox(width: double.infinity, height: 48,
            child: ElevatedButton(onPressed: _salvar,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: Text(widget.lista != null ? 'Salvar' : 'Criar lista',
                    style: GoogleFonts.darkerGrotesque(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)))),
          const SizedBox(height: 16),
        ])),
      ]),
    );
  }
}
