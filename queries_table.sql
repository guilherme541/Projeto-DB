SELECT 
    i.RA,
    i.DisciplinaID,
    d.Nome AS NomeDisciplina,
    i.Semestre,
    i.Ano,
    i.NotaFinal
FROM INSCRICAO_DISCIPLINAS i
INNER JOIN DISCIPLINAS d ON i.DisciplinaID = d.DisciplinaID
WHERE i.RA = '960419885'; -- DIGITE UM RA QUE ESTEJA NA TABELA DADOS ALEATORIOS



SELECT 
    h.ProfessorID,
    h.DisciplinaID,
    d.Nome AS NomeDisciplina,
    h.Semestre,
    h.Ano
FROM HISTORICO_DOCENTE h
INNER JOIN DISCIPLINAS d ON h.DisciplinaID = d.DisciplinaID
WHERE h.ProfessorID = 'DIGITE UM ID DO PROFESSOR QUE ESTEJA NA TABELA DADOS ALEATORIOS';



SELECT 
    a.RA,
    a.Nome,
    a.Email
FROM 
    ALUNOS a
WHERE 
    NOT EXISTS (
        SELECT 
            1
        FROM  MATRIZ_CURRICULAR mc
        LEFT JOIN INSCRICAO_DISCIPLINAS id ON mc.DisciplinaID = id.DisciplinaID AND id.RA = a.RA
        WHERE id.NotaFinal < 5.0 OR id.RA IS NULL
    )
    AND EXISTS (
        SELECT 1 FROM INSCRICAO_DISCIPLINAS id
        WHERE id.RA = a.RA AND id.Ano = ' DIGITE UM ANO QUE ESTEJA NA TABELA DADOS ALEATORIOS'AND id.Semestre = 'DIGITE UM SEMESTRE QUE ESTEJA NA TABELA DADOS ALEATORIOS'
    );


SELECT 
    p.ProfessorID,
    p.Nome AS NomeProfessor,
    d.Nome AS NomeDepartamento
FROM PROFESSORES p
INNER JOIN DEPARTAMENTOS d ON p.ProfessorID = d.CoordenadorID;



SELECT 
    gt.GrupoTCCID,
    gt.Tema,
    gt.ProfessorOrientadorID,
    p.Nome AS NomeOrientador,
    mt.RA,
    a.Nome AS NomeAluno
FROM GRUPOS_TCC gt
INNER JOIN PROFESSORES p ON gt.ProfessorOrientadorID = p.ProfessorID
INNER JOIN MEMBROS_TCC mt ON gt.GrupoTCCID = mt.GrupoTCCID
INNER JOIN ALUNOS a ON mt.RA = a.RA;
