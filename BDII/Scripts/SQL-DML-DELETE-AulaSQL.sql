delete from funcionario
	where cpf = "014.140.410-44";

start transaction;
delete from funcionario
	where cpf = "012.147.258-63";
rollback;
commit;

delete from funcionario
	where salario >= 3500;

start transaction;    
delete from funcionario;
commit;