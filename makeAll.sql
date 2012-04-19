--create user table
drop sequence if exists user_id_seq cascade;
create sequence user_id_seq;
drop table if exists users cascade;
create table users(
  id integer not null default nextval('user_id_seq'),
  username text unique,
  password text,
  access_level integer,
  primary key(id)
);

--login function
drop language if exists 'plpgsql' cascade;
create language 'plpgsql';
create or replace function getID(_user text, _pass text)
   returns integer as
   $func$
      declare
         rec record;
      begin
         select into rec * from users where username=_user;
         if not found then
            return -1;
         else
            if md5(_pass) = rec.password then
               return rec.access_level;
            else
               return -1;
            end if;
         end if;
         
      end
   $func$
   language 'plpgsql';

--insert data
insert into users (username, password, access_level) values ('joshuawc',md5('joshuawc'), 1);
insert into users (username, password, access_level) values ('rmortal',md5('rmortal'), 2);
insert into users (username, password, access_level) values ('eisonunique',md5('eisonunique'), 3);
