insert into users (activation_code, email, password, username, id) values (null, 'artemda4@gmail.com', MD5('123'), 'admin', 1);
insert into user_role (id, roles) values (1, 'ADMIN');
update  hibernate_sequence set next_val = next_val+1;