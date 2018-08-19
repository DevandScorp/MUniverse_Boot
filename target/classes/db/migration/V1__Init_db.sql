create table hibernate_sequence (next_val bigint) engine=MyISAM;
insert into hibernate_sequence values ( 1 );
insert into hibernate_sequence values ( 1 );
create table music (id integer not null, artist varchar(255), filename varchar(255), song varchar(255), user_id integer, primary key (id)) engine=MyISAM;
create table user_role (id integer not null, roles varchar(255)) engine=MyISAM;
create table users (id integer not null, activation_code varchar(255), email varchar(255), password varchar(255), username varchar(255), primary key (id)) engine=MyISAM;
alter table music add constraint FKd4k1afl8dooh2644f3ei3nv9u foreign key (user_id) references users (id);
alter table user_role add constraint FKm01t79r1jd43urtdfwr98po4q foreign key (id) references users (id);