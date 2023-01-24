.mode columns
.headers on
.nullvalue NULL

    -- Tabela classificativa, com posicao atual na liga, numero de vitorias, empates e derrotas, e quantidade de pontos acumulados
select ROW_NUMBER () OVER (ORDER BY (v1.VITORIAS*3+v2.EMPATES*1) desc) POSICAO,v1.NOME as CLUBE, v1.VITORIAS, v2.empates, v3.DERROTAS, (v1.VITORIAS*3+v2.EMPATES*1) as PONTOS
from(
    select clube.IDCLUBE, count(v3.IDCLUBE) as VITORIAS, clube.NOME
    from clube left outer join(
        select clube.IDCLUBE
        from (
            select jogo.idjogo, jogo.IDCLUBEVISITADO,count(golo.idjogo) as GOLOS
            from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITADO = golo.IDCLUBE
            group by 1,2) s1, 
            (select jogo.idjogo, jogo.IDCLUBEVISITANTE,count(golo.idjogo) as GOLOS
            from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITANTE = golo.IDCLUBE
            group by 1,2) s2, Clube
        where s1.idjogo = s2.idjogo and ((clube.IDCLUBE = s1.IDCLUBEVISITADO and s1.GOLOS > s2.GOLOS) or (clube.IDCLUBE = s2.IDCLUBEVISITANTE and s2.GOLOS > s1.GOLOS))) v3 on v3.IDCLUBE = clube.IDCLUBE
        group by 1) v1, 
        
    (select clube.IDCLUBE, count(v3.IDCLUBE) as EMPATES
    from clube left outer join (
        select clube.IDCLUBE
        from (
            select jogo.idjogo, jogo.IDCLUBEVISITADO,count(golo.idjogo) as GOLOS
            from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITADO = golo.IDCLUBE
            group by 1,2) s1, 
            (select jogo.idjogo, jogo.IDCLUBEVISITANTE,count(golo.idjogo) as GOLOS
            from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITANTE = golo.IDCLUBE
            group by 1,2) s2, Clube
    where s1.idjogo = s2.idjogo and (clube.IDCLUBE = s1.IDCLUBEVISITADO or clube.IDCLUBE = s2.IDCLUBEVISITANTE) and s2.GOLOS = s1.GOLOS) v3 on v3.IDCLUBE = clube.IDCLUBE
    group by 1) v2,

    (select clube.IDCLUBE, count(v3.IDCLUBE) as DERROTAS
    from clube left outer join (
        select clube.IDCLUBE
        from (
            select jogo.idjogo, jogo.IDCLUBEVISITADO,count(golo.idjogo) as GOLOS
            from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITADO = golo.IDCLUBE
            group by 1,2) s1, 
            (select jogo.idjogo, jogo.IDCLUBEVISITANTE,count(golo.idjogo) as GOLOS
            from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITANTE = golo.IDCLUBE
            group by 1,2) s2, Clube
    where s1.idjogo = s2.idjogo and ((clube.IDCLUBE = s1.IDCLUBEVISITADO and s1.GOLOS < s2.GOLOS) or (clube.IDCLUBE = s2.IDCLUBEVISITANTE and s2.GOLOS < s1.GOLOS))) v3 on v3.IDCLUBE = clube.IDCLUBE
    group by 1) v3
where v1.IDCLUBE = v2.IDCLUBE and v2.IDCLUBE = v3.IDCLUBE
order by 6 desc, 3 desc; 