<h1 align="left">Rebase labs</h1>

Uma app web para listagem de exames médicos.

---

### Tech Stack

![Docker](https://img.shields.io/badge/Docker-%232496ED.svg?style=for-the-badge&logo=docker&logoColor=white)
![Ruby](https://img.shields.io/badge/Ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Javascript](https://img.shields.io/badge/Javascript-%23F7DF1E.svg?style=for-the-badge&logo=javascript&logoColor=black)
![HTML](https://img.shields.io/badge/HTML-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![CSS](https://img.shields.io/badge/CSS-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)

---

### Como rodar o projeto

Escolha um diretório no seu computador e rode:

```
$ git clone git@github.com:Ricardonovais1/rebase_labs_challenge.git
```
```
$ cd rebase_labs_challenge
```

Crie uma network para rodar o projeto:

```
$ docker create network rebase-labs
```

Crie os 4 containers do projeto, em terminais separados:

```
$ bash bin/run_server_1
```
```
$ bash bin/run_server_2
```
```
$ bash bin/run_server_3
```
```
$ bash postgres
```
Em outro terminal rode o comando abaixo para popular o banco de dados a partir do arquivo csv:

```
$ docker exec -it rebase-labs-server-1 bash
```
```
$ ruby import_from_csv.rb
```
---
---

### [Enunciado Feature 1] Importar os dados do CSV para um database SQL

A primeira versão original da API deverá ter apenas um endpoint `/tests`, que lê os dados de um arquivo CSV e renderiza no formato JSON. Você deve _modificar_ este endpoint para que, ao invés de ler do CSV, faça a leitura **diretamente de uma base de dados SQL**.

#### Script para importar os dados

Este passo de "importar" os dados do CSV para um **database SQL** (por ex. PostgreSQL), pode ser feito com um script Ruby simples ou **rake** task, como preferir.



## **SOLUÇÃO FEATURE 1:**

### Estrutura do banco de dados

![db](img/Diagrama_DB_REBASE_LABS.png)

Rotas para os endpoints do servidor 1:

   * http://localhost:4001/tests --> Endpoint com todos os testes, reponse:

```
[{
            "id": "1",
            "cpf": "048.973.170-88",
            "nome paciente": "Emilly Batista Neto",
            "email paciente": "gerald.crona@ebert-quigley.com",
            "data nascimento paciente": "2001-03-11",
            "endereço/rua paciente": "165 Rua Rafaela",
            "cidade paciente": "Ituverava",
            "estado paciente": "Alagoas",
            "nome médico": "Maria Luiza Pires",
            "crm médico": "B000BJ20J4",
            "crm médico estado": "PI",
            "email médico": "denna@wisozk.biz",
            "token resultado exame": "IQCZ17",
            "data exame": "2021-08-05",
            "tipo exame": "hemácias",
            "limites tipo exame": "45-52",
            "resultado": "97"
}]
```
   * http://localhost:4001/exams --> Endpoint com todos os exames e seus respectivos testes, response:

```
[
   {
        "token resultado exame": "IQCZ17",
        "nome paciente": "Emilly Batista Neto",
        "data exame": "2021-08-05",
        "cpf": "048.973.170-88",
        "email paciente": "gerald.crona@ebert-quigley.com",
        "data nascimento paciente": "2001-03-11",
        "endereço/rua paciente": "165 Rua Rafaela",
        "cidade paciente": "Ituverava",
        "estado paciente": "Alagoas",
        "médico responsável": {
              "nome médico": "Maria Luiza Pires",
              "crm médico": "B000BJ20J4",
              "crm médico estado": "PI",
              "email médico": "denna@wisozk.biz"
        },
        "testes deste exame": [
              {
                    "tipo exame": "hemácias",
                    "limites tipo exame": "45-52",
                    "resultado": "97"
              },
              {
                    "tipo exame": "leucócitos",
                    "limites tipo exame": "9-61",
                    "resultado": "89"
              },
              {
                    "tipo exame": "plaquetas",
                    "limites tipo exame": "11-93",
                    "resultado": "97"
              },
              {
                    "tipo exame": "hdl",
                    "limites tipo exame": "19-75",
                    "resultado": "0"
              },
              {
                    "tipo exame": "ldl",
                    "limites tipo exame": "45-54",
                    "resultado": "80"
              },
              {
                    "tipo exame": "vldl",
                    "limites tipo exame": "48-72",
                    "resultado": "82"
              },
              {
                    "tipo exame": "glicemia",
                    "limites tipo exame": "25-83",
                    "resultado": "98"
              },
              {
                    "tipo exame": "tgo",
                    "limites tipo exame": "50-84",
                    "resultado": "87"
              },
              {
                    "tipo exame": "tgp",
                    "limites tipo exame": "38-63",
                    "resultado": "9"
              },
              {
                    "tipo exame": "eletrólitos",
                    "limites tipo exame": "2-68",
                    "resultado": "85"
              },
              {
                    "tipo exame": "tsh",
                    "limites tipo exame": "25-80",
                    "resultado": "65"
              },
              {
                    "tipo exame": "t4-livre",
                    "limites tipo exame": "34-60",
                    "resultado": "94"
              },
              {
                    "tipo exame": "ácido úrico",
                    "limites tipo exame": "15-61",
                    "resultado": "2"
              }
      ]
   }
]
```

---
---

### [Enunciado Feature 2] Exibir listagem de exames no navegador Web
Agora vamos exibir as mesmas informações da etapa anterior, mas desta vez de uma forma mais amigável ao usuário. Para isto, você deve criar uma nova aplicação, que conterá todo o código necessário para a web - HTML, CSS e Javascript.

Criar um endpoint do Sinatra (A) que devolve listagem de exames em formato JSON.

Adicionar também, outro endpoint do Sinatra (B) que devolve um HTML contendo apenas instruções Javascript. Estas instruções serão responsáveis por buscar os exames no enponint (A) e exibi-los na tela de forma amigável.

O objetivo aqui, neste passo, é carregar os dados de exames da API utilizando Javascript. Como exemplo, você pode abrir em seu browser o arquivo `index.html` contido neste snippet e investigar seu funcionamento.



## **SOLUÇÃO FEATURE 2:**

Rota para acessar os exames no "frontend", configurado no servidor da aplicação 2:

   * http://localhost:4002/results --> Acessar todos os exames no cliente da aplicação.

### Layout página de exames...

   ### ...com as abas de detalhes fechadas - http://localhost:4002/results

![fechado](img/Exame_aba_fechada.png)

   ### ...com a abas de detalhes aberta:

![aberto](img/Exame_zoom.png)

---
---

### [Enunciado Feature 3] Exibir detalhes de um exame em formato HTML a partir do token do resultado
Nesta etapa vamos implementar uma nova funcionalidade: pesquisar os resultados com base em um token de exame.

Você deve criar um endpoint no Sinatra (C) que devolve, com base no token enviado no request, os detalhes de um exame em formato JSON.

Adicionalmente, também criar, no HTML da listagem de exames, uma tag HTML `<form>` que via Javascript faz request ao endpoint (C) e renderiza os detalhes do exame em HTML.

#### Criar endpoint para mostrar os detalhes de um exame médico

Você deve implementar o endpoint `/tests/:token` que permita que o usuário da API, ao fornecer o token do exame, possa ver os detalhes daquele exame no formato JSON, tal como está implementado no endpoint
`/tests`. A consulta deve ser feita na base de dados.

## **SOLUÇÃO FEATURE 3:**

   ### Página com todos os exames (puxado do banco de dados), com input de pesquisa por token - http://localhost:4003/exams

![index](img/Feature 3 Index.png)

   ### Página de detalhes do exame - http://localhost:4003/exams/:token

![aberto](img/Exame_zoom.png)


