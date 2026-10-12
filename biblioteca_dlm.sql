--create database biblioteca;

create table categoria(
  id    smallint,
  nome    varchar(30) not null,
  constraint categoria_id_pk primary key(id),
  constraint categoria_nome_uk unique(nome) 
);

create table livro(
  id  smallint,
  titulo    varchar(80) not null,
  isbn    varchar(17),
  ano_publicado   smallint,
  preco   numeric(8,2),
  id_categoria    smallint,
  constraint livro_id_pk primary key(id),
  constraint livro_isbn_uk unique(isbn),
  constraint livro_ano_publicado_ck check(ano_publicado > 1500 and ano_publicado < 2026),
  constraint livro_preco_ck check(preco > 0),
  constraint livro_id_categoria_fk foreign key(id_categoria) references categoria(id)
);

create table autor(
  id    smallint,
  nome  varchar(50) not null,
  data_nasc   date,
  constraint autor_id_pk primary key(id)
);

create table livro_autor(
  id_livro    smallint,
  id_autor    smallint,
  constraint livro_autor_id_livro_fk foreign key(id_livro) references livro(id),
  constraint livro_autor_id_autor_fk foreign key(id_autor) references autor(id),
  constraint livro_autor_id_livro_id_autor_pk primary key(id_livro,id_autor)
);

alter table livro add editora varchar(40);
alter table autor add nacionalidade varchar(20) default 'Brasileira';
alter table livro alter column titulo type varchar(120); --chato
alter table livro rename column editora to "nome_editora"; --ASPAS DUPLAS HORRIVEL
alter table autor alter column nome drop not null;
alter table autor alter column nome set not null;
alter table livro drop constraint livro_preco_ck;
alter table livro add constraint ck_preco_positivo check(preco > 0); --add


insert into categoria values(1,'ciencia');
insert into categoria values(2,'romance');
insert into categoria values(3,'terror');
insert into categoria values(4,'ficcao');
insert into categoria values(5,'dark fantasy');

insert into livro values(1,'a doutrina social da igreja','12345678910111','2000',20.20,1,'ciencias sociais');
insert into livro values(2,'capitalismo liquido','12345628910111','2001',20.21,1,'ciencias sociais');
insert into livro values(3,'adoravel trapaceiro','1234562410111','2002',20.22,2,'romances do viver');
insert into livro values(4,'2001 uma odisseia no espaco','13453284310111','2016',22.21);
insert into livro values(5,'call of chutullu','12335623915111','1967',20.21);
--insert into livro values(1,'a doutrina social da','12345678910132','2000',-20.20,1,'ciencias sociais');
--insert into livro values(1,'a doutrina soca','12345678910111','2000',22.20,1,'ciencias sociais');

insert into autor values(1,'Eredin','2002-12-21');
insert into autor values(2,'Eredi','2012-12-21');
insert into autor values(3,'Ered','2022-12-22');
insert into autor values(4,'Eredin','2011-11-21');

insert into livro_autor values(1,1);
--insert into livro_autor values(1,1);
insert into livro_autor values(2,1);
insert into livro_autor values(3,2);
insert into livro_autor values(4,3);

update livro set id_categoria = 4
  where id = 5;

update livro set preco = preco * 1.10
  where ano_publicado < 2000;

update categoria set nome = 'ficcao cientifica'
  where id = 4;

delete from categoria
  where id = 3;

--nao vai dar pra eliminar a categoria 1 pq tem livros relacionados a ela pelo id


alter table livro drop constraint livro_id_categoria_fk;
alter table livro add constraint livro_id_categoria_fk
foreign key (id_categoria) references categoria(id)
on delete cascade;

alter table livro_autor drop constraint livro_autor_id_livro_fk;
alter table livro_autor add constraint livro_autor_id_livro_fk
foreign key (id_livro) references livro(id)
on delete cascade;

delete from categoria
  where id = 1;



select * from categoria;
select * from livro;
select * from autor;
select * from livro_autor;
