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

-- Relatório dos Funcionários
-- Nome do Funcionário; CPF; Carteira de Trabalho; E-mail;
-- Telefonestelefone (8199998888 | 81 98787878787); Gênero;
-- Estado Civil (Letras Maiscula); Idade; Carga Horária (40h) Salário (R$ 3.000,70)
-- Apenas os funcionario de Recife -- Ordenado pelo Genero e Nome do Funcionario
select func.nome "Funcionário", func.cpf "CPF", 
	func.carteiraTrab "Carteira de Trabalho", func.email "Email",
    group_concat(distinct tel.numero separator ' | ') "Telefones",
    func.genero "Gênero", upper(func.estadoCivil) "Estado Civil",
    timestampdiff(year, func.dataNasc, now()) "Idade", 
    concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário"
	from funcionario func
		inner join telefone tel on tel.funcionario_cpf = func.cpf
        inner join endereco ende on ende.funcionario_cpf = func.cpf
			where ende.cidade = "Recife"
				group by func.cpf
					order by func.genero, func.nome;

select func.nome "Funcionário", func.cpf "CPF",
	concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    count(dep.cpf) "Quantidade Dependentes"
		from funcionario func
        left join dependente dep on dep.funcionario_cpf = func.cpf
			group by func.cpf
				order by func.nome;

select func.nome "Funcionário", func.cpf "CPF",
	concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    count(dep.cpf) "Quantidade Dependentes"
		from funcionario func
        inner join dependente dep on dep.funcionario_cpf = func.cpf
			group by func.cpf
				order by func.nome;

select func.nome "Funcionário", func.cpf "CPF",
	concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    count(fer.idFerias) "Quantidade de Vezes Tirou Férias?",
    sum(fer.qtdDias) "Total de Dias já Gozados",
    sum(fer.qtdDias) / count(fer.idFerias) "Média de Dias por Férias"
		from funcionario func
		inner join ferias fer on fer.funcionario_cpf = func.cpf
			group by func.cpf
				order by func.nome;

select `status` "Situação" , count(idFerias) "Quantidade"
	from ferias
		group by `status`;

select gravidade "Gravidade", count(idOcorrenciaInterna) "Quantidade"
	from OcorrenciaInterna
		group by gravidade
			order by count(idOcorrenciaInterna) desc;

select func.nome "Funcionário", func.cpf "CPF",
	concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    count(oi.idocorrenciaInterna) "Quantidade de Ocorrências Internas"
		from funcionario func
			left join OcorrenciaInterna oi on oi.funcionario_cpf = func.cpf
				where oi.gravidade = "Alta"
					group by func.cpf
						order by func.nome;

select func.nome "Funcionário", func.cpf "CPF",
	concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    crg.nome "Cargo"
		from funcionario func
        inner join trabalhar trb on trb.funcionario_cpf = func.cpf
        inner join cargo crg on trb.cargo_cbo = crg.cbo
			where trb.dataFim is null
				order by func.nome;

select func.nome "Funcionário", func.cpf "CPF",
	concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    crg.nome "Cargo", dep.nome "Departamento"
		from funcionario func
        inner join trabalhar trb on trb.funcionario_cpf = func.cpf
        inner join cargo crg on trb.cargo_cbo = crg.cbo
        inner join departamento dep on trb.Departamento_idDepartamento = dep.idDepartamento
			where trb.dataFim is null
				order by func.nome;
                
update funcionario
	set salario = 5000, fg = 1000
		where cpf like "108.801.888-11";


-- nome upper, cpf, cargahorario, salario, cargo, departamento, gerente 
select upper(func.nome) "Funcionário",
	replace(replace(func.cpf, ".", ""), "-", "") "CPF",
    concat(func.cargaHoraria, "h") "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    crg.nome "Cargo",
    dep.nome "Departamento",
    grt.nome "Gerente"
	from funcionario func
		inner join trabalhar trb on trb.Funcionario_CPF = func.CPF
        inner join cargo crg on crg.CBO = trb.Cargo_CBO
        inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
        left join funcionario grt on grt.cpf = dep.Gerente_CPF
			where trb.dataFim is null
				order by func.nome;
    
select upper(func.nome) "Funcionário",
	replace(replace(func.cpf, ".", ""), "-", "") "CPF",
    concat(func.cargaHoraria, "h") "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    crg.nome "Cargo",
    dep.nome "Departamento",
    grt.nome "Gerente"
	from funcionario func
		inner join trabalhar trb on trb.Funcionario_CPF = func.CPF
        inner join cargo crg on crg.CBO = trb.Cargo_CBO
        inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
        left join funcionario grt on grt.cpf = dep.Gerente_CPF
			where trb.dataFim is null and
				func.salario >= avg(func.salario)
				order by func.nome;

