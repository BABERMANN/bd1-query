-- liste o id, nome e salario dos professores que ganham mais 
-- do que a eva terranova

select id, nome, salario
	from professor
	where salario > (select salario from professor
					 where nome = 'Eva Terranova');

--listar d, nome e data de nacimento do prefessor responsavel
--pelo departamento de matematica
select id, nome, data_nascimento from professor
	where id = (select id_prof_responsavel from departamento 
	where nome = 'Departamento de Matemática');

-- Listar id, nome e salario dos professor que ganham menos ou igual
--ao menor salario do departamento 3

select id, nome, salario from professor
	where salario <= (select min(salario)from professor
						where id_departamento = 3);

--Listar o id, nome e email dos professores que sao responsaveis 
-- por algum departamento

select id, nome, email from professor
	where id in (select id_prof_responsavel from departamento);

--Listar o nome e salario dos professores que ganham mais do que
-- todos os professores do departamento 2

select nome, salario from professor
	where salario > all (select salario from professor where id_departamento = 2);

-- Listar o nome e salario dos professores que ganham mais do que 
--algum professor do departamento 2

select nome salario from professor
	where salario > any (select salario from professor where id_departamento = 2);

--Liste o id nome e-mail dos professoresque nao sao responsaveis por
-- nenhum departamento

select id, nome, email from professor
 where id not in (select id_prof_responsavel from departamento
 					where id_prof_responsavel is not null);

--subconsultas correlacionadas
-- listar os nomes dos professores que sao responsaveis por algum departamento


select nome from professor p
	where exists (select 1 from departamento d
					where d.id_prof_responsavel = p.id);


--Listar os nomes dos professores qe nao sao responsaveis por algum departamento

select nome from professor p
	where not exists (select 1 from departamento d
					where d.id_prof_responsavel = p.id);


--operador de conjunto
-- union, union all, intersect, except (minus)

--liste o id dos alunos que cursaram a turma 1 com media marioe que 7,0
-- e os que cursatam a turma 3 com media maior do que 6

select id_aluno from matriculado where id_turma = 1 and media > 7
union all 
select id_aluno from matriculado where id_turma = 3 and media > 6
order by id_aluno;

--liste os ids dos alunos que cursaram a turma 1 e a turma 3
select id_aluno from matriculado where id_turma = 1
except
select id_aluno from matriculado where id_turma = 3
order by id_aluno;


--liste o email e nome dos professores e o cpf e email dos alunos
select email, nome from professor
union
select email, nome from aluno;


--Liste o id e nome dos departamentos sob responsablidade do professor 8
--e o id, nome e data de nascimento de seus dependentes

SELECT 
    id, 
    nome, 
    NULL AS data_nascimento, 
    'Departamento' AS tipo
FROM departamento
WHERE id_prof_responsavel = 8

UNION

SELECT 
    id, 
    nome, 
    data_nascimento, 
    'Dependente' AS tipo
FROM dependente
WHERE id_professor = 8;

