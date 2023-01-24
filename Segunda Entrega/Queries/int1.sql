.mode columns
.headers on
.nullvalue NULL

    -- Quantidade de marcadores diferentes de cada clube
select c.nome AS CLUBE, count(distinct j.idjogador) AS MARCADORES_DISTINTOS
from clube c
inner join jogador j on j.idclube = c.idclube
inner join golo g on g.idjogador = j.idjogador and g.idclube = c.idclube
group by 1
order by 2 desc;