select avg(salario) from funcionario;

select upper(func.nome) "Funcionário",
	replace(replace(func.cpf, ".", ""), "-", "") "CPF",
    concat(func.cargaHoraria, "h") "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    crg.nome "Cargo",
    dep.nome "Departamento",
    grt.nome "Gerente"
	from funcionario func
		inner join trabalhar trb on trb.Funcionario_CPF = func.CPF
        inner join cargo crg on crg.CBO = trb.Cargo_CBO
        inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
        left join funcionario grt on grt.cpf = dep.Gerente_CPF
			where trb.dataFim is null and
				func.salario >= (select avg(salario) from funcionario)
				order by func.nome;

-- aux creche 180 para cada filho com menos de 7
select func.nome "Funcionário", 
	replace(replace(func.cpf, ".", ""), "-", "") "CPF",
	concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    count(dpt.CPF) "Auxílio Creche",
    crg.nome "Cargo", dep.nome "Departamento"
		from funcionario func
        inner join trabalhar trb on trb.funcionario_cpf = func.cpf
        inner join cargo crg on trb.cargo_cbo = crg.cbo
        inner join departamento dep on trb.Departamento_idDepartamento = dep.idDepartamento
        left join dependente dpt on dpt.Funcionario_CPF = func.cpf
			where trb.dataFim is null
				group by func.CPF
					order by func.nome;

-- Resolvendo com View
select func.cpf "cpf", count(dep.CPF) "qtdFilho"
	from funcionario func
		left join dependente dep on dep.Funcionario_CPF = func.cpf
			where timestampdiff(year, dep.dataNasc, now()) <= 6 
				group by func.cpf;

create view depAuxCreche as
	select func.cpf "cpf", count(dep.CPF) "qtdFilho"
		from funcionario func
		left join dependente dep on dep.Funcionario_CPF = func.cpf
			where timestampdiff(year, dep.dataNasc, now()) <= 6 
				group by func.cpf;

select * from depauxcreche;

select func.nome "Funcionário", 
	replace(replace(func.cpf, ".", ""), "-", "") "CPF",
	concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    concat("R$ ", format(coalesce(dac.qtdFilho, 0) * 180, 2, 'de_DE')) "Auxílio Creche",
    crg.nome "Cargo", dep.nome "Departamento"
		from funcionario func
        inner join trabalhar trb on trb.funcionario_cpf = func.cpf
        inner join cargo crg on trb.cargo_cbo = crg.cbo
        inner join departamento dep on trb.Departamento_idDepartamento = dep.idDepartamento
        left join depauxcreche dac on dac.cpf = func.cpf
			where trb.dataFim is null
				order by func.nome;

create view RelatorioRHPag as
	select func.nome "Funcionário", 
	replace(replace(func.cpf, ".", ""), "-", "") "CPF",
	concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    concat("R$ ", format(coalesce(dac.qtdFilho, 0) * 180, 2, 'de_DE')) "Auxílio Creche",
    crg.nome "Cargo", dep.nome "Departamento"
		from funcionario func
        inner join trabalhar trb on trb.funcionario_cpf = func.cpf
        inner join cargo crg on trb.cargo_cbo = crg.cbo
        inner join departamento dep on trb.Departamento_idDepartamento = dep.idDepartamento
        left join depauxcreche dac on dac.cpf = func.cpf
			where trb.dataFim is null
				order by func.nome;
                
select * from relatoriorhpag;

select cpf "CPF", upper(nome) as "Funcionário", 
	date_format(datanasc, "%d/%m/%Y") "Data de Nascimento", 
    genero "Gênero", upper(estadocivil) "Estado Civil",	
    chavePix "PIX", carteiratrab "Carteira de Trabalho", 
    concat(cargahoraria, "h") "Carga Horária", email "E-mail", 
    concat("R$ ", format(salario, 2, 'de_DE')) "Salário"
		from funcionario
			where salario <= (select avg(salario) from funcionario)
				order by nome;
                
select dep.nome "Departamento", 
	concat("R$ ", format(sum(func.salario), 2, 'de_DE')) "Custo Salarial"
	from departamento dep
		left join trabalhar trb on trb.Departamento_idDepartamento = dep.idDepartamento
        inner join funcionario func on func.CPF = trb.Funcionario_CPF
			group by dep.idDepartamento
				order by sum(func.salario) desc;

