-- SQL - DQL
select * from funcionario;

select cpf, nome, datanasc, genero, estadocivil, 
	email, carteiratrab, cargahoraria, salario, chavePix
		from funcionario;
        
select cpf, nome, datanasc, genero, estadocivil, 
	chavePix, carteiratrab, cargahoraria, email, salario
		from funcionario;
        
select cpf, nome, datanasc, genero, estadocivil, 
	chavePix, carteiratrab, cargahoraria, email, salario
		from funcionario
			order by nome;    
        
select cpf, nome, datanasc, genero, estadocivil, 
	chavePix, carteiratrab, cargahoraria, email, salario
		from funcionario
			order by salario desc;         

select cpf "CPF", upper(nome) as "Funcionário", 
	date_format(datanasc, "%d/%m/%Y") "Data de Nascimento", 
    genero "Gênero", upper(estadocivil) "Estado Civil",	
    chavePix "PIX", carteiratrab "Carteira de Trabalho", 
    concat(cargahoraria, "h") "Carga Horária", email "E-mail", 
    concat("R$ ", format(salario, 2, 'de_DE')) "Salário"
		from funcionario
			order by nome;

select * from dependente;

select cpf "CPF do Dependente", 
	nome "Dependente", 
    dataNasc "Data de Nascimento",
	parentesco "Parentesco", 
    funcionario_cpf "CPF do Responsável"
		from dependente
			order by nome;

select cpf "CPF do Dependente", 
	ucase(nome) "Dependente", 
    date_format(dataNasc, '%d/%m/%Y') "Data de Nascimento",
    timestampdiff(year, dataNasc, now()) "Idade",
	upper(parentesco) "Parentesco", 
    funcionario_cpf "CPF do Responsável"
		from dependente
			order by nome;

-- where nome like "%Le_o" --> traz, Fulano Leão, ou Fuluna Leao
select cpf "CPF do Dependente", 
	ucase(nome) "Dependente", 
    date_format(dataNasc, '%d/%m/%Y') "Data de Nascimento",
    timestampdiff(year, dataNasc, now()) "Idade",
	upper(parentesco) "Parentesco", 
    funcionario_cpf "CPF do Responsável"
		from dependente
			where nome like "%Le_o"
				order by nome;            
            
select cpf "CPF do Dependente", 
	ucase(nome) "Dependente", 
    date_format(dataNasc, '%d/%m/%Y') "Data de Nascimento",
    timestampdiff(year, dataNasc, now()) "Idade",
	upper(parentesco) "Parentesco", 
    funcionario_cpf "CPF do Responsável"
		from dependente
			where parentesco like "Filh%" and
				timestampdiff(year, dataNasc, now()) <= 6
				order by nome;            
            
-- https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html#function_date-format
-- https://dev.mysql.com/doc/refman/8.4/en/string-functions.html#function_format
select dep.cpf "CPF do Dependente", 
	ucase(dep.nome) "Dependente", 
    date_format(dep.dataNasc, '%d/%m/%Y') "Data de Nascimento",
    timestampdiff(year, dep.dataNasc, now()) "Idade",
	upper(dep.parentesco) "Parentesco", 
    func.cpf "CPF do Responsável",
    func.nome "Funcionário"
		from dependente dep, funcionario func
			where dep.parentesco like "Filh%" and
				timestampdiff(year, dep.dataNasc, now()) <= 6 and
                dep.funcionario_cpf = func.cpf
				order by dep.nome; 

select dep.cpf "CPF do Dependente", 
	ucase(dep.nome) "Dependente", 
    date_format(dep.dataNasc, '%d/%m/%Y') "Data de Nascimento",
    timestampdiff(year, dep.dataNasc, now()) "Idade",
	upper(dep.parentesco) "Parentesco", 
    func.cpf "CPF do Responsável",
    func.nome "Funcionário"
		from dependente dep
			inner join funcionario func on dep.funcionario_cpf = func.cpf
				where dep.parentesco like "Filh%" and
					timestampdiff(year, dep.dataNasc, now()) <= 6                
						order by dep.nome;
                
-- CPF, Nome, Idade, Genero, Estado Civil, Salario, Cidade, Telefones, Email
select upper(func.nome) "Funcionário", func.CPF "CPF",
	timestampdiff(year, func.dataNasc, now()) "Idade",
    func.genero "Gênero", func.estadoCivil "Estado Civil",
    format(func.salario, 2, 'de_DE') "Salário (R$)",
    ende.cidade "Cidade",
    tel.numero "Telefone",
    func.email "E-mail"
	from funcionario func
		inner join endereco ende on ende.funcionario_CPF = func.cpf
        left join telefone tel on tel.funcionario_cpf = func.cpf
			order by func.nome;

