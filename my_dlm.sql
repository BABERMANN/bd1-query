create table convenio(
  id  int,
  nome  varchar(30) not null,
  constraint pk_convenio primary key(id),
  constraint convenio_nome_uk unique(nome)
);


create  table paciente(
  id    int,
  cpf   varchar(14) not null,
  nome    varchar(50)not null,
  sexo    char(1),
  datanasc    date,
  endereco    varchar(60),
  id_convenio   int,
  constraint pk_paciente primary key(id),
  constraint paciente_cpf_uk unique(cpf),
  constraint sexo_ck check(sexo in('M','F')),
  constraint paciente_conv_fk foreign key(id_convenio) references convenio(id)
);


create table medico(
  id    int,
  cpf varchar(14) not null,
  nome varchar(50) not null,
  crm   varchar(13),
  especialidade   varchar(20),
  constraint medico_id_pk primary key(id),
  constraint medico_cpf_uk unique(cpf),
  constraint medico_crm_uk unique(crm) 
);

create table consulta(
  numero    int generated always as identity,
  data    date not null,
  tipo    char(1) default 'C',
  valor   real,
  id_paciente   int not null,
  id_medico int not null,
  constraint consulta_numero_pk primary key(numero),
  constraint tipo_ck check(tipo in('P','C')),
  constraint valor_ck check(valor > 0),
  constraint consulta_paci_fk foreign key(id_paciente) references paciente(id),
  constraint constraint_med_fk foreign key(id_medico) references medico(id)
);

alter table consulta drop constraint tipo_ck;


select * from convenio;
select * from paciente;
select * from medico;
select * from consulta;

