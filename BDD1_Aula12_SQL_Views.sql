--Crie uma visão chamada V_PROF_SALANUAL que liste o nome, o e-mail
--e o salário anual (salário x 12) dos professores. Consulte a visão criada


create view v_prof_salaAnul(prof_nome,prof_email,sal_anual) as
	select nome, email,	salario * 12 
	from professor;

select * from v_prof_salaAnul;


--Crie uma visão chamada V_ALUNO_IDADE que liste o nome, a data de
--nascimento e a idade dos alunos. A idade deve ser calculada em função
--da data de nascimento. Consulte a visão criada.

create view v_aluno_idade(nome, data_nasc, idade,ra) as
	select nome, data_nascimento, extract(year from age(current_date,data_nascimento)),ra
	from aluno;

drop view v_aluno_idade;
select * from aluno;
select * from v_aluno_idade;


--Modifique a visão V_ALUNO_IDADE, incluindo o RA do aluno como
--sendo a última coluna da view. Consulte novamente a visão.


-------------------------------------------------------------------------------
--Crie uma visão chamada V_DISCIPLINA_COMP que liste id, sigla, nome
--e id_departamento das disciplinas que pertencem ao Departamento 1
--(Computação). Ative a restrição que verifica o domínio da view em
--operações DML feitas por meio dela. Consulte a visão criada.

create view v_disciplina_comp(id,sigla,nome,id_departamento) as
	select id,sigla, nome,id_departamento
	from disciplina
	where id_departamento = 1
	with check option;	


select * from disciplina;
select * from v_disciplina_comp;


--Insira, por meio da view V_DISCIPLINA_COMP, uma nova disciplina com
--os seguintes valores:
--id: 21, sigla: 'PRW1’, nome: 'Programação para Web I’, id_departamento: 1

insert into v_disciplina_comp id,21,'p'











