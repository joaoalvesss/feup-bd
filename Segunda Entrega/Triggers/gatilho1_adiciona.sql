.mode columns
.headers on
.nullvalue NULL
PRAGMA foreign_keys = ON;

    -- Antes de inserir um Golo, verificar se ele pertence a um dos intervenientes do jogo; se nao for, nao insere o golo
create trigger if not exists InsertGoloEquipa
before insert on Golo
for each row
when not exists(
    select jogo.idjogo
    from jogo
    where jogo.idjogo = New.idjogo and (New.IDCLUBE = jogo.IDCLUBEVISITADO or New.IDCLUBE = jogo.IDCLUBEVISITANTE)
)
begin
    select raise(abort, 'Equipa nao participante no jogo!');
end;
