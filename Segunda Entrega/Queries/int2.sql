.mode columns
.headers on
.nullvalue NULL

    -- Melhores marcadores de equipas "Nao grandes", com pelo menos 4 golos
select c.nome AS CLUBE, j.nome AS JOGADOR, count(*) as GOLOS
from jogador j
join clube c on j.idclube = c.idclube
join golo g on g.idjogador = j.idjogador and g.idclube = c.idclube
where c.idclube not in (1,2,3,4)
group by 1, 2
having GOLOS >= 4
order by 3 desc;