-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

drop view if exists Wins, Games, Stats;
drop table if exists Player, Match;

create table Player
    (id serial primary key,
     name text);

create table Match
    (winner_id integer references Player (id),
     loser_id integer references Player (id),
     primary key (winner_id, loser_id),
     check (winner_id != loser_id));

create view Wins as
    select id, count(winner_id) as wins
    from player left join match
    on id = winner_id
    group by id
    order by wins desc;

create view Games as
    select id, count(winner_id) as matches
    from player left join match
    on (id = winner_id or
        id = loser_id)
    group by id
    order by id;

create view Stats as
    select player.id, name, wins, matches
    from player, wins, games
    where player.id=wins.id and
          player.id=games.id
    order by wins desc, id;
