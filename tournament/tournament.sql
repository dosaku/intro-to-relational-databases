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
    order by wins desc;

-- sample data to work with during dev
insert into Player (name) values ('Ryan');
insert into Player (name) values ('Allen');
insert into Player (name) values ('Jon');
insert into Player (name) values ('Laura');
insert into Player (name) values ('Cam');
insert into Player (name) values ('Cammie');

insert into Match values (2, 1);
insert into Match values (2, 3);
insert into Match values (2, 4);
insert into Match values (2, 5);
insert into Match values (2, 6);

insert into Match values (1, 3);
insert into Match values (1, 4);
insert into Match values (1, 5);
insert into Match values (1, 6);

insert into Match values (6, 3);
insert into Match values (6, 4);
insert into Match values (6, 5);

insert into Match values (3, 4);
insert into Match values (3, 5);

insert into Match values (4, 5);
