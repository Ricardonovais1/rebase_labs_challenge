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
Em outro terminal rode o comando abaixo para popular o banco de dados com o arquivo csv:

```
$ docker exec -it rebase-labs-server-1 bash
```
```
$ ruby import_from_csv.rb
```
---

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

Rota para acessar os exames no "frontend", configurado no servidor da aplicação 2:

   * http://localhost:4004/results --> Acessar todos os exames no cliente da aplicação.
---

## Banco de dados

A estrutura do banco de dados possui a seguinte estrutura:

![db](img/Diagrama_DB_REBASE_LABS.png)

---
### Preview página de exames

Layout página de exames:

   * Exame com a abas de detalhes aberta:

![aberto](img/Exame_zoom.png)

   * Exames com as abas de detalhes fechadas:

![fechado](img/Exame_aba_fechada.png)

---

