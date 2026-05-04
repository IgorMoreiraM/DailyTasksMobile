# 📱 DailyTasks Mobile

Aplicativo móvel de gerenciamento de tarefas desenvolvido em **Flutter/Dart**, como versão mobile do sistema DailyTasks. Permite criar e organizar tarefas, projetos e listas com uma interface moderna e responsiva.

---

## 🚀 Funcionalidades

- **Autenticação** — tela de login com validação de formulário
- **Dashboard** — visão geral com cards de estatísticas e resumo de atividades
- **Tarefas** — criação, edição, exclusão e filtro por status e prioridade
- **Projetos** — gerenciamento de projetos com barra de progresso automática
- **Listas** — organização de tarefas em listas vinculadas a projetos
- **Empresas** — listagem de empresas cadastradas no sistema
- **Usuários** — listagem de usuários com seus cargos e vínculos
- **Responsivo** — sidebar no desktop, bottom navigation no mobile

---

## 🛠️ Tecnologias

| Tecnologia | Versão | Uso |
|---|---|---|
| Flutter | 3.x | Framework principal |
| Dart | 3.x | Linguagem |
| Google Fonts | ^6.2.1 | Fonte Darker Grotesque |
| flutter_test | SDK | Testes de widget e unitários |

---

## 📁 Estrutura do Projeto

```
daily_tasks/
├── lib/
│   ├── main.dart                        # Ponto de entrada
│   ├── core/
│   │   └── app_routes.dart              # Rotas centralizadas
│   ├── shared/
│   │   ├── models/
│   │   │   ├── tarefa.dart              # Modelo + enums Prioridade/Status
│   │   │   ├── projeto.dart
│   │   │   ├── lista.dart
│   │   │   ├── empresa.dart
│   │   │   ├── funcionario.dart
│   │   │   ├── mock_data.dart           # Dados mockados
│   │   │   └── app_state.dart           # Estado global
│   │   ├── theme/
│   │   │   ├── app_colors.dart          # Paleta de cores
│   │   │   ├── app_decorations.dart     # Decorações reutilizáveis
│   │   │   └── app_text_styles.dart     # Estilos de texto
│   │   └── widgets/
│   │       ├── app_avatar.dart
│   │       ├── app_chip.dart
│   │       ├── section_card.dart
│   │       ├── stat_card.dart
│   │       ├── form_label.dart
│   │       └── role_pill.dart
│   └── features/
│       ├── auth/
│       │   ├── pages/login_page.dart
│       │   └── widgets/login_card.dart
│       ├── dashboard/
│       │   ├── pages/
│       │   │   ├── master_dashboard_page.dart
│       │   │   └── dashboard_home_page.dart
│       │   └── widgets/
│       │       ├── dashboard_sidebar.dart
│       │       ├── dashboard_topbar.dart
│       │       └── nav_item.dart
│       ├── tarefas/
│       │   ├── pages/tarefas_page.dart
│       │   └── widgets/
│       │       ├── tarefa_card.dart
│       │       └── form_tarefa.dart
│       ├── projetos/pages/projetos_page.dart
│       ├── listas/pages/listas_page.dart
│       ├── empresas/pages/empresas_page.dart
│       └── usuarios/pages/usuarios_page.dart
└── test/
    ├── validators_test.dart
    ├── login_page_test.dart
    ├── register_page_test.dart
    └── custom_text_field_test.dart
```

---

## ⚙️ Como rodar

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado
- Android Studio (para o emulador) ou dispositivo físico
- Modo Desenvolvedor ativado no Windows (se aplicável)

### Passo a passo

**1. Clone o repositório**
```bash
git clone https://github.com/IgorMoreiraM/DailyTasksMobile.git
cd DailyTasksMobile/daily_tasks
```

**2. Instale as dependências**
```bash
flutter pub get
```

**3. Rode o app**
```bash
# No emulador/dispositivo padrão
flutter run

# No navegador
flutter run -d chrome

# No Windows
flutter run -d windows
```

---

## 🧪 Testes

O projeto possui testes unitários e de widget cobrindo validações e comportamento das telas.

```bash
# Rodar todos os testes
flutter test

# Rodar um arquivo específico
flutter test test/validators_test.dart
```

### Cobertura dos testes

| Arquivo | Tipo | Testes |
|---|---|---|
| `validators_test.dart` | Unitário | 30 casos — email, senha, nome, confirmação |
| `login_page_test.dart` | Widget | 9 casos — renderização, validação, navegação |
| `register_page_test.dart` | Widget | 10 casos — campos, validação, sucesso |
| `custom_text_field_test.dart` | Widget | 7 casos — renderização, obscureText, validator |

---

## 🎨 Identidade Visual

| Token | Valor | Uso |
|---|---|---|
| `primaryGreen` | `#4B5320` | Cor principal, sidebar, botões |
| `orange` | `#F97316` | Destaque, botão de login, logo |
| `cream` | `#FEFAE0` | Fundo das telas de auth |
| `teal` | `#2A7A8A` | Cards, projetos |
| Fonte | Darker Grotesque | Toda a tipografia |

---

## 🔐 Acesso para testes

> O sistema ainda não possui integração com backend. As credenciais abaixo são fixas para fins de desenvolvimento.

| Campo | Valor |
|---|---|
| Usuário | `admin` |
| Senha | `admin123` |