select dep.nome "Departamento", 
	concat("R$ ", format(sum(func.salario), 2, 'de_DE')) "Custo Salarial",
    count(func.cpf) "Quantidade de Fucionário",
    concat("R$ ", format(avg(func.salario), 2, 'de_DE')) "Média Salarial"
	from departamento dep
		left join trabalhar trb on trb.Departamento_idDepartamento = dep.idDepartamento
        inner join funcionario func on func.CPF = trb.Funcionario_CPF
			group by dep.idDepartamento
				order by sum(func.salario) desc;

select func.cpf from funcionario func
	inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
	inner join cargo crg on crg.CBO = trb.Cargo_CBO
    where crg.nome like "Segurança%" or crg.nome like "Auxiliar%";

update funcionario, 
	(select func.cpf from funcionario func
	inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
	inner join cargo crg on crg.CBO = trb.Cargo_CBO
    where crg.nome like "Segurança%" or crg.nome like "Auxiliar%") as crgFunc
	set cargaHoraria = 36
		where funcionario.cpf = crgFunc.cpf;

-- 180 (<25), 280(25>=  and <35), 380 (35>=  and <45), 480 (45>=  and <55) depois 600
select func.nome "Funcionário", 
	replace(replace(func.cpf, '.', ''), '-', '') "CPF",
    concat(func.cargaHoraria, 'h') "Carga Horária",
    crg.nome "Cargo",  
    case func.cargahoraria when 40 then concat("R$ ", 22*20)
		when 36 then concat("R$ ", 22*32) end "Vale Alimentação",
	case when timestampdiff(year, func.dataNasc, now()) < 25 then concat("R$ ", 180)  
		when timestampdiff(year, func.dataNasc, now()) between 25 and 35 then concat("R$ ", 280) 
		when timestampdiff(year, func.dataNasc, now()) between 35 and 45 then concat("R$ ", 380)
        when timestampdiff(year, func.dataNasc, now()) between 45 and 55 then concat("R$ ", 480)
        else concat("R$ ", 600)
		end "Auxílio Saúde",
	concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário"
	from funcionario func	
		inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
		inner join cargo crg on crg.CBO = trb.Cargo_CBO
			order by func.nome;

select func.nome "Funcionário", 
	replace(replace(func.cpf, '.', ''), '-', '') "CPF",
	date_format(fer.dataInicio, '%d/%m/%Y') "DataInicio",
    date_format(adddate(fer.dataInicio, interval fer.qtdDias day), '%d/%m/%Y') "DataFim",
    fer.qtdDias "Quantidade de Dias",
    fer.anoRef "Ano Referência"    
    from funcionario func
	inner join ferias fer on fer.Funcionario_CPF = func.cpf
		where substr(fer.dataInicio, 6, 2) like "06" or
			substr(fer.dataInicio, 6, 2) like "07"
			order by fer.dataInicio;

select dep.nome "Departamento", 
	concat("R$ ", format(sum(func.salario), 2, 'de_DE')) "Custo Salarial",
    count(func.cpf) "Quantidade de Fucionário",
    concat("R$ ", format(avg(func.salario), 2, 'de_DE')) "Média Salarial"
	from departamento dep
		left join trabalhar trb on trb.Departamento_idDepartamento = dep.idDepartamento
        inner join funcionario func on func.CPF = trb.Funcionario_CPF
			group by dep.idDepartamento
				having sum(func.salario) >= 10000
					order by sum(func.salario) desc;

-- PL SQL Function
-- Calcular o Vale Alimentação
DELIMITER $$
create function valeAlimentacao(ch int)
	returns decimal(6,2) deterministic
    begin
		if ch >= 40 
			then return 22*20;
        else 
			return 22*32;
        end if;
    end $$
DELIMITER ;

delimiter $$
create function valeSaude(dn date)
	returns decimal(6,2) deterministic
    begin
		declare idade int;
		select timestampdiff(year, dn, now()) into idade;
        if(idade <= 25) 
			then return 180;
		elseif(idade between 25 and 35)
			then return 280;
		elseif(idade between 35 and 45)
			then return 380;
		elseif(idade between 45 and 55)
			then return 480;
		else 
			return 600;
        end if;
    end $$
delimiter ;

delimiter $$
create function auxCreche(cpfFunc varchar(14))
	returns decimal(6,2) deterministic
    begin
		declare qtdFilhos int;
        select count(cpf) into qtdFilhos
			from dependente 
				where Funcionario_CPF = cpfFunc
					and timestampdiff(year, dataNasc, now()) < 7
					group by Funcionario_CPF;
		if qtdFilhos is null then set qtdFilhos = 0;
			end if;
		return qtdFilhos * 180;
    end $$
