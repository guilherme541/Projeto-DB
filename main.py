from faker import Faker
import psycopg2
import random

cursos = ['Ciência da Computação', 'Engenharia Elétrica', 'Engenharia Mecânica', 'Engenharia de Produção', 'Administração']
departamentos = ['Ciência da Computação', 'Matemática', 'Física', 'Engenharia Elétrica', 'Engenharia de Produção']
disciplinas = [
    'Algoritmos e Estruturas de Dados', 'Cálculo I', 'Cálculo II', 'Cálculo III',
    'Álgebra Linear', 'Física I', 'Física II', 'Física III', 'Química Geral',
    'Química Orgânica', 'Programação I', 'Programação II', 'Programação III',
    'Banco de Dados', 'Redes de Computadores', 'Sistemas Operacionais',
    'Engenharia de Software', 'Inteligência Artificial', 'Computação Gráfica',
    'Sistemas Distribuídos', 'Segurança da Informação', 'Empreendedorismo',
    'Gestão de Projetos', 'Tópicos Especiais em Computação', 'Ética e Cidadania',
    'Metodologia Científica', 'Trabalho de Conclusão de Curso'
]

fake = Faker("pt_BR")

# Conexão com o banco de dados PostgreSQL MUDAR A CONEXÃO
conn = psycopg2.connect(
    host="",
    user="",
    password="",
    dbname=""
)
cursor = conn.cursor()


def gerar_ra():
    return random.randint(100000000, 999999999)


def gerar_professor_id():
    return random.randint(10000000000, 99999999999)


def insert_departamentos():
    for i, departamento in enumerate(departamentos):
        cursor.execute("INSERT INTO DEPARTAMENTOS (DepartamentoID, Nome) VALUES (%s, %s)", (i + 1, departamento))
    conn.commit()

def insert_professores(n):
    cursor.execute("SELECT DepartamentoID FROM DEPARTAMENTOS")
    departamentos = cursor.fetchall()
    for i in range(n):
        departamento_id = random.choice(departamentos)[0]
        professor_id = gerar_professor_id()
        cursor.execute(
            "INSERT INTO PROFESSORES (ProfessorID, Nome, Email, DepartamentoID) VALUES (%s, %s, %s, %s)",
            (professor_id, fake.name(), fake.email(), departamento_id)
        )
    conn.commit()


def insert_cursos():
    cursor.execute("SELECT DepartamentoID FROM DEPARTAMENTOS")
    departamentos = cursor.fetchall()
    for i, curso in enumerate(cursos):
        departamento_id = random.choice(departamentos)[0]
        cursor.execute(
            "INSERT INTO CURSOS (CursoID, Nome, DepartamentoID) VALUES (%s, %s, %s)",
            (i + 1, curso, departamento_id)
        )
    conn.commit()


def insert_alunos(n):
    for i in range(n):
        ra = gerar_ra()
        cursor.execute(
            "INSERT INTO ALUNOS (RA, Nome, DataNascimento, Email) VALUES (%s, %s, %s, %s)",
            (ra, fake.name(), fake.date_of_birth(minimum_age=18, maximum_age=30), fake.email())
        )
    conn.commit()


def insert_disciplinas():
    cursor.execute("SELECT CursoID FROM CURSOS")
    cursos = cursor.fetchall()
    for i, disciplina in enumerate(disciplinas):
        curso_id = random.choice(cursos)[0]
        cursor.execute(
            "INSERT INTO DISCIPLINAS (DisciplinaID, Nome, CursoID) VALUES (%s, %s, %s)",
            (i + 1, disciplina, curso_id)
        )
    conn.commit()


def insert_matriz_curricular():
    cursor.execute("SELECT CursoID FROM CURSOS")
    cursos = cursor.fetchall()
    cursor.execute("SELECT DisciplinaID FROM DISCIPLINAS")
    disciplinas = cursor.fetchall()
    for i in range(len(disciplinas)):
        curso_id = random.choice(cursos)[0]
        disciplina_id = disciplinas[i][0]
        cursor.execute(
            "INSERT INTO MATRIZ_CURRICULAR (MatrizID, CursoID, DisciplinaID, SemestreRecomendado) VALUES (%s, %s, %s, %s)",
            (i + 1, curso_id, disciplina_id, random.randint(1, 8))
        )
    conn.commit()


def insert_historico_disciplinas():
    cursor.execute("SELECT RA FROM ALUNOS")
    alunos = cursor.fetchall()
    cursor.execute("SELECT DisciplinaID FROM DISCIPLINAS")
    disciplinas = cursor.fetchall()
    inscricao_id = 1
    for ano in range(2010, 2024):
        for aluno in alunos[:10]:
            ra = aluno[0]
            disciplinas_aluno = random.sample(disciplinas, 5)
            semestre = random.randint(1, 2)
            for disciplina in disciplinas_aluno[:4]:
                disciplina_id = disciplina[0]
                nota = round(random.uniform(5, 10) if random.random() > 0.3 else random.uniform(0, 4.9), 2)
                cursor.execute(
                    "INSERT INTO HISTORICO_DISCIPLINAS (InscricaoID, RA, DisciplinaID, Ano, Semestre, NotaFinal) VALUES (%s, %s, %s, %s, %s, %s)",
                    (inscricao_id, ra, disciplina_id, ano, semestre, nota)
                )
                inscricao_id += 1

            disciplina_id = disciplinas_aluno[4][0]
            nota = round(random.uniform(0, 10), 2)
            cursor.execute(
                "INSERT INTO HISTORICO_DISCIPLINAS (InscricaoID, RA, DisciplinaID, Ano, Semestre, NotaFinal) VALUES (%s, %s, %s, %s, %s, %s)",
                (inscricao_id, ra, disciplina_id, random.randint(2010, 2023), random.randint(1, 2), nota)
            )
            inscricao_id += 1

    conn.commit()


def insert_historico_docente(n):
    cursor.execute("SELECT ProfessorID FROM PROFESSORES")
    professores = cursor.fetchall()
    cursor.execute("SELECT DisciplinaID FROM DISCIPLINAS")
    disciplinas = cursor.fetchall()
    for i in range(n):
        professor_id = random.choice(professores)[0]
        disciplina_id = random.choice(disciplinas)[0]
        cursor.execute(
            "INSERT INTO HISTORICO_DOCENTE (HistoricoID, ProfessorID, DisciplinaID, Ano, Semestre) VALUES (%s, %s, %s, %s, %s)",
            (i + 1, professor_id, disciplina_id, random.randint(2010, 2023), random.randint(1, 2))
        )
    conn.commit()

# Inserir dados na tabela GRUPOS_TCC
def insert_grupos_tcc(n):
    cursor.execute("SELECT ProfessorID FROM PROFESSORES")
    professores = cursor.fetchall()
    for i in range(n):
        professor_orientador_id = random.choice(professores)[0]
        cursor.execute(
            "INSERT INTO GRUPOS_TCC (GrupoTCCID, Tema, ProfessorOrientadorID) VALUES (%s, %s, %s)",
            (i + 1, fake.bs(), professor_orientador_id)
        )
    conn.commit()


def insert_membros_tcc():
    cursor.execute("SELECT GrupoTCCID FROM GRUPOS_TCC")
    grupos_tcc = cursor.fetchall()
    cursor.execute("SELECT RA FROM ALUNOS")
    alunos = cursor.fetchall()
    for grupo_tcc_id in grupos_tcc:
        num_membros = random.randint(2, 4)
        membros = random.sample(alunos, num_membros)
        for membro in membros:
            cursor.execute(
                "INSERT INTO MEMBROS_TCC (GrupoTCCID, RA) VALUES (%s, %s)",
                (grupo_tcc_id[0], membro[0])
            )
    conn.commit()


def definir_coordenadores():
    cursor.execute("SELECT DepartamentoID FROM DEPARTAMENTOS")
    departamentos = cursor.fetchall()
    cursor.execute("SELECT ProfessorID FROM PROFESSORES")
    professores = cursor.fetchall()
    for departamento_id in departamentos:
        coordenador_id = random.choice(professores)[0]
        cursor.execute(
            "UPDATE DEPARTAMENTOS SET CoordenadorID = %s WHERE DepartamentoID = %s",
            (coordenador_id, departamento_id[0])
        )
    conn.commit()


insert_departamentos()
insert_professores(10)
insert_cursos()
insert_alunos(50)
insert_disciplinas()
insert_matriz_curricular()
insert_historico_disciplinas()
insert_historico_docente(50)
insert_grupos_tcc(10)
insert_membros_tcc()
definir_coordenadores()

cursor.close()
conn.close()
print("[!] Ready...")
