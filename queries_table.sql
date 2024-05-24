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


SELECT DISTINCT 
    H.RA,
    A.Nome,
    H.Semestre,
    H.Ano
FROM HISTORICO_DISCIPLINAS H
INNER JOIN DISCIPLINAS D ON H.DisciplinaID = D.DisciplinaID
INNER JOIN ALUNOS A ON H.RA = A.RA
INNER JOIN (
    SELECT 
        RA,
        Semestre,
        Ano
    FROM HISTORICO_DISCIPLINAS
    WHERE Ano = '2023' AND Semestre = '2' -- MUDAR AQUI O ANO E O SEMESTRE
    GROUP BY RA, Semestre, Ano
    HAVING MIN(NotaFinal) >= 5) Aprovados ON H.RA = Aprovados.RA AND H.Semestre = Aprovados.Semestre AND H.Ano = Aprovados.Ano
WHERE H.Ano = '2023' AND H.Semestre = '2' -- MUDAR AQUI O ANO E O SEMESTRE
ORDER BY H.RA;

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
