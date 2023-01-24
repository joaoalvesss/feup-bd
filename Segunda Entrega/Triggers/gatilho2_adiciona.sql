.mode columns
.headers on
.nullvalue NULL
PRAGMA foreign_keys = ON;

    -- Caso um jogo seja eliminado, entao os golos referentes a esse jogo tambem serao eliminados
create trigger if not exists DeleteJogo
before delete on Jogo
for each row
when exists(
    select *
    from golo
    where Old.idjogo = golo.idjogo
)
begin
    delete from golo
    where old.idjogo = golo.idjogo;
end;