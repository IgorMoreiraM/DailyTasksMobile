import 'package:flutter/material.dart';

class Projeto {
  final String id;
  String nome;
  String descricao;
  Color cor;

  Projeto({
    required this.id,
    required this.nome,
    this.descricao = '',
    required this.cor,
  });
}
