import 'package:flutter/material.dart';

enum Prioridade { baixa, media, alta }

extension PrioridadeExt on Prioridade {
  String get label {
    switch (this) {
      case Prioridade.baixa: return 'Baixa';
      case Prioridade.media: return 'Média';
      case Prioridade.alta:  return 'Alta';
    }
  }

  Color get color {
    switch (this) {
      case Prioridade.baixa: return const Color(0xFF16A34A);
      case Prioridade.media: return const Color(0xFFD97706);
      case Prioridade.alta:  return const Color(0xFFDC2626);
    }
  }

  IconData get icon {
    switch (this) {
      case Prioridade.baixa: return Icons.arrow_downward_rounded;
      case Prioridade.media: return Icons.remove_rounded;
      case Prioridade.alta:  return Icons.arrow_upward_rounded;
    }
  }
}

enum StatusTarefa { pendente, emAndamento, concluida }

extension StatusTarefaExt on StatusTarefa {
  String get label {
    switch (this) {
      case StatusTarefa.pendente:    return 'Pendente';
      case StatusTarefa.emAndamento: return 'Em andamento';
      case StatusTarefa.concluida:   return 'Concluída';
    }
  }

  Color get color {
    switch (this) {
      case StatusTarefa.pendente:    return const Color(0xFF9CA3AF);
      case StatusTarefa.emAndamento: return const Color(0xFF2A7A8A);
      case StatusTarefa.concluida:   return const Color(0xFF16A34A);
    }
  }
}

class Tarefa {
  final String id;
  String titulo;
  String descricao;
  Prioridade prioridade;
  StatusTarefa status;
  DateTime? prazo;
  String? projetoId;
  String? listaId;

  Tarefa({
    required this.id,
    required this.titulo,
    this.descricao = '',
    this.prioridade = Prioridade.media,
    this.status = StatusTarefa.pendente,
    this.prazo,
    this.projetoId,
    this.listaId,
  });
}
