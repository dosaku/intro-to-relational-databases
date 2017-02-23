-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

drop table if exists Player, Match;

create table Player
    (id serial primary key,
     name text);

create table Match
    (id1 integer references Player (id),
     id2 integer references Player (id),
     winner_id serial references Player(id),
     primary key (id1, id2),
     check (id1 != id2 and
            (winner_id = id1 or winner_id = id2))
     );

-- sample data to work with during dev
insert into Player (name) values ('Ryan');
insert into Player (name) values ('Allen');
insert into Player (name) values ('Jon');
insert into Player (name) values ('Laura');
insert into Player (name) values ('Cam');
insert into Player (name) values ('Cammie');

insert into Match values (1, 2, 2);
insert into Match values (3, 4, 3);
insert into Match values (5, 6, 6);
