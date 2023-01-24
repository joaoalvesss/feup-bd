.mode columns
.headers on
.nullvalue NULL

    -- Media de golos por nacionalidade dos jogadores com altura entre 170 e 190 e Avancados, ou que preferem o pe esquerdo e marcaram na segunda parte
select golos.nacionalidade as NACIONALIDADES, round(avg(golos.nGolos),1) as MEDIA_GOLOS
from(
    select j.nacionalidade as nacionalidade, j.nome, count(*) as nGolos
    from jogador j natural join golo g
    where (j.altura between 170 and 190) and j.posicao like '%Avan%'
    group by 1, 2

    union

    select j.nacionalidade as nacionalidade, j.nome, count(*) as nGolos
    from jogador j inner join golo g on g.idjogador = j.idjogador 
    where j.pe = 'Esquerdo' and g.minuto < 45
    group by 1, 2

) as golos
group by 1
order by 2 desc;