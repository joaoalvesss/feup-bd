.mode columns
.headers on
.nullvalue NULL

    -- Golos sofridos de cada clube
select clube.IDCLUBE, clube.nome, count(a1.idgolo) as GOLOS_SOFRIDOS
from clube left outer join (
    select clube.IDCLUBE, s1.idgolo
    from clube, (
        select jogo.idjogo, jogo.IDCLUBEVISITANTE, jogo.IDCLUBEVISITADO, golo.IDGOLO
        from jogo left outer join golo on jogo.idjogo=golo.idjogo) s1
    where s1.IDCLUBEVISITADO = clube.IDCLUBE or s1.IDCLUBEVISITANTE = clube.IDCLUBE
    except 
    select clube.IDCLUBE, golo.idgolo
    from clube left outer join golo on golo.IDCLUBE = clube.IDCLUBE) a1 on a1.IDCLUBE = clube.IDCLUBE 
group by 1
order by 3 desc, 1 asc;