delimiter ;

delimiter $$
create function calcINSS(salario decimal(7,2))
	returns decimal(6,2) deterministic
    begin
		if(salario <= 1518) 
			then return salario * 0.075;
		elseif(salario between 1518 and 2793.88)
			then return salario * 0.09;
		elseif(salario between 2793.88 and 4190.83)
			then return salario * 0.12;
		elseif(salario between 4190.83 and 8157.41)
			then return salario * 0.14;
		else return 8157.41 * 0.14;
        end if;
    end $$
delimiter ;

delimiter $$
create function calcIRRF(salario decimal(7,2))
	returns decimal(6,2) deterministic
    begin
		if(salario <= 2259.20) 
			then return 0;
		elseif(salario between 2259.20 and 2826.65)
			then return salario * 0.075;
		elseif(salario between 2826.65 and 3751.05)
			then return salario * 0.15;
		elseif(salario between 3751.05 and 4664.68)
			then return salario * 0.225;
		else return salario * 0.275;
        end if;
	end $$
delimiter ;

select func.nome "Funcionário", 
	replace(replace(func.cpf, '.', ''), '-', '') "CPF",
    concat(func.cargaHoraria, 'h') "Carga Horária",
    crg.nome "Cargo",  
    concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
    concat("R$ ", format(valeAlimentacao(func.cargaHoraria), 2, 'de_DE')) "Vale Alimentação",
	concat("R$ ", format(valeSaude(func.dataNasc), 2, 'de_DE')) "Auxílio Saúde",
    concat("R$ ", format(auxCreche(func.cpf), 2, 'de_DE')) "Auxílio Creche",
    concat("- R$ ", format(calcINSS(func.salario) , 2, 'de_DE')) "INSS",
    concat("- R$ ", format(calcIRRF(func.salario) , 2, 'de_DE')) "IRRF",
	concat("R$ ", format(func.salario + valeAlimentacao(func.cargaHoraria) 
		+ valeSaude(func.dataNasc) + auxCreche(func.cpf) 
        - calcINSS(func.salario) - calcIRRF(func.salario) , 2, 'de_DE')) "Salário Líquido"
	from funcionario func
		inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
		inner join cargo crg on crg.CBO = trb.Cargo_CBO
			where trb.dataFim is null
				order by func.nome;

create view vRelPagSalaria as
	select func.nome "Funcionário", 
		replace(replace(func.cpf, '.', ''), '-', '') "CPF",
		concat(func.cargaHoraria, 'h') "Carga Horária",
		crg.nome "Cargo",  
		concat("R$ ", format(func.salario, 2, 'de_DE')) "Salário",
		concat("R$ ", format(valeAlimentacao(func.cargaHoraria), 2, 'de_DE')) "Vale Alimentação",
		concat("R$ ", format(valeSaude(func.dataNasc), 2, 'de_DE')) "Auxílio Saúde",
		concat("R$ ", format(auxCreche(func.cpf), 2, 'de_DE')) "Auxílio Creche",
		concat("- R$ ", format(calcINSS(func.salario) , 2, 'de_DE')) "INSS",
		concat("- R$ ", format(calcIRRF(func.salario) , 2, 'de_DE')) "IRRF",
		concat("R$ ", format(func.salario + valeAlimentacao(func.cargaHoraria) 
			+ valeSaude(func.dataNasc) + auxCreche(func.cpf) 
			- calcINSS(func.salario) - calcIRRF(func.salario) , 2, 'de_DE')) "Salário Líquido"
		from funcionario func
			inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
			inner join cargo crg on crg.CBO = trb.Cargo_CBO
				where trb.dataFim is null
					order by func.nome;

-- Funcionario, CPF, Data de Início, Data de Fim, Quantidade de Dias, Valor (função)
-- Ano de Referência
-- Calculo --> (Salario * 0.33) * qtdDias/30
delimiter $$
create function valorFerias(salario decimal(7,2), qtdDias int)
	returns decimal(6,2) deterministic
    begin
		return (salario * 0.33) * qtdDias / 30;
    end $$
delimiter ;

select func.nome "Funcionário", func.cpf "CPF", 
	date_format(fer.dataInicio, '%d/%m/%Y') "Data de Início",
    date_format(date_add(fer.dataInicio, interval fer.qtdDias day), '%d/%m/%Y') "Data de Início",
    fer.qtdDias "Quantidade de Dias", 
    concat("R$ ", format(valorFerias(func.salario, fer.qtdDias), 2, 'de_DE')) "Valor a Receber",
    concat("R$ ", format(fer.valor, 2, 'de_DE')) "Valor ChatGPT",
    fer.anoRef "Ano Referência"
    from ferias fer
	inner join funcionario func on func.cpf = fer.Funcionario_CPF
		order by anoRef desc, fer.dataInicio desc;

