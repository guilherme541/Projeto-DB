SELECT 
    H.RA,
    H.DisciplinaID,
    D.Nome AS NomeDisciplina,
    H.Semestre,
    H.Ano,
    H.NotaFinal
FROM HISTORICO_DISCIPLINAS H
INNER JOIN DISCIPLINAS d ON H.DisciplinaID = D.DisciplinaID
WHERE H.RA = '960419885'; -- DIGITE UM RA QUE ESTEJA NA TABELA DADOS ALEATORIOS


SELECT 
    H.ProfessorID,
    H.DisciplinaID,
    D.Nome AS NomeDisciplina,
    H.Semestre,
    H.Ano
FROM HISTORICO_DOCENTE H
INNER JOIN DISCIPLINAS D ON H.DisciplinaID = D.DisciplinaID
WHERE H.ProfessorID = 'DIGITE UM ID DO PROFESSOR QUE ESTEJA NA TABELA DADOS ALEATORIOS';


SELECT 
    A.RA,
    A.Nome,
    A.Email
FROM ALUNOS A
WHERE NOT EXISTS (
        SELECT 
            1
        FROM  MATRIZ_CURRICULAR M
        LEFT JOIN INSCRICAO_DISCIPLINAS id ON M.DisciplinaID = id.DisciplinaID AND id.RA = A.RA
        WHERE id.NotaFinal < 5.0 OR id.RA IS NULL
    )
    AND EXISTS (
        SELECT 1 FROM HISTORICO_DISCIPLINAS H
        WHERE H.RA = A.RA AND H.Ano = ' DIGITE UM ANO QUE ESTEJA NA TABELA DADOS ALEATORIOS'AND H.Semestre = 'DIGITE UM SEMESTRE QUE ESTEJA NA TABELA DADOS ALEATORIOS'
    );


SELECT 
    P.ProfessorID,
    P.Nome AS NomeProfessor,
    D.Nome AS NomeDepartamento
FROM PROFESSORES P
INNER JOIN DEPARTAMENTOS D ON P.ProfessorID = D.CoordenadorID;


SELECT 
    G.GrupoTCCID,
    G.Tema,
    G.ProfessorOrientadorID,
    P.Nome AS NomeOrientador,
    M.RA,
    A.Nome AS NomeAluno
FROM GRUPOS_TCC G
INNER JOIN PROFESSORES P ON G.ProfessorOrientadorID = P.ProfessorID
INNER JOIN MEMBROS_TCC M ON G.GrupoTCCID = M.GrupoTCCID
INNER JOIN ALUNOS A ON M.RA = A.RA;
