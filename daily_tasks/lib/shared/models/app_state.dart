import 'lista.dart';
import 'mock_data.dart';
import 'projeto.dart';
import 'tarefa.dart';

import 'package:flutter/material.dart';

class AppState {
  AppState._();

  static List<Projeto> get projetos => mockProjetos;
  static List<Lista>   get listas   => mockListas;
  static List<Tarefa>  get tarefas  => mockTarefas;

  static List<Tarefa> tarefasDoProjeto(String projetoId) =>
      tarefas.where((t) => t.projetoId == projetoId).toList();

  static List<Tarefa> tarefasDaLista(String listaId) =>
      tarefas.where((t) => t.listaId == listaId).toList();

  static List<Lista> listasDoProjeto(String projetoId) =>
      listas.where((l) => l.projetoId == projetoId).toList();

  static Projeto? projetoPorId(String id) =>
      projetos.where((p) => p.id == id).firstOrNull;

  static String _uid() => DateTime.now().microsecondsSinceEpoch.toString();

  static void adicionarProjeto(String nome, String descricao, Color cor) =>
      projetos.add(Projeto(id: _uid(), nome: nome, descricao: descricao, cor: cor));

  static void removerProjeto(String id) {
    projetos.removeWhere((p) => p.id == id);
    final idsListas = listas.where((l) => l.projetoId == id).map((l) => l.id).toList();
    listas.removeWhere((l) => l.projetoId == id);
    tarefas.removeWhere((t) => idsListas.contains(t.listaId) || t.projetoId == id);
  }

  static void adicionarLista(String nome, String projetoId) =>
      listas.add(Lista(id: _uid(), nome: nome, projetoId: projetoId));

  static void removerLista(String id) {
    listas.removeWhere((l) => l.id == id);
    tarefas.removeWhere((t) => t.listaId == id);
  }

  static void adicionarTarefa({
    required String titulo,
    String descricao = '',
    Prioridade prioridade = Prioridade.media,
    String? projetoId,
    String? listaId,
    DateTime? prazo,
  }) =>
      tarefas.add(Tarefa(
        id: _uid(),
        titulo: titulo,
        descricao: descricao,
        prioridade: prioridade,
        projetoId: projetoId,
        listaId: listaId,
        prazo: prazo,
      ));

  static void removerTarefa(String id) =>
      tarefas.removeWhere((t) => t.id == id);
}
