-- create database loja;


create table cliente(
  id             smallint,
  nome           varchar(60) not null,
  email          varchar(80),
  data_cadastro  date,
  constraint cliente_id_pk primary key(id),
  constraint cliente_email_uk unique(email)
);

create table produto(
  id         smallint,
  descricao  varchar(80) not null,
  preco      numeric(8,2),
  estoque    integer,
  constraint produto_id_pk primary key(id),
  constraint produto_preco_ck check(preco > 0),
  constraint produto_estoque_ck check(estoque >= 0)
);

create table pedido(
  id            smallint,
  data_pedido   date not null,
  data_entrega  date,
  id_cliente    smallint,
  constraint pedido_id_pk primary key(id),
  constraint pedido_data_entrega_ck check(data_entrega >= data_pedido),
  constraint pedido_id_cliente_fk foreign key(id_cliente) references cliente(id)
);

create table item_pedido(
  id_pedido   smallint,
  id_produto  smallint,
  quantidade  smallint,
  constraint item_pedido_pk primary key(id_pedido, id_produto),
  constraint item_pedido_id_pedido_fk foreign key(id_pedido) references pedido(id),
  constraint item_pedido_id_produto_fk foreign key(id_produto) references produto(id),
  constraint item_pedido_quantidade_ck check(quantidade > 0)
);


alter table cliente add telefone varchar(15);
alter table pedido add status varchar(15) default 'Aberto';
alter table produto alter column descricao type varchar(120);
alter table cliente rename column telefone to contato;
alter table pedido alter column status drop default;
alter table pedido alter column status set default 'Aberto';
alter table cliente drop constraint cliente_email_uk;
alter table cliente add constraint ck_email_unico unique(email);
alter table produto drop constraint produto_estoque_ck;
alter table produto add constraint produto_estoque_ck check(estoque >= 0);

insert into cliente values(1,'eredin','sim@gmail.com','2005-03-03',null);
insert into cliente values(2,'joao','nao@gmail.com','2005-03-03',null);
insert into cliente values(3,'pablo','talvez@gmail.com','2003-04-12',null);
insert into cliente values(4,'luana','certeza@gmail.com','2000-01-21',null);

insert into produto values(1,'sim',200.00,30);
insert into produto values(2,'nao',200.00,20);
insert into produto values(3,'talvez',500.00,10);
insert into produto values(4,'nao sei',700.00,20);
insert into produto values(5,'provavelmente',800.00,12);


insert into pedido (id, data_pedido, data_entrega, id_cliente) values(1,'2026-09-01','2026-09-05',1);
insert into pedido (id, data_pedido, data_entrega, id_cliente) values(2,'2026-09-03','2026-09-08',1);
insert into pedido (id, data_pedido, data_entrega, id_cliente) values(3,'2026-09-10','2026-09-15',2);
insert into pedido (id, data_pedido, data_entrega, id_cliente) values(4,'2026-09-12','2026-09-20',3);
insert into pedido (id, data_pedido, data_entrega, id_cliente) values(5,'2026-09-14','2026-09-22',null);
insert into pedido (id, data_pedido, data_entrega, id_cliente) values(6,'2026-09-15','2026-09-25',null);


insert into item_pedido values(1,1,2);
insert into item_pedido values(1,2,1);
insert into item_pedido values(1,3,5);
insert into item_pedido values(2,1,1);
insert into item_pedido values(3,4,2);
insert into item_pedido values(4,5,1);
insert into item_pedido values(4,2,3);


select * from cliente;
select * from produto;
select * from pedido;
select * from item_pedido;

update pedido set id_cliente = 4 where id = 6;


update produto set preco = 40.00 where id = 1;
update produto set preco = preco * 1.15 where preco < 50;

update pedido set status = 'Entregue' where id_cliente = 1;

delete from pedido where id = 5;

alter table pedido drop constraint pedido_id_cliente_fk;
alter table pedido add constraint pedido_id_cliente_fk
  foreign key(id_cliente) references cliente(id)
  on delete cascade;

alter table item_pedido drop constraint item_pedido_id_pedido_fk;
alter table item_pedido add constraint item_pedido_id_pedido_fk
  foreign key(id_pedido) references pedido(id)
  on delete cascade;
  
delete from cliente where id = 1;

alter table pedido drop constraint pedido_id_cliente_fk;
alter table pedido add constraint pedido_id_cliente_fk
  foreign key(id_cliente) references cliente(id)
  on delete set null;

delete from cliente where id = 2;
alter table item_pedido drop constraint item_pedido_id_pedido_fk;

select * from pedido;
select * from produto;
