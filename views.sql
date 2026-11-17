--Views
--view com id, ra, nome e id do curso dos alunos que cursam ciencia da omputacao

create or replace view v_aluno_computacao(id_aluno, ra_aluno, nome, curso) as 
	select id, ra, nome, id_curso from aluno
	where id_curso = 1;

drop view v_aluno_computacao;

select * from v_aluno_computacao;


create or replace view v_aluno_computacao as
	select id as id_aluno, ra as ra_aluno, nome, id_curso as curso 
	from aluno
	where id_curso = 1;

-- Criar uma view com ID e nome dos cursos, bem como id e nome dos departamentos
--que pertecem, ordenados por id do curso
--as colunas na view devem ser chamadas id_curso, nome_curso, id_depto e nome_depto

create view v_curso_depto(id_curo,nome_curso,id_depto,nom_depto) as
	select c.id, c.nome, d.id, d.nome
		from curso c inner join departamento d
		on c.id_departamento = d.id
		order by c.id;

--crie a view v_depto_info com o nome dos departamentos, a quantidade de professores
--que trabalham neles e a some salarial desses professores. chame as colunas na view
--de nome_depto, qtde_profs e soma_sal_profs, respectivamente

create view v_depto_info(nome_depto, qtde_profs, soma_sal_profs) as
	select d.nome, count(*), sum(p.salario), round(avg(p.salario),2)
	from departamento d, professor p
	where p.id_departamento = d.id
	group by d.nome;

select * from v_depto_info;
