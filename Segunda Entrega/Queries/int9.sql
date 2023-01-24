.mode columns
.headers on
.nullvalue NULL

    -- Clubes com acesso a competicoes ou despromocao na presente jornada
SELECT Classificacao.POSICAO, Classificacao.clube, COMPETICAODESPROMOCAO.nome
    FROM (select ROW_NUMBER () OVER (ORDER BY (v1.VITORIAS*3+v2.EMPATES*1) desc) as POSICAO, v1.CLUBE, v1.IDCLUBE, v1.IDCOMPETICAODESPROMOCAO
    from(
        select clube.IDCLUBE, count(v3.IDCLUBE) as VITORIAS, clube.NOME as CLUBE, clube.IDCOMPETICAODESPROMOCAO
        from clube left outer join(
            select clube.IDCLUBE
            from(
                select jogo.idjogo, jogo.IDCLUBEVISITADO,count(golo.idjogo) as GOLOS
                from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITADO = golo.IDCLUBE
                group by 1,2) s1, 
                (select jogo.idjogo, jogo.IDCLUBEVISITANTE,count(golo.idjogo) as GOLOS
                from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITANTE = golo.IDCLUBE
                group by 1,2) s2, Clube
            where s1.idjogo = s2.idjogo and ((clube.IDCLUBE = s1.IDCLUBEVISITADO and s1.GOLOS > s2.GOLOS) or (clube.IDCLUBE = s2.IDCLUBEVISITANTE and s2.GOLOS > s1.GOLOS))) v3 on v3.IDCLUBE = clube.IDCLUBE
            group by 1) v1, 
        
        (select clube.IDCLUBE, count(v3.IDCLUBE) as EMPATES
        from clube left outer join(
            select clube.IDCLUBE
            from(
                select jogo.idjogo, jogo.IDCLUBEVISITADO,count(golo.idjogo) as GOLOS
                from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITADO = golo.IDCLUBE
                group by 1,2) s1, 
                (select jogo.idjogo, jogo.IDCLUBEVISITANTE,count(golo.idjogo) as GOLOS
                from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITANTE = golo.IDCLUBE
                group by 1,2) s2, Clube
        where s1.idjogo = s2.idjogo and (clube.IDCLUBE = s1.IDCLUBEVISITADO or clube.IDCLUBE = s2.IDCLUBEVISITANTE) and s2.GOLOS = s1.GOLOS) v3 on v3.IDCLUBE = clube.IDCLUBE
        group by 1) v2
    where v1.IDCLUBE = v2.IDCLUBE
    order by (v1.VITORIAS*3+v2.EMPATES*1) desc) as Classificacao join COMPETICAODESPROMOCAO on Classificacao.IDCOMPETICAODESPROMOCAO = COMPETICAODESPROMOCAO.IDCOMPETICAODESPROMOCAO
ORDER BY 1,COMPETICAODESPROMOCAO.IDCOMPETICAODESPROMOCAO;