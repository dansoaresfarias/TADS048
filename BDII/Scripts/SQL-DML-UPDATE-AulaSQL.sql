update funcionario
	set salario = 3200, fg = 500
		where cpf = "014.140.410-44";

update funcionario
	set salario = salario * 1.1
		where salario <= 2000;

-- Trava de segurança        
SET SQL_SAFE_UPDATES = 0;

update funcionario
	set salario = salario * 1.2
		where genero = "Feminino";

update funcionario
	set fg = 0.2 * salario
		where dataNasc <= '1985-06-30';

update funcionario
	set fg = 100
		where nome like "%Silva";

update funcionario
	set fg = 200
		where nome like "%Lima" or nome like "%Gomes";

update funcionario
	set fg = 0.1 * salario
		where dataNasc <= '1995-06-30' and salario >= 3000;


