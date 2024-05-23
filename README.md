# Projeto-DB


## Alunos
    Guilherme Couto Gomes 22.122.035-3
    Lucas Dias Batista 22.122.035-3
## Descricao 
    Projeto do curso de banco de dados do centro universitario FEI
    Banco de Dados SGPD PostGree SQL
    Codigo para alimentar as tabelas utilizando a bibliotecar Faker em Python


## Diagrama relacional

```mermaid
erDiagram
    ALUNOS ||--o{ INSCRICAO_DISCIPLINAS : RA
    ALUNOS ||--o{ MEMBROS_TCC : RA
    PROFESSORES ||--o{ HISTORICO_DOCENTE : ProfessorID
    PROFESSORES ||--o{ GRUPOS_TCC : ProfessorID
    DEPARTAMENTOS ||--|| PROFESSORES : DepartamentoID
    DEPARTAMENTOS ||--o{ CURSOS : DepartamentoID
    CURSOS ||--o{ DISCIPLINAS : CursoID
    DISCIPLINAS ||--o{ MATRIZ_CURRICULAR : CursoID
    CURSOS ||--o{ MATRIZ_CURRICULAR : CursoID
    MATRIZ_CURRICULAR ||--o{ INSCRICAO_DISCIPLINAS : DisciplinaID

    ALUNOS {
        int RA PK
        string Nome
        date DataNascimento
        string Email
    }

    PROFESSORES {
        int ProfessorID PK
        string Nome
        string Email
        int DepartamentoID FK
    }

    DEPARTAMENTOS {
        int DepartamentoID PK
        string Nome
        int ChefeID FK
    }

    CURSOS {
        int CursoID PK
        string Nome
        int DepartamentoID FK
    }

    DISCIPLINAS {
        int DisciplinaID PK
        string Nome
        int CursoID FK
    }

    MATRIZ_CURRICULAR {
        int MatrizID PK
        int CursoID FK
        int DisciplinaID FK
        int SemestreRecomendado
    }

    INSCRICAO_DISCIPLINAS {
        int InscricaoID PK
        int RA FK
        int DisciplinaID FK
        int Ano
        int Semestre
        float NotaFinal
    }

    HISTORICO_DOCENTE {
        int HistoricoID PK
        int ProfessorID FK
        int DisciplinaID FK
        int Ano
        int Semestre
    }

    GRUPOS_TCC {
        int GrupoTCCID PK
        string Tema
        int ProfessorOrientadorID FK
    }

    MEMBROS_TCC {
        int GrupoTCCID FK
        int RA FK
    }
```
