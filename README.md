# Doa.Me
# DOA.ME

O **DOA.ME** é uma aplicação desenvolvida para auxiliar na visualização de estoques de sangue por região e facilitar o acesso de possíveis doadores aos hemocentros disponíveis.

O projeto possui integração com Firebase, permitindo autenticação de usuários e consulta de dados em tempo real.

## Objetivo

Desenvolver uma solução digital para aproximar doadores e hemocentros, exibindo a disponibilidade de bolsas de sangue por tipo sanguíneo e por região.

## Funcionalidades

* Cadastro de usuários
* Login com Firebase Authentication
* Seleção de região
* Visualização do estoque de sangue por tipo sanguíneo
* Classificação do estoque em:

  * Boa Quantidade
  * Média Quantidade
  * Urgente
* Atualização dos dados a partir do Firebase
* Formulário de doação
* Triagem preliminar de aptidão
* Resultado da triagem
* Exibição de hemocentros disponíveis
* Acesso ao Google Maps
* Logout de usuário

## Tecnologias Utilizadas

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Firebase Core
* URL Launcher

## Arquitetura

O projeto foi organizado seguindo o padrão **MVVM**.

```text
lib/
├── models/
├── views/
├── viewmodels/
├── services/
├── widgets/
└── main.dart
```

### Camadas

**Views:** telas da aplicação.
**ViewModels:** regras de apresentação e comunicação com os dados.
**Services:** integração com Firebase.
**Widgets:** componentes reutilizáveis.
**Models:** estruturas de dados do sistema.

## Estrutura Principal

```text
lib/
├── main.dart
├── views/
│   ├── login_view.dart
│   ├── cadastro_view.dart
│   ├── regiao_view.dart
│   ├── menu_view.dart
│   ├── formulario_view.dart
│   ├── triagem_view.dart
│   └── resultado_doacao_view.dart
├── viewmodels/
│   ├── auth_viewmodel.dart
│   └── hemocentro_viewmodel.dart
├── widgets/
│   ├── hexagon_painter.dart
│   ├── input_decoration.dart
│   └── motivacao_card.dart
└── firebase_options.dart
```

## Funcionamento

O usuário realiza cadastro ou login no aplicativo. Após a autenticação, seleciona uma região disponível, como Salvador ou Feira de Santana.

A aplicação consulta os dados cadastrados no Cloud Firestore, soma os estoques dos hemocentros da região escolhida e exibe a quantidade total de bolsas por tipo sanguíneo.

Depois disso, o usuário pode acessar o formulário de doação, responder à triagem preliminar e visualizar se está apto ou não para doar sangue.

## Firebase

O projeto utiliza:

### Firebase Authentication

Responsável pelo cadastro e login dos usuários.

### Cloud Firestore

Responsável por armazenar e consultar os dados dos hemocentros e seus estoques.

Exemplo de estrutura esperada:

```text
hemocentros
└── documento
    ├── cidade: "Salvador"
    ├── nome: "Hemocentro Exemplo"
    └── estoque
        ├── A+: 120
        ├── A-: 40
        ├── B+: 80
        ├── B-: 30
        ├── AB+: 20
        ├── AB-: 10
        ├── O+: 200
        └── O-: 50
```

## Como executar o projeto

Clone o repositório:

```bash
git clone URL_DO_REPOSITORIO
```

Entre na pasta do projeto:

```bash
cd nome-do-projeto
```

Instale as dependências:

```bash
flutter pub get
```

Execute no navegador:

```bash
flutter run -d chrome
```

## Configuração do Firebase

Para rodar corretamente, é necessário configurar o Firebase no projeto:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Depois disso, o arquivo abaixo será gerado:

```text
lib/firebase_options.dart
```

## Dependências principais

```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core:
  firebase_auth:
  cloud_firestore:
  url_launcher:
```

## Status do Projeto

Projeto em desenvolvimento acadêmico, com foco em:

* autenticação
* banco de dados em tempo real
* arquitetura MVVM
* integração entre aplicativo e Firebase
* apoio ao processo de doação de sangue

## Trabalhos Futuros

* Geolocalização automática
* Notificações push
* Histórico de doações
* Dashboard administrativo
* Melhorias visuais
* Integração completa com aplicação web
* Relatórios de estoque por hemocentro

## Autores

Estudantes da Unifan (Universidade Nobre)

Artur Gonçalves
Itauana Dourado
Gustavo Fernandes
Kevin Reis
Juan de Jesus
Gustavo Batista 
Projeto desenvolvido para fins acadêmicos.

## Licença

Este projeto é de uso educacional.
