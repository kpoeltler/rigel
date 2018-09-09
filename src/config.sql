create table config(app text not null, key text not null, value text, descr text, primary key(app, key));

insert into config(app, key, value) values ('csimc', 'TTY', '/dev/ttyS0');
insert into config(app, key, value) values ('csimc', 'HOST', '127.0.0.1');
insert into config(app, key, value) values ('csimc', 'PORT', '7623');
insert into config(app, key, value) values ('csimc', 'INIT0', 'basic.cmc find.cmc nodeHA.cmc lights.cmc');
insert into config(app, key, value) values ('csimc', 'INIT1', 'basic.cmc find.cmc nodeDec.cmc');

