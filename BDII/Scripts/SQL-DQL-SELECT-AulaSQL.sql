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
                



