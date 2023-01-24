.mode columns
.headers on
.nullvalue NULL

    -- Resultado dos jogos de um jornada (primeira jornada neste caso)
select s1.idjogo as NUM_JOGO, casa.nome as EQUIPA_VITSITADA, s1.GOLOS as GOLOS_VISITADA, s2.GOLOS as GOLOS_VISITANTE, fora.nome as EQUIPA_VITSITANTE
from (
    select jogo.idjogo, jogo.IDCLUBEVISITADO,count(golo.idjogo) as GOLOS
    from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITADO = golo.IDCLUBE
    where jogo.jornada = 1
    group by 1,2) s1, 
    (
        select jogo.idjogo, jogo.IDCLUBEVISITANTE,count(golo.idjogo) as GOLOS
    from jogo left outer join golo on jogo.idjogo=golo.idjogo and jogo.IDCLUBEVISITANTE = golo.IDCLUBE
    where jogo.jornada = 1
    group by 1,2) s2, Clube casa, Clube fora
where s1.idjogo = s2.idjogo and casa.IDCLUBE = s1.IDCLUBEVISITADO and fora.IDCLUBE = s2.IDCLUBEVISITANTE;