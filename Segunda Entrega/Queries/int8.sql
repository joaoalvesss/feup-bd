.mode columns
.headers on
.nullvalue NULL

    -- Quantidade de jogos realizados em casa no intervalo de tempo apresentado em dias e carateristicas do estadio onde foram realizados os jogos
select CASA.CLUBE, julianday(CASA.MAX) - julianday(CASA.MIN) DIAS_ENTRE_JOGOS_CASA, CASA.JOGOS_CASA, CASA.LOTACAO AS LOTACAO_ESTADIO, CASA.NOME
from(
    select c.nome as CLUBE, min(j.data) AS MIN, max(J.data) AS MAX, count(*) as JOGOS_CASA, e.lotacao as LOTACAO, e.nome as NOME
    from jogo j, clube c, estadio e
    where c.idclube = j.idclubevisitado and j.idestadio = e.idestadio
    group by 1
    order by 2 desc) as CASA
order by 3 desc, 2 asc;  