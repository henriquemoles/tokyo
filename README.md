# 🏯 Tokyo Marine – Desafio Técnico Flutter

Este projeto foi desenvolvido como parte de um **desafio técnico para a vaga Flutter Developer na Tokyo Marine**.  
O objetivo principal foi demonstrar não só domínio de Flutter, mas também atenção à arquitetura, testes, segurança, boas práticas e experiência do usuário, tanto para **mobile** quanto para **web**.

##  https://first-project-hfm.web.app/ 
##  apk disponivel para download na raiz o projeto
##  !! Não tive acesso aos assets no email, utilizei um svg que achei no google
##  estou disponibilizando prints do firebase numa pasta chamada prints

---

## 🚀 Visão geral

O app permite ao usuário:

- Fazer login via CPF e senha (Firebase Auth + Firestore)  
- Armazenar credenciais de forma segura usando `flutter_secure_storage`  
- Navegação declarativa com `go_router` para uma UX moderna
- Navegação entre login e home com tudo que foi pedido nos requisitos 
---

## 🧩 Arquitetura e boas práticas

- Separação clara entre **UI** e **lógica de negócio** (`login_controller.dart`, `home_controller.dart`)
- **State management** com `ValueNotifier` e `ValueListenableBuilder`  
- **Injeção de dependências** usando `get_it` para maior testabilidade e desacoplamento
- **Rotas nomeadas** e seguras com `go_router`
- **Responsividade**: Visual responsivo conforme dispisitivo
- **Assets**: logo em SVG que adapta a cor conforme tema

---

## ✅ Funcionalidades extras

- Testes unitários usando `flutter_test` + `mockito`
- Feedback visual ao usuário: loading indicators, snackbars para erros
- Armazenamento seguro de CPF e senha no login
- Validação de formulário: CPF formatado + senha mínima de 8 caracteres
- Controle de mostrar/ocultar senha com ValueNotifier
- Drawer organizado com rotas para outras funcionalidades

---

## 🧪 Testes implementados

- `LoginController`: login bem-sucedido, CPF não encontrado, toggle do `rememberMe`
- `HomeController`: abertura de links no navegador ou rota interna, fallback em caso de erro
- Validação de formulário (CPF completo e senha)

---

## 🛠 Tecnologias & principais pacotes

- Flutter 3.x
- Firebase Auth + Firestore
- go_router
- flutter_secure_storage
- get_it
- mockito + flutter_test
- flutter_svg

---
