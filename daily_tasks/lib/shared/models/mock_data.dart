import 'package:flutter/material.dart';

import 'empresa.dart';
import 'funcionario.dart';
import 'lista.dart';
import 'projeto.dart';
import 'tarefa.dart';

// ── Empresas ──────────────────────────────────────────────────
const List<Empresa> mockEmpresas = [
  Empresa(id: 1, nome: 'TechNova Ltda',    cnpj: '12.345.678/0001-90'),
  Empresa(id: 2, nome: 'Agro Sul S/A',     cnpj: '98.765.432/0001-10'),
  Empresa(id: 3, nome: 'Construmax Obras', cnpj: '55.444.333/0001-22'),
];

// ── Funcionários ──────────────────────────────────────────────
const List<Funcionario> mockFuncionarios = [
  Funcionario(id: 1, nomeCompleto: 'Carlos Mendes',  username: 'carlos.mendes',  role: 'GESTOR',      empresaId: 1),
  Funcionario(id: 2, nomeCompleto: 'Ana Souza',       username: 'ana.souza',       role: 'GERENTE',     empresaId: 1),
  Funcionario(id: 3, nomeCompleto: 'Pedro Lima',      username: 'pedro.lima',      role: 'FUNCIONARIO', empresaId: 1),
  Funcionario(id: 4, nomeCompleto: 'Mariana Costa',  username: 'mariana.costa',  role: 'GESTOR',      empresaId: 2),
  Funcionario(id: 5, nomeCompleto: 'Roberto Alves',  username: 'roberto.alves',  role: 'FUNCIONARIO', empresaId: 2),
  Funcionario(id: 6, nomeCompleto: 'Fernanda Rocha', username: 'fernanda.rocha', role: 'GESTOR',      empresaId: 3),
  Funcionario(id: 7, nomeCompleto: 'Lucas Pereira',  username: 'lucas.pereira',  role: 'GERENTE',     empresaId: 3),
  Funcionario(id: 8, nomeCompleto: 'Juliana Neves',  username: 'juliana.neves',  role: 'FUNCIONARIO', empresaId: 3),
];

// ── Projetos ──────────────────────────────────────────────────
List<Projeto> mockProjetos = [
  Projeto(id: 'p1', nome: 'App Mobile',     descricao: 'Desenvolvimento Flutter', cor: const Color(0xFF2A7A8A)),
  Projeto(id: 'p2', nome: 'Marketing',      descricao: 'Campanhas e materiais',   cor: const Color(0xFFF97316)),
  Projeto(id: 'p3', nome: 'Infraestrutura', descricao: 'Servidores e deploy',     cor: const Color(0xFF7C3AED)),
];

// ── Listas ────────────────────────────────────────────────────
List<Lista> mockListas = [
  Lista(id: 'l1', nome: 'Backlog',    projetoId: 'p1'),
  Lista(id: 'l2', nome: 'Sprint 1',   projetoId: 'p1'),
  Lista(id: 'l3', nome: 'Ideias',     projetoId: 'p2'),
  Lista(id: 'l4', nome: 'Execução',   projetoId: 'p2'),
  Lista(id: 'l5', nome: 'Pendências', projetoId: 'p3'),
];

// ── Tarefas ───────────────────────────────────────────────────
List<Tarefa> mockTarefas = [
  Tarefa(id: 't1', titulo: 'Criar tela de login',      prioridade: Prioridade.alta,  status: StatusTarefa.concluida,   projetoId: 'p1', listaId: 'l1'),
  Tarefa(id: 't2', titulo: 'Integrar API de usuários', prioridade: Prioridade.alta,  status: StatusTarefa.emAndamento, projetoId: 'p1', listaId: 'l2'),
  Tarefa(id: 't3', titulo: 'Testes unitários',         prioridade: Prioridade.media, status: StatusTarefa.pendente,    projetoId: 'p1', listaId: 'l2'),
  Tarefa(id: 't4', titulo: 'Post no Instagram',        prioridade: Prioridade.media, status: StatusTarefa.pendente,    projetoId: 'p2', listaId: 'l3'),
  Tarefa(id: 't5', titulo: 'Configurar CI/CD',         prioridade: Prioridade.alta,  status: StatusTarefa.emAndamento, projetoId: 'p3', listaId: 'l5'),
  Tarefa(id: 't6', titulo: 'Backup automático',        prioridade: Prioridade.baixa, status: StatusTarefa.pendente,    projetoId: 'p3', listaId: 'l5'),
  Tarefa(id: 't7', titulo: 'Reunião de alinhamento',   prioridade: Prioridade.media, status: StatusTarefa.pendente),
];
