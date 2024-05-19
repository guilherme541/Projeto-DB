# Projeto-DB


## Alunos

## Desc

## Diagrama relacional

```mermaid
erDiagram
    ALUNOS ||--o{ INSCRICAO-DISCIPLINAS : RA
    ALUNOS ||--o{ MEMBROS-TCC : RA
    PROFESSORES ||--o{ HISTORICO-DOCENTE : ProfessorID
    PROFESSORES ||--o{ GRUPOS-TCC : ProfessorID
    DEPARTAMENTOS ||--|| PROFESSORES : DepartamentoID
    DEPARTAMENTOS ||--o{ CURSOS : DepartamentoID
    CURSOS ||--o{ DISCIPLINAS : CursoID
    DISCIPLINAS ||--o{ MATRIZ-CURRICULAR : CursoID
    CURSOS ||--o{ MATRIZ-CURRICULAR : CursoID
    MATRIZ-CURRICULAR ||--o{ INSCRICAO-DISCIPLINAS : DisciplinaID

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

    MATRIZ-CURRICULAR {
        int MatrizID PK
        int CursoID FK
        int DisciplinaID FK
        int SemestreRecomendado
    }

    INSCRICAO-DISCIPLINAS {
        int InscricaoID PK
        int RA FK
        int DisciplinaID FK
        int Ano
        int Semestre
        float NotaFinal
    }

    HISTORICO-DOCENTE {
        int HistoricoID PK
        int ProfessorID FK
        int DisciplinaID FK
        int Ano
        int Semestre
    }

    GRUPOS-TCC {
        int GrupoTCCID PK
        string Tema
        int ProfessorOrientadorID FK
    }

    MEMBROS-TCC {
        int GrupoTCCID FK
        int RA FK
    }
```