select dataHora
	from registroPonto 
		where Funcionario_CPF = "014.140.410-44" and
			date_format(dataHora, '%Y-%m-%d') = '2025-01-01'
				order by dataHora
					limit 1;

delimiter $$
create function calcHorasFuncDia(cpf varchar(14), dataDia date)
	returns int deterministic
	begin
		declare horasTrab, horasAntAlm, horasPosAlm int default 0;
        declare entrada, saidaAlm, entradaPosAlm, largada datetime;
        select dataHora into entrada 
			from registroPonto 
				where Funcionario_CPF = cpf and
					date_format(dataHora, '%Y-%m-%d') = dataDia
						order by dataHora
							limit 1;
		select dataHora into entradaPosAlm 
			from registroPonto 
				where Funcionario_CPF = cpf and
					date_format(dataHora, '%Y-%m-%d') = dataDia and
                    tipoES = "Entrada"                    
						order by dataHora desc
							limit 1;
         select dataHora into saidaAlm 
			from registroPonto 
				where Funcionario_CPF = cpf and
					date_format(dataHora, '%Y-%m-%d') = dataDia and
                    tipoES = "Saída" and
                    justificativa is not null
						limit 1;
		select dataHora into largada 
			from registroPonto 
				where Funcionario_CPF = cpf and
					date_format(dataHora, '%Y-%m-%d') = dataDia and
                    tipoES = "Saída" and
                    justificativa is null
						limit 1;
		select timestampdiff(hour, entrada, saidaAlm) into horasAntAlm;
        select timestampdiff(hour, entradaPosAlm, largada) into horasPosAlm;
        set horasTrab = horasAntAlm + horasPosAlm;
        return horasTrab;
    end $$
delimiter ;

select calcHorasFuncDia("014.140.410-44",'2025-01-02');

select distinct Funcionario_CPF "CPF Funcionário", 
	calcHorasFuncDia(funcionario_cpf, date_format(dataHora, '%Y-%m-%d'))
    from registroponto;

-- PL SQL Procedure
-- Cadastro Funcionario
delimiter $$
create procedure cadFuncionario(in pCPF varchar(14),
								in pnome varchar(60) ,
								in pnomeSocial varchar(45) ,
								in pdataNasc date ,
								in pgenero varchar(25) ,
								in pestadoCivil varchar(25) ,
								in pemail varchar(80) ,
								in pcarteiraTrab varchar(45) ,
								in pcargaHoraria int,
								in psalario decimal(7,2),
								in pchavePIX varchar(45) ,
								in pstatus tinyint ,
								in pfg decimal(6,2),
                                in pUF char(2),
								in pcidade varchar(45),
								in pbairro varchar(45),
								in prua varchar(45),
								in pnumero int,
								in pcomp varchar(45),
								in pcep varchar(9),
                                in ptelefone1 varchar(14),
                                in ptelefone2 varchar(14),
                                in ptelefone3 varchar(14))
	begin
		insert into funcionario
			value (pCPF, pnome, pnomeSocial, pdataNasc, pgenero, 
				pestadoCivil, pemail, pcarteiraTrab, pcargaHoraria, psalario, 
                pchavePIX, pstatus, pfg);
		insert into endereco
			value (pCPF, pUF, pcidade, pbairro, prua, pnumero, pcomp, pcep);
		insert into telefone (numero, Funcionario_CPF)
			value (ptelefone1, pCPF);
		if (ptelefone2 is not null) then 
			insert into telefone (numero, Funcionario_CPF)
				value (ptelefone2, pCPF);
		end if;
		if (ptelefone3 is not null) then 
			insert into telefone (numero, Funcionario_CPF)
				value (ptelefone3, pCPF);
		end if;
    end $$
delimiter ;

desc telefone;

call cadFuncionario("141.507.705-41", "Hugo Pires", null, '2005-05-16', 
	"Masculino", "Solteiro", "hugo.pires@gmail.com", "678141-57", 36, 2000,
    "141.507.705-41", 1, 200, "PE", "Recife", "Macaxeira", "Rua Dom Bosco",
	145, null, "50765-080", "8199576-7676", "81997659-9595", null);
    
select * from funcionario order by nome;

select * from endereco;

select * from telefone;





