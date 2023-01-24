.mode columns
.header on
.nullvalue NULL
PRAGMA foreign_keys = ON;

INSERT INTO JOGO (IDJOGO, JORNADA, DATA, IDESTADIO, IDCLUBEVISITANTE, IDCLUBEVISITADO) VALUES (650, 24, "2022-04-24", 5, 11, 5); --Gil Vicente x Pacos de Ferreira

INSERT INTO GOLO (IDGOLO, MINUTO, IDJOGO, IDJOGADOR, IDCLUBE) VALUES (707, 67, 650, 196, 5); -- Golo do Gil Vicente
INSERT INTO GOLO (IDGOLO, MINUTO, IDJOGO, IDJOGADOR, IDCLUBE) VALUES (708, 4, 650, 196, 5); -- Golo do Gil Vicente
INSERT INTO GOLO (IDGOLO, MINUTO, IDJOGO, IDJOGADOR, IDCLUBE) VALUES (709, 25, 650, 196, 5); -- Golo do Gil Vicente
INSERT INTO GOLO (IDGOLO, MINUTO, IDJOGO, IDJOGADOR, IDCLUBE) VALUES (710, 80, 650, 402, 11); -- Golo do Pacos de Ferreira

.print ''
.print 'Estado do jogo Gil Vicente - Pacos de Ferreita (3x1):'
.print ''

SELECT * FROM JOGO WHERE JOGO.IDJOGO = 650;

.print ''
.print ''

SELECT * FROM GOLO WHERE GOLO.IDJOGO = 650;

.print ''
.print 'Delete do Jogo'
.print ''

DELETE FROM JOGO WHERE JOGO.IDJOGO = 650;

.print ''
.print 'Verificacao do funcionamento do trigger, se nao aparecer nada quer dizer que funcionou!'
.print ''

SELECT * FROM JOGO WHERE JOGO.IDJOGO = 650;

.print ''
.print ''

SELECT * FROM GOLO WHERE GOLO.IDJOGO = 650;