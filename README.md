# Sistema de Galpões e Estoque

## Tabela de Conteúdos
  * [Descrição do projeto](#descrição-do-projeto)
  * [Funcionalidades](#funcionalidades)
  * [Como rodar a aplicação](#como-rodar-a-aplicação)
  * [Como rodar os testes](#como-rodar-os-testes)
  * [Informações adicionais](#informações-adicionais)

## Descrição do projeto

<p align = "justify"> Aplicação para Sistema de Galpões e Estoque desenvolvida como parte da 1a etapa da turma 9 do Treinadev. </p>

## Funcionalidades

- [X] Autenticação necessária em todas as telas.
- [X] Telas de listagem, cadastro e detalhes de galpões.
- [X] Telas de listagem, cadastro, detalhes e edição de fornecedores.
- [X] Telas de listagem, cadastro e detalhes de modelos de produtos.
- [X] Criação de pedido com galpão, fornecedor, data de entrega, usuário responsável (adicionado automaticamente) e código de rastreio (gerado automaticamente).
- [X] Busca por pedidos a partir do código de rastreio.

## Como rodar a aplicação

<p align = "justify"> No terminal, clone o projeto: </p>

```
$ git clone git@github.com:RaphaellyV/warehouse-app-td9.git
```

<p align = "justify"> Entre na pasta do projeto: </p>

```
$ cd warehouse-app-td9
```

<p align = "justify"> Instale as dependencias: </p>

```
$ bin/setup
```

<p align = "justify"> Popule a aplicação: </p>

```
$ rails db:seed
```

<p align = "justify"> Visualize no navegador: </p>

```
$ rails s
```

* Acesse http://localhost:3000/

## Como rodar os testes

```
$ rspec
```

## Informações adicionais

* Usuário criado: pessoa@email.com (senha: password)

* Gems instaladas: capybara, devise, rspec, bootstrap
