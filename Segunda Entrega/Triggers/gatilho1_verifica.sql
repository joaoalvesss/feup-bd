.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;


.print ''
.print 'Estado do jogo Gil Vicente - Pacos de Ferreita:'
.print ''
INSERT INTO JOGO (IDJOGO, JORNADA, DATA, IDESTADIO, IDCLUBEVISITANTE, IDCLUBEVISITADO) VALUES (602, 24, "2022-04-24", 5, 11, 5); -- Gil Vicente x Pacos de Ferreira


.print ''
.print 'Tentativa de insercao de um golo a benificiar o Porto (insercao invalida):'
.print ''
INSERT INTO GOLO (IDGOLO, MINUTO, IDJOGO, IDJOGADOR, IDCLUBE) VALUES (698, 67, 602, 196, 1); -- Golo do FC PORTO 

.print ''
.print 'Verificacao da nao insercao do golo do Porto:'
.print ''
SELECT * FROM GOLO WHERE GOLO.IDJOGO = 602;

.print ''
.print 'Tentativa de insercao de um golo a benificiar o Gil Vicente e Pacos de Ferreira (insercao valida):'
.print ''
INSERT INTO GOLO (IDGOLO, MINUTO, IDJOGO, IDJOGADOR, IDCLUBE) VALUES (699, 25, 602, 196, 5); -- Golo do Gil Vicente
INSERT INTO GOLO (IDGOLO, MINUTO, IDJOGO, IDJOGADOR, IDCLUBE) VALUES (700, 29, 602, 413, 11); -- Golo do Pacos de Ferreira

.print ''
.print 'Verificacao da insercao dos golos do Gil Vicente e Pacos de Ferreira:'
.print ''
SELECT * FROM GOLO WHERE GOLO.IDJOGO = 602;