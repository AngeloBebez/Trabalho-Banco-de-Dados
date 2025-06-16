CREATE DATABASE ConcursoPublico;

USE ConcursoPublico;

-- Criação das tabelas

CREATE TABLE Endereco (
    ID INT PRIMARY KEY,
    Cidade VARCHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    CEP VARCHAR(8) NOT NULL,
    Rua VARCHAR(100) NOT NULL
);

CREATE TABLE Localidade (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Sigla VARCHAR(2) NOT NULL,
    CONSTRAINT uq_nome UNIQUE (Nome),
    CONSTRAINT uq_sigla UNIQUE (Sigla)
);

CREATE TABLE Concurso (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataConcurso DATE NOT NULL,
    ID_Localidade INT NOT NULL,
    CONSTRAINT fk_concurso_localidade FOREIGN KEY (ID_Localidade) REFERENCES Localidade(ID)
);

CREATE TABLE Cargo (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    ID_Concurso INT NOT NULL,
    CONSTRAINT fk_cargo_concurso FOREIGN KEY (ID_Concurso) REFERENCES Concurso(ID)
);

CREATE TABLE Situacao (
    ID INT PRIMARY KEY,
    Nome VARCHAR(30) NOT NULL
);

CREATE TABLE Candidato (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Data_Inscricao DATE NULL,
    Numero_Inscricao INT NOT NULL,
    CPF VARCHAR(11) NOT NULL,
    ID_Endereco INT NOT NULL,
    ID_Concurso INT,
    CONSTRAINT uq_numero_inscricao UNIQUE (Numero_Inscricao),
    CONSTRAINT uq_cpf UNIQUE (CPF),
    CONSTRAINT fk_candidato_endereco FOREIGN KEY (ID_Endereco) REFERENCES Endereco(ID),
    CONSTRAINT fk_candidato_concurso FOREIGN KEY (ID_Concurso) REFERENCES Concurso(ID)
);

CREATE TABLE Tipo_Prova (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Sigla CHAR(1) NOT NULL
);

CREATE TABLE Prova (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Valor INT NOT NULL,
    ID_Tipo_Prova INT,
    CONSTRAINT fk_prova_tipo FOREIGN KEY (ID_Tipo_Prova) REFERENCES Tipo_Prova(ID)
);

CREATE TABLE Etapa (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Data DATE NOT NULL,
    ID_Concurso INT,
    CONSTRAINT fk_etapa_concurso FOREIGN KEY (ID_Concurso) REFERENCES Concurso(ID)
);

CREATE TABLE Etapa_Prova (
    ID_Prova INT NOT NULL,
    ID_Etapa INT NOT NULL,
    PRIMARY KEY (ID_Prova, ID_Etapa),
    CONSTRAINT fk_etapaprova_prova FOREIGN KEY (ID_Prova) REFERENCES Prova(ID),
    CONSTRAINT fk_etapaprova_etapa FOREIGN KEY (ID_Etapa) REFERENCES Etapa(ID)
);

CREATE TABLE Candidato_Prova (
    ID_Prova INT NOT NULL,
    ID_Candidato INT NOT NULL,
    Nota DECIMAL(5,2),
    PRIMARY KEY (ID_Prova, ID_Candidato),
    CONSTRAINT fk_candidatoprova_prova FOREIGN KEY (ID_Prova) REFERENCES Prova(ID),
    CONSTRAINT fk_candidatoprova_candidato FOREIGN KEY (ID_Candidato) REFERENCES Candidato(ID)
);

CREATE TABLE Candidato_Etapa (
    ID_Candidato INT NOT NULL,
    ID_Etapa INT NOT NULL,
    Classificacao INT NOT NULL,
    Total_Pontos DECIMAL(6,2),
    ID_Situacao INT NOT NULL,
    PRIMARY KEY (ID_Candidato, ID_Etapa),
    CONSTRAINT fk_candidatoetapa_candidato FOREIGN KEY (ID_Candidato) REFERENCES Candidato(ID),
    CONSTRAINT fk_candidatoetapa_etapa FOREIGN KEY (ID_Etapa) REFERENCES Etapa(ID),
    CONSTRAINT fk_candidatoetapa_situacao FOREIGN KEY (ID_Situacao) REFERENCES Situacao(ID)
);

-- Inserts

INSERT INTO Endereco (ID, Cidade, UF, CEP, Rua) VALUES
(1, 'Rio de Janeiro', 'RJ', '20220170', 'Rua Mariano Procópio 37'),
(2, 'Belo Horizonte', 'MG', '31330210', 'Rua Castelo Moura 24'),
(3, 'Contagem', 'MG', '31330210', 'Rua Rio Volga 566');

INSERT INTO Localidade (ID, Nome, Sigla) VALUES
(1, 'Belo Horizonte', 'MG'),
(2, 'São Paulo', 'SP');

INSERT INTO Concurso (ID, Nome, DataConcurso, ID_Localidade) VALUES
(1, 'Concurso Prefeitura BH', '2025-07-01', 1),
(2, 'Concurso Prefeitura SP', '2025-08-15', 2);

INSERT INTO Cargo (ID, Nome, ID_Concurso) VALUES
(1, 'Analista de Dados', 1),
(2, 'Progamador Backend', 2);

INSERT INTO Situacao (ID, Nome) VALUES
(1, 'Aprovado'),
(2, 'Reprovado'),
(3, 'Suplente');

INSERT INTO Candidato (ID, Nome, Data_Inscricao, Numero_Inscricao, CPF, ID_Endereco, ID_Concurso) VALUES
(1, 'Victor Magnus', '2025-06-01', 23, '95436789101', 1, 1),
(2, 'Miguel Angelo', '2025-06-02', 25, '11349977300', 2, 1),
(3, 'Sofia Evelyn', '2025-06-03', 10124, '97890273245', 3, 2);

INSERT INTO Tipo_Prova (ID, Nome, Sigla) VALUES
(1, 'Objetiva', 'O'),
(2, 'Discursiva', 'D');

INSERT INTO Prova (ID, Nome, Valor, ID_Tipo_Prova) VALUES
(1, 'Informática', 100, 1),
(2, 'Progamação em Java', 100, 2);

INSERT INTO Etapa (ID, Nome, Data, ID_Concurso) VALUES
(1, 'Etapa 1', '2025-07-10', 1),
(2, 'Etapa 2', '2025-08-01', 2);

INSERT INTO Etapa_Prova (ID_Prova, ID_Etapa) VALUES
(1, 1),
(2, 2);

INSERT INTO Candidato_Prova (ID_Prova, ID_Candidato, Nota) VALUES
(1, 1, 85.50),
(1, 2, 65.70),
(2, 3, 72.00);

INSERT INTO Candidato_Etapa (ID_Candidato, ID_Etapa, Classificacao, Total_Pontos, ID_Situacao) VALUES
(1, 1, 32, 135.50, 1),
(2, 2, 57, 175.23, 1),
(3, 2, 10, 112.10, 3);