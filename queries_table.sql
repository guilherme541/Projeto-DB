SELECT 
    i.RA,
    i.DisciplinaID,
    d.Nome AS NomeDisciplina,
    i.Semestre,
    i.Ano,
    i.NotaFinal
FROM 
    INSCRICAO_DISCIPLINAS i
JOIN 
    DISCIPLINAS d ON i.DisciplinaID = d.DisciplinaID
WHERE 
    i.RA = '960419885';



SELECT 
    h.ProfessorID,
    h.DisciplinaID,
    d.Nome AS NomeDisciplina,
    h.Semestre,
    h.Ano
FROM 
    HISTORICO_DOCENTE h
JOIN 
    DISCIPLINAS d ON h.DisciplinaID = d.DisciplinaID
WHERE 
    h.ProfessorID = 'inserir_ProfessorID_aqui';



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
        FROM 
            MATRIZ_CURRICULAR mc
        LEFT JOIN 
            INSCRICAO_DISCIPLINAS id ON mc.DisciplinaID = id.DisciplinaID AND id.RA = a.RA
        WHERE 
            id.NotaFinal < 5.0
            OR id.RA IS NULL
    )
    AND EXISTS (
        SELECT 
            1
        FROM 
            INSCRICAO_DISCIPLINAS id
        WHERE 
            id.RA = a.RA
            AND id.Ano = 'inserir_ano_aqui'
            AND id.Semestre = 'inserir_semestre_aqui'
    );


SELECT 
    p.ProfessorID,
    p.Nome AS NomeProfessor,
    d.Nome AS NomeDepartamento
FROM 
    PROFESSORES p
JOIN 
    DEPARTAMENTOS d ON p.ProfessorID = d.CoordenadorID;



SELECT 
    gt.GrupoTCCID,
    gt.Tema,
    gt.ProfessorOrientadorID,
    p.Nome AS NomeOrientador,
    mt.RA,
    a.Nome AS NomeAluno
FROM 
    GRUPOS_TCC gt
JOIN 
    PROFESSORES p ON gt.ProfessorOrientadorID = p.ProfessorID
JOIN 
    MEMBROS_TCC mt ON gt.GrupoTCCID = mt.GrupoTCCID
JOIN 
    ALUNOS a ON mt.RA = a.RA;