-- https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html#function_group-concat
select upper(f.nome) "Funcionário", f.CPF "CPF",
	timestampdiff(year, f.dataNasc, now()) "Idade",
    f.genero "Gênero", f.estadoCivil "Estado Civil",
    format(f.salario, 2, 'de_DE') "Salário (R$)",
    e.cidade "Cidade",
    group_concat(distinct t.numero separator ', ') "Telefones",
    f.email "E-mail"
	from funcionario f
		inner join endereco e on e.funcionario_CPF = f.cpf
        inner join telefone t on t.funcionario_cpf = f.cpf
			group by f.cpf
				order by f.nome;

-- cpf, nome, data, gravidade, descricao
select f.nome, f.cpf, oi.datahora, oi.gravidade, oi.descricao
	from ocorrenciaInterna oi
		inner join funcionario f on f.cpf = oi.funcionario_cpf
			order by oi.gravidade, f.nome;

-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
select f.nome "Funcionário", f.cpf "CPF do Funcionário", 
	date_format(oi.datahora, '%h:%i - %d/%m/%Y') "Momento da Ocorrência", 
    upper(oi.gravidade) "Gravidade da Ocorrência", 
    oi.descricao "Descrição"
	from ocorrenciaInterna oi
		inner join funcionario f on f.cpf = oi.funcionario_cpf
			order by oi.dataHora desc, f.nome;
            
select f.nome "Funcionário", f.cpf "CPF do Funcionário", 
	date_format(oi.datahora, '%h:%i - %d/%m/%Y') "Momento da Ocorrência", 
    upper(oi.gravidade) "Gravidade da Ocorrência", 
    oi.descricao "Descrição"
	from ocorrenciaInterna oi
		inner join funcionario f on f.cpf = oi.funcionario_cpf
			order by oi.gravidade, oi.dataHora;

select f.nome "Funcionário", f.cpf "CPF do Funcionário", 
	date_format(oi.datahora, '%h:%i - %d/%m/%Y') "Momento da Ocorrência", 
    upper(oi.gravidade) "Gravidade da Ocorrência", 
    oi.descricao "Descrição"
	from ocorrenciaInterna oi
		inner join funcionario f on f.cpf = oi.funcionario_cpf
			where oi.gravidade like "Alta"
union
select f.nome "Funcionário", f.cpf "CPF do Funcionário", 
	date_format(oi.datahora, '%h:%i - %d/%m/%Y') "Momento da Ocorrência", 
    upper(oi.gravidade) "Gravidade da Ocorrência", 
    oi.descricao "Descrição"
	from ocorrenciaInterna oi
		inner join funcionario f on f.cpf = oi.funcionario_cpf
			where oi.gravidade like "Média"
union
select f.nome "Funcionário", f.cpf "CPF do Funcionário", 
	date_format(oi.datahora, '%h:%i - %d/%m/%Y') "Momento da Ocorrência", 
    upper(oi.gravidade) "Gravidade da Ocorrência", 
    oi.descricao "Descrição"
	from ocorrenciaInterna oi
		inner join funcionario f on f.cpf = oi.funcionario_cpf
			where oi.gravidade like "Baixa";

-- root teste test aluno
-- data, tipo, justificativa, cpf, nome
select date_format(rp.datahora, '%d/%m/%Y - %H:%i') "Data e Hora", 
	upper(rp.tipoes) "ENTRADA / SAÍDA", 
    coalesce(rp.justificativa,  '--') "Justificativa", 
    f.CPF "CPF do Funcionário", f.nome "Funcionário"
	from registroponto rp
		inner join funcionario f on rp.Funcionario_CPF = f.cpf
			order by f.nome, rp.dataHora desc;

-- anoRef, nomeFunc, datainicio, dataFim, qtdDias, valor, status
select fer.anoRef "Ano Referência", func.nome "Funcionário", 
	date_format(fer.dataInicio, '%d/%m/%Y') "Data de Início",
    date_format(date_add(fer.dataInicio, interval fer.qtdDias day),
    '%d/%m/%Y') "Data Fim",
    fer.qtdDias "Quantidade de Dias", 
    concat('R$ ', format(fer.valor, 2, 'de_DE')) "Pagamento",
    upper(fer.`status`) "Situação"
	from ferias fer
		inner join funcionario func on func.cpf = fer.funcionario_cpf
			order by fer.anoRef desc, fer.dataInicio desc;












