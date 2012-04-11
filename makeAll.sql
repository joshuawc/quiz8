--create user table
drop sequence if exists user_id_seq cascade;
create sequence user_id_seq;
drop table if exists users cascade;
create table users(
  id integer not null default nextval('user_id_seq'),
  username text unique,
  password text,
  division text,
  department text,
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
               return rec.id;
            else
               return -1;
            end if;
         end if;
         
      end
   $func$
   language 'plpgsql';

--insert data
insert into users (username, password, division, department) values ('joshuawc',md5('joshuawc'),'div1','div1');
insert into users (username, password, division, department) values ('rmortal',md5('rmortal'),'div1','depA');
insert into users (username, password, division, department) values ('eisonunique',md5('eisonunique'),'div1','depB');
