.mode columns
.headers on
.nullvalue NULL

    -- Jogos em que ambas marcam e a diferenca de golos foi entre 3 a 7, estadio e data de quando e onde ocorreram
select q1.jornada as JORNADA, q1.nome1 as EQUIPA_CASA, q1.c1 as GOLOS_CASA, q2.c2 as GOLOS_FORA, q2.nome2 as EQUIPA_FORA, q1.nomEstadio as ESTADIO, q1.dataJogo as DATA
from(
    select j1.idjogo, c1.nome as nome1, count(*) as c1, j1.jornada, e1.nome as nomEstadio, j1.data as dataJogo
    from golo g1
    left join jogo j1 on g1.idjogo = j1.idjogo 
    inner join clube c1 on g1.idclube = c1.idclube and c1.idclube = j1.idclubevisitado 
    inner join estadio e1 on c1.idestadio = e1.idestadio
    group by 1, 2) as q1,
    (
    select j2.idjogo, c2.nome as nome2, count(*) as c2, j2.jornada
    from golo g2
    left join jogo j2 on g2.idjogo = j2.idjogo
    inner join clube c2 on g2.idclube = c2.idclube  and c2.idclube = j2.idclubevisitante
    group by 1, 2) as q2
where q1.idjogo = q2.idjogo and abs(GOLOS_CASA - GOLOS_FORA) between 3 and 7
order by abs(GOLOS_CASA - GOLOS_FORA) desc, 3 desc;