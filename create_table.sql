
DROP TABLE IF EXISTS membros_tcc CASCADE;
DROP TABLE IF EXISTS grupos_tcc CASCADE;
DROP TABLE IF EXISTS historico_docente CASCADE;
DROP TABLE IF EXISTS inscricao_disciplinas CASCADE;
DROP TABLE IF EXISTS matriz_curricular CASCADE;
DROP TABLE IF EXISTS disciplinas CASCADE;
DROP TABLE IF EXISTS cursos CASCADE;
DROP TABLE IF EXISTS alunos CASCADE;
DROP TABLE IF EXISTS professores CASCADE;
DROP TABLE IF EXISTS departamentos CASCADE;




-- Tabela DEPARTAMENTOS
CREATE TABLE DEPARTAMENTOS (
    DepartamentoID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- Tabela PROFESSORES
CREATE TABLE PROFESSORES (
    ProfessorID BIGINT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    DepartamentoID INT,
    FOREIGN KEY (DepartamentoID) REFERENCES DEPARTAMENTOS(DepartamentoID)
);

ALTER TABLE DEPARTAMENTOS
ADD COLUMN CoordenadorID BIGINT,
ADD FOREIGN KEY (CoordenadorID) REFERENCES PROFESSORES(ProfessorID);

-- Tabela CURSOS
CREATE TABLE CURSOS (
    CursoID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DepartamentoID INT,
    FOREIGN KEY (DepartamentoID) REFERENCES DEPARTAMENTOS(DepartamentoID)
);

-- Tabela DISCIPLINAS
CREATE TABLE DISCIPLINAS (
    DisciplinaID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CursoID INT,
    FOREIGN KEY (CursoID) REFERENCES CURSOS(CursoID)
);

-- Tabela MATRIZ_CURRICULAR
CREATE TABLE MATRIZ_CURRICULAR (
    MatrizID INT PRIMARY KEY,
    CursoID INT,
    DisciplinaID INT,
    SemestreRecomendado INT,
    FOREIGN KEY (CursoID) REFERENCES CURSOS(CursoID),
    FOREIGN KEY (DisciplinaID) REFERENCES DISCIPLINAS(DisciplinaID)
);

-- Tabela ALUNOS
CREATE TABLE ALUNOS (
    RA INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE NOT NULL,
    Email VARCHAR(100) NOT NULL
);

-- Tabela INSCRICAO_DISCIPLINAS
CREATE TABLE INSCRICAO_DISCIPLINAS (
    InscricaoID INT PRIMARY KEY,
    RA INT,
    DisciplinaID INT,
    Ano INT,
    Semestre INT,
    NotaFinal FLOAT,
    FOREIGN KEY (RA) REFERENCES ALUNOS(RA),
    FOREIGN KEY (DisciplinaID) REFERENCES DISCIPLINAS(DisciplinaID)
);

-- Tabela HISTORICO_DOCENTE
CREATE TABLE HISTORICO_DOCENTE (
    HistoricoID INT PRIMARY KEY,
    ProfessorID BIGINT,
    DisciplinaID INT,
    Ano INT,
    Semestre INT,
    FOREIGN KEY (ProfessorID) REFERENCES PROFESSORES(ProfessorID),
    FOREIGN KEY (DisciplinaID) REFERENCES DISCIPLINAS(DisciplinaID)
);

-- Tabela GRUPOS_TCC
CREATE TABLE GRUPOS_TCC (
    GrupoTCCID INT PRIMARY KEY,
    Tema VARCHAR(100) NOT NULL,
    ProfessorOrientadorID BIGINT,
    FOREIGN KEY (ProfessorOrientadorID) REFERENCES PROFESSORES(ProfessorID)
);

-- Tabela MEMBROS_TCC
CREATE TABLE MEMBROS_TCC (
    GrupoTCCID INT,
    RA INT,
    PRIMARY KEY (GrupoTCCID, RA),
    FOREIGN KEY (GrupoTCCID) REFERENCES GRUPOS_TCC(GrupoTCCID),
    FOREIGN KEY (RA) REFERENCES ALUNOS(RA)
);
