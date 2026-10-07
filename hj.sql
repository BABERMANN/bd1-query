
create table convenio(
	id   int primary key,
	nome varchar(50) not null
);


create table paciente(
	id          int,
	cpf         varchar(14),
	nome        varchar(50) not null,
	sexo        char(1),
	datanasc    date,
	endereco    varchar(60),
	id_convenio int,
	
	constraint paciente_pk primary key(id),
	constraint paciente_cpf_uk unique(cpf), 
	constraint paciente_sexo_ck check(sexo in ('M','F')),
	constraint paciente_conv_fk foreign key(id_convenio) references convenio(id) -- Adicionado para integridade
);

-- 3. Criar tabela medico
create table medico(
	id            int,
	cpf           varchar(14),
	nome          varchar(50) not null,
	crm           varchar(13),
	especialidade varchar(20),
	
	constraint medico_pk primary key(id),
	constraint med_cpf_uk unique(cpf),
	constraint crm_uk unique(crm)
);


create table consulta(
	num             int generated always as identity,
	date            date not null,
	tipo            varchar(14),
	status_consulta char(1), 
	valor           real,
	id_paciente     int,
	id_medico       int,
	
	constraint consulta_pk primary key(num), 
	constraint cons_tipo_ck check(tipo in('c','p')),
	constraint cons_valor_ck check(valor > 0),
	constraint cons_pac_fk foreign key(id_paciente) references paciente(id),
	constraint cons_med_fk foreign key(id_medico) references medico(id)
);



-- Inserir convênios
insert into convenio values(1, 'unimed');
insert into convenio(nome, id) values('sao francisco', 2);
select * from convenio;

-- Inserir pacientes 
insert into paciente 
values(1, '123.112.222-32', 'eredin', 'M', '2003-12-30', 'rua dos fudidos', null);

insert into paciente(id, cpf, nome, sexo, datanasc, id_convenio) 
values(2, '123.432.423-32', 'transudo', 'F', '2004-03-23', 1);

insert into paciente(id, cpf, nome, sexo, datanasc, id_convenio) 
values(3, '124.432.434-47', 'ladino', 'M', '2004-05-14', 1);

--inserir medicos

insert into medico
values(1,'123.321.321-56','Vanessa domingd','crm/sp 4344','sexologo');

insert into medico
values(2,'123.331.321-56','caneta azul','crm/sp 43432','cariologista');


insert into consulta(date, tipo, valor, id_paciente, id_medico)
values('2026-10-06', 'p', 323.33, 1, 1);


insert into consulta(date, tipo, valor, id_paciente, id_medico)
values('2026-10-07', 'c', 150.00, 2, 2);

insert into consulta(date,tipo,valor,id_paciente,id_medico)
values('2025-10-07', 'p', 150.30, 2, 2);

insert into consulta(date,valor,id_paciente,id_medico)
values('2025-10-05',150.30, 2, 2);


-- Verificar os resultados
select * from consulta;

--atualizacao de dados
update medico set especialidade = 'fisioterapeuta'
	where id = 1;

select * from medico;

update medico set especialidade = 'Fudido'
	where nome = 'Apolo'
	or nome = 'caneta azul';


--atualizar dados de consulta

select * from consulta;

delete from consulta
	where id_paciente = 1;

update consulta set date = '2005-01-01'
	where num = 1;

update consulta set date = '2022-03-02'
	where date is null;

update consulta set tipo = 'c'
	where tipo is null;

update consulta set valor = valor*1.1
	where valor > 120;

update consulta set tipo = 'c', valor = null
	where valor >=165;


--remover o paciente chamado eredin

select * from paciente;

delete from paciente
	where nome = 'eredin';

--tranformar uma fk em modo cascade
alter table paciente drop constraint paciente_conv_fk;

alter table paciente add constraint paciente_conv_fk
	foreign key(id_convenio) references convenio(id)
	on delete cascade;


-- 2. Transformar a FK de paciente na tabela CONSULTA em CASCADE
alter table consulta drop constraint cons_pac_fk;

-- Corrigido: Removido o ';' do meio da instrução anterior
alter table consulta add constraint cons_pac_fk
	foreign key(id_paciente) references paciente(id)
	on delete cascade;

-- Verificar se o paciente e as consultas dele sumiram
select * from paciente;
select * from consulta;
