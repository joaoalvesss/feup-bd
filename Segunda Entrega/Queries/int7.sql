.mode columns
.headers on
.nullvalue NULL

    -- Golos fora e em casa de cada equipa
select GolosCasa.nome as CLUBE, GolosCasa.g1 as Golos_CASA, GolosFora.g2 as GOLOS_FORA
from(
    select c.nome, g.idclube, count(g.idjogo) as g1
    from jogo j
    inner join golo g on j.idjogo = g.idjogo and j.idclubevisitado = g.idclube
    inner join clube c on g.idclube = c.idclube
    group by 1) as GolosCasa,
    (
    select g.idclube, count(g.idjogo) as g2
    from jogo j
    inner join golo g on j.idjogo = g.idjogo and j.idclubevisitante = g.idclube
    inner join clube c on g.idclube = c.idclube
    group by 1) GolosFora
where GolosCasa.idclube = GolosFora.idclube    
order by 2 desc, 3 desc;
