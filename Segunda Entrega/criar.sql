PRAGMA FOREIGN_KEYS = ON;

DROP TABLE IF EXISTS GOLO;
DROP TABLE IF EXISTS JOGADOR;
DROP TABLE IF EXISTS JOGO;
DROP TABLE IF EXISTS CLUBE;
DROP TABLE IF EXISTS COMPETICAODESPROMOCAO;
DROP TABLE IF EXISTS ESTADIO;

CREATE TABLE ESTADIO(
    IDESTADIO INT PRIMARY KEY,
    NOME TEXT NOT NULL,
    LOTACAO INT CHECK(LOTACAO >= 5000)
);

CREATE TABLE COMPETICAODESPROMOCAO(
    IDCOMPETICAODESPROMOCAO INT PRIMARY KEY,
    NOME TEXT NOT NULL,
    POSICAOMIN INT NOT NULL,
    POSICAOMAX INT NOT NULL
);

CREATE TABLE CLUBE(
    IDCLUBE INT PRIMARY KEY,
    NOME TEXT UNIQUE,
    MORADA TEXT UNIQUE,
    ANOFUNDACAO INT NOT NULL,
    IDESTADIO INT NOT NULL,
    IDCOMPETICAODESPROMOCAO INT NOT NULL,
    FOREIGN KEY (IDESTADIO) REFERENCES ESTADIO(IDESTADIO) ON UPDATE CASCADE,
    FOREIGN KEY (IDCOMPETICAODESPROMOCAO) REFERENCES COMPETICAODESPROMOCAO(IDCOMPETICAODESPROMOCAO) ON UPDATE CASCADE
);

CREATE TABLE JOGO(
    IDJOGO INT PRIMARY KEY,
    JORNADA INT NOT NULL,
    DATA DATE NOT NULL,
    IDESTADIO INT NOT NULL,
    IDCLUBEVISITANTE INT NOT NULL,
    IDCLUBEVISITADO INT NOT NULL,
    FOREIGN KEY (IDESTADIO) REFERENCES ESTADIO(IDESTADIO) ON UPDATE CASCADE,
    FOREIGN KEY (IDCLUBEVISITANTE) REFERENCES CLUBE(IDCLUBE) ON UPDATE CASCADE,
    FOREIGN KEY (IDCLUBEVISITADO) REFERENCES CLUBE(IDCLUBE) ON UPDATE CASCADE
);

CREATE TABLE JOGADOR(
    IDJOGADOR INT PRIMARY KEY,
    NOME TEXT NOT NULL,
    NACIONALIDADE TEXT NOT NULL,
    POSICAO TEXT NOT NULL,
    PE TEXT NOT NULL,
    ALTURA INT NOT NULL,
    IDCLUBE INT NOT NULL,
    FOREIGN KEY (IDCLUBE) REFERENCES CLUBE(IDCLUBE)  ON UPDATE CASCADE
);

CREATE TABLE GOLO(
    IDGOLO INT PRIMARY KEY,
    MINUTO INT NOT NULL,
    IDJOGO INT NOT NULL,
    IDJOGADOR INT NOT NULL,
    IDCLUBE INT NOT NULL,
    FOREIGN KEY (IDJOGO) REFERENCES JOGO(IDJOGO) ON UPDATE CASCADE, 
    FOREIGN KEY (IDJOGADOR) REFERENCES JOGADOR(IDJOGADOR) ON UPDATE CASCADE, 
    FOREIGN KEY (IDCLUBE) REFERENCES CLUBE(IDCLUBE) ON UPDATE CASCADE
);

PRAGMA FOREIGN_KEYS = ON;