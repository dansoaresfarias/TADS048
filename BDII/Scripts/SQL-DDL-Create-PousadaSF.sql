-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PousaSaoFrancisco
-- -----------------------------------------------------
-- Porjeto de banco de dados para o ensino da disciplina de Banco de Dados: DDL e DML.

-- -----------------------------------------------------
-- Schema PousaSaoFrancisco
--
-- Porjeto de banco de dados para o ensino da disciplina de Banco de Dados: DDL e DML.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PousaSaoFrancisco` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `PousaSaoFrancisco` ;

-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Funcionario` (
  `CPF` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `nomeSocial` VARCHAR(45) NULL,
  `dataNasc` DATE NOT NULL,
  `genero` VARCHAR(25) NOT NULL,
  `estadoCivil` VARCHAR(25) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `carteiraTrab` VARCHAR(45) NOT NULL,
  `cargaHoraria` INT UNSIGNED NOT NULL,
  `salario` DECIMAL(7,2) ZEROFILL UNSIGNED NOT NULL,
  `chavePIX` VARCHAR(45) NOT NULL,
  `status` TINYINT NOT NULL,
  `fg` DECIMAL(6,2) NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `carteiraTrab_UNIQUE` (`carteiraTrab` ASC) VISIBLE,
  UNIQUE INDEX `chavePIX_UNIQUE` (`chavePIX` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Endereco` (
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  `UF` CHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `comp` VARCHAR(45) NULL,
  `cep` VARCHAR(9) NOT NULL,
  INDEX `fk_Endereco_Fucnionario_idx` (`Funcionario_CPF` ASC) VISIBLE,
  PRIMARY KEY (`Funcionario_CPF`),
  CONSTRAINT `fk_Endereco_Fucnionario`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaSaoFrancisco`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Telefone` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(15) NOT NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  INDEX `fk_Telefone_Fucnionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  PRIMARY KEY (`idTelefone`),
  CONSTRAINT `fk_Telefone_Fucnionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaSaoFrancisco`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Dependente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Dependente` (
  `CPF` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `parentesco` VARCHAR(15) NOT NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_Dependente_Fucnionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Dependente_Fucnionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaSaoFrancisco`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`OcorrenciaInterna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`OcorrenciaInterna` (
  `idOcorrenciaInterna` INT NOT NULL AUTO_INCREMENT,
  `gravidade` VARCHAR(15) NOT NULL,
  `dataHora` DATETIME NOT NULL,
  `descricao` VARCHAR(250) NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idOcorrenciaInterna`),
  INDEX `fk_OcorrenciaInterna_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_OcorrenciaInterna_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaSaoFrancisco`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`RegistroPonto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`RegistroPonto` (
  `idRegistroPonto` INT NOT NULL AUTO_INCREMENT,
  `dataHora` DATETIME NOT NULL,
  `tipoES` VARCHAR(15) NOT NULL,
  `justificativa` VARCHAR(250) NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idRegistroPonto`),
  INDEX `fk_RegistroPonto_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_RegistroPonto_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaSaoFrancisco`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Ferias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Ferias` (
  `idFerias` INT NOT NULL AUTO_INCREMENT,
  `anoRef` INT NOT NULL,
  `dataInicio` DATE NOT NULL,
  `qtdDias` INT NOT NULL,
  `valor` DECIMAL(6,2) UNSIGNED ZEROFILL NOT NULL,
  `status` VARCHAR(25) NOT NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idFerias`),
  INDEX `fk_Ferias_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Ferias_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaSaoFrancisco`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `local` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(250) NULL,
  `Gerente_CPF` VARCHAR(14) NULL,
  PRIMARY KEY (`idDepartamento`),
  INDEX `fk_Departamento_Funcionario1_idx` (`Gerente_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_Funcionario1`
    FOREIGN KEY (`Gerente_CPF`)
    REFERENCES `PousaSaoFrancisco`.`Funcionario` (`CPF`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Cargo` (
  `CBO` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `faixaSalarial` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CBO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Trabalhar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Trabalhar` (
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  `Departamento_idDepartamento` INT NOT NULL,
  `Cargo_CBO` INT NOT NULL,
  `dataInicio` DATETIME NOT NULL,
  `dataFim` DATETIME NULL,
  PRIMARY KEY (`Funcionario_CPF`, `Departamento_idDepartamento`, `Cargo_CBO`),
  INDEX `fk_Funcionario_has_Departamento_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  INDEX `fk_Funcionario_has_Departamento_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  INDEX `fk_Trabalhar_Cargo1_idx` (`Cargo_CBO` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_has_Departamento_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaSaoFrancisco`.`Funcionario` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Funcionario_has_Departamento_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `PousaSaoFrancisco`.`Departamento` (`idDepartamento`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabalhar_Cargo1`
    FOREIGN KEY (`Cargo_CBO`)
    REFERENCES `PousaSaoFrancisco`.`Cargo` (`CBO`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Hospede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Hospede` (
  `docIdentificacao` VARCHAR(25) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(25) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `telefone` VARCHAR(15) NULL,
  `email` VARCHAR(45) NULL,
  `Responsavel_docIdentificacao` VARCHAR(25) NULL,
  PRIMARY KEY (`docIdentificacao`),
  INDEX `fk_Hospede_Hospede1_idx` (`Responsavel_docIdentificacao` ASC) VISIBLE,
  CONSTRAINT `fk_Hospede_Hospede1`
    FOREIGN KEY (`Responsavel_docIdentificacao`)
    REFERENCES `PousaSaoFrancisco`.`Hospede` (`docIdentificacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Reserva` (
  `idReserva` INT NOT NULL AUTO_INCREMENT,
  `dataInicio` DATETIME NOT NULL,
  `dataFim` DATETIME NOT NULL,
  `qtdPessoas` INT NOT NULL,
  `status` VARCHAR(15) NOT NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  `Responsavel_docIdentificacao` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_Reserva_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  INDEX `fk_Reserva_Hospede1_idx` (`Responsavel_docIdentificacao` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `PousaSaoFrancisco`.`Funcionario` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Reserva_Hospede1`
    FOREIGN KEY (`Responsavel_docIdentificacao`)
    REFERENCES `PousaSaoFrancisco`.`Hospede` (`docIdentificacao`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`TipoUH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`TipoUH` (
  `idTipoUH` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idTipoUH`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`UH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`UH` (
  `idUH` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(25) NOT NULL,
  `local` VARCHAR(25) NOT NULL,
  `qtdPessoas` INT NOT NULL,
  `TipoUH_idTipoUH` INT NOT NULL,
  PRIMARY KEY (`idUH`),
  INDEX `fk_UH_TipoUH1_idx` (`TipoUH_idTipoUH` ASC) VISIBLE,
  CONSTRAINT `fk_UH_TipoUH1`
    FOREIGN KEY (`TipoUH_idTipoUH`)
    REFERENCES `PousaSaoFrancisco`.`TipoUH` (`idTipoUH`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`UH_Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`UH_Reserva` (
  `UH_idUH` INT NOT NULL,
  `Reserva_idReserva` INT NOT NULL,
  PRIMARY KEY (`UH_idUH`, `Reserva_idReserva`),
  INDEX `fk_UH_has_Reserva_Reserva1_idx` (`Reserva_idReserva` ASC) VISIBLE,
  INDEX `fk_UH_has_Reserva_UH1_idx` (`UH_idUH` ASC) VISIBLE,
  CONSTRAINT `fk_UH_has_Reserva_UH1`
    FOREIGN KEY (`UH_idUH`)
    REFERENCES `PousaSaoFrancisco`.`UH` (`idUH`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UH_has_Reserva_Reserva1`
    FOREIGN KEY (`Reserva_idReserva`)
    REFERENCES `PousaSaoFrancisco`.`Reserva` (`idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Hospedagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Hospedagem` (
  `Reserva_idReserva` INT NOT NULL,
  `checkIn` DATETIME NOT NULL,
  `chekOut` DATETIME NULL,
  `valorTotal` DECIMAL(7,2) ZEROFILL UNSIGNED NOT NULL,
  INDEX `fk_Hospedagem_Reserva1_idx` (`Reserva_idReserva` ASC) VISIBLE,
  PRIMARY KEY (`Reserva_idReserva`),
  CONSTRAINT `fk_Hospedagem_Reserva1`
    FOREIGN KEY (`Reserva_idReserva`)
    REFERENCES `PousaSaoFrancisco`.`Reserva` (`idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Hospedar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Hospedar` (
  `Hospedagem_Reserva_idReserva` INT NOT NULL,
  `Hospede_docIdentificacao` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Hospedagem_Reserva_idReserva`, `Hospede_docIdentificacao`),
  INDEX `fk_Hospedagem_has_Hospede_Hospede1_idx` (`Hospede_docIdentificacao` ASC) VISIBLE,
  INDEX `fk_Hospedagem_has_Hospede_Hospedagem1_idx` (`Hospedagem_Reserva_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_Hospedagem_has_Hospede_Hospedagem1`
    FOREIGN KEY (`Hospedagem_Reserva_idReserva`)
    REFERENCES `PousaSaoFrancisco`.`Hospedagem` (`Reserva_idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hospedagem_has_Hospede_Hospede1`
    FOREIGN KEY (`Hospede_docIdentificacao`)
    REFERENCES `PousaSaoFrancisco`.`Hospede` (`docIdentificacao`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `quantidade` INT NOT NULL,
  `valor` DECIMAL(5,2) UNSIGNED ZEROFILL NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`ItensHospedagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`ItensHospedagem` (
  `Hospedagem_Reserva_idReserva` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `qtd` INT NOT NULL,
  `valorUnd` DECIMAL(5,2) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`Hospedagem_Reserva_idReserva`, `Produto_idProduto`),
  INDEX `fk_Hospedagem_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Hospedagem_has_Produto_Hospedagem1_idx` (`Hospedagem_Reserva_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_Hospedagem_has_Produto_Hospedagem1`
    FOREIGN KEY (`Hospedagem_Reserva_idReserva`)
    REFERENCES `PousaSaoFrancisco`.`Hospedagem` (`Reserva_idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hospedagem_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `PousaSaoFrancisco`.`Produto` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`Ocorrencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`Ocorrencia` (
  `idOcorrencia` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `obs` VARCHAR(250) NULL,
  `valor` DECIMAL(7,2) UNSIGNED ZEROFILL NULL,
  `Hospedagem_Reserva_idReserva` INT NOT NULL,
  PRIMARY KEY (`idOcorrencia`),
  INDEX `fk_Ocorrencia_Hospedagem1_idx` (`Hospedagem_Reserva_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_Ocorrencia_Hospedagem1`
    FOREIGN KEY (`Hospedagem_Reserva_idReserva`)
    REFERENCES `PousaSaoFrancisco`.`Hospedagem` (`Reserva_idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PousaSaoFrancisco`.`FormaPag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PousaSaoFrancisco`.`FormaPag` (
  `idFormaPag` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(25) NOT NULL,
  `valorPago` DECIMAL(7,2) UNSIGNED ZEROFILL NOT NULL,
  `qtdParcelas` INT NULL,
  `Hospedagem_Reserva_idReserva` INT NOT NULL,
  PRIMARY KEY (`idFormaPag`),
  INDEX `fk_FormaPag_Hospedagem1_idx` (`Hospedagem_Reserva_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPag_Hospedagem1`
    FOREIGN KEY (`Hospedagem_Reserva_idReserva`)
    REFERENCES `PousaSaoFrancisco`.`Hospedagem` (`Reserva_idReserva`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

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

-- -----------------------------------------------------
-- 1. Remova o Procedure antigo, se ele existir
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `PousaSaoFrancisco`.`sp_gerar_hospedagem_completa`;

-- -----------------------------------------------------
-- 2. Mude o delimitador
-- -----------------------------------------------------
DELIMITER $$

-- -----------------------------------------------------
-- 3. Crie o novo Procedure Corrigido
-- -----------------------------------------------------
CREATE PROCEDURE `PousaSaoFrancisco`.`sp_gerar_hospedagem_completa`(IN total_registros INT)
BEGIN
	-- -----------------------------------------------------
	-- Declaração de Variáveis
	-- -----------------------------------------------------
	DECLARE i INT DEFAULT 0;
	DECLARE v_id_reserva INT;
	DECLARE v_cpf_func VARCHAR(14);
	DECLARE v_doc_hospede VARCHAR(25);
	DECLARE v_id_uh INT;
	DECLARE v_valor_uh DECIMAL(7,2);
	DECLARE v_data_inicio DATETIME;
	DECLARE v_data_fim DATETIME;
	DECLARE v_dias INT;
	DECLARE v_valor_diarias DECIMAL(7,2) DEFAULT 0;
	DECLARE v_valor_total DECIMAL(7,2) DEFAULT 0;
	DECLARE v_valor_itens DECIMAL(7,2) DEFAULT 0;
	DECLARE v_id_produto INT;
	DECLARE v_valor_produto DECIMAL(5,2);
	DECLARE v_qtd_produto INT;
	DECLARE j INT;
	DECLARE v_num_itens INT;

	-- -----------------------------------------------------
	-- Loop Principal (para gerar N hospedagens)
	-- -----------------------------------------------------
	WHILE i < total_registros DO
	
		-- 1. Resetar valores de cálculo
		SET v_valor_diarias = 0;
		SET v_valor_itens = 0;
		SET v_valor_total = 0;

		-- 2. Selecionar chaves estrangeiras aleatórias
		SELECT CPF INTO v_cpf_func FROM Funcionario ORDER BY RAND() LIMIT 1;
		SELECT docIdentificacao INTO v_doc_hospede FROM Hospede ORDER BY RAND() LIMIT 1;
		SELECT idUH, valor INTO v_id_uh, v_valor_uh FROM UH ORDER BY RAND() LIMIT 1;

		-- 3. Definir datas (diárias de 1 a 7 dias, no último ano)
		SET v_dias = FLOOR(1 + RAND() * 7); 
		SET v_data_inicio = DATE_SUB(NOW(), INTERVAL FLOOR(30 + RAND() * 365) DAY);
		SET v_data_fim = DATE_ADD(v_data_inicio, INTERVAL v_dias DAY);
		SET v_valor_diarias = (v_valor_uh * v_dias);

		-- -----------------------------------------------------
		-- 4. Criar a Reserva
		-- -----------------------------------------------------
		INSERT INTO Reserva (dataInicio, dataFim, qtdPessoas, status, Funcionario_CPF, Responsavel_docIdentificacao)
		VALUES (v_data_inicio, v_data_fim, FLOOR(1 + RAND() * 2), 'Finalizada', v_cpf_func, v_doc_hospede);

		-- 5. Obter o ID da Reserva que acabamos de criar
		SET v_id_reserva = LAST_INSERT_ID();

		-- -----------------------------------------------------
		-- 6. Ligar a UH (quarto) à Reserva (N:M)
		-- -----------------------------------------------------
		INSERT INTO UH_Reserva (UH_idUH, Reserva_idReserva) VALUES (v_id_uh, v_id_reserva);

		-- -----------------------------------------------------
		-- 7. Criar a Hospedagem (Check-in) com valor PROVISÓRIO
		-- (Este é o passo que foi movido e corrige o erro)
		-- -----------------------------------------------------
		INSERT INTO Hospedagem (Reserva_idReserva, checkIn, chekOut, valorTotal)
		VALUES (v_id_reserva, 
                DATE_ADD(v_data_inicio, INTERVAL FLOOR(RAND() * 60) MINUTE), 
                DATE_SUB(v_data_fim, INTERVAL FLOOR(RAND() * 60) MINUTE),   
                v_valor_diarias); -- Inserindo apenas o valor das diárias por enquanto

		-- -----------------------------------------------------
		-- 8. Adicionar Itens de Hospedagem (Consumo)
		-- (Agora isso funciona, pois a Hospedagem (pai) já existe)
		-- -----------------------------------------------------
		SET j = 0;
		SET v_num_itens = FLOOR(RAND() * 6); -- De 0 a 5 itens consumidos
		
		WHILE j < v_num_itens DO
			SELECT idProduto, valor INTO v_id_produto, v_valor_produto FROM Produto ORDER BY RAND() LIMIT 1;
			SET v_qtd_produto = FLOOR(1 + RAND() * 3); 
			
			INSERT INTO ItensHospedagem (Hospedagem_Reserva_idReserva, Produto_idProduto, qtd, valorUnd)
			VALUES (v_id_reserva, v_id_produto, v_qtd_produto, v_valor_produto);
			
			SET v_valor_itens = v_valor_itens + (v_valor_produto * v_qtd_produto);
			SET j = j + 1;
		END WHILE;

		-- -----------------------------------------------------
		-- 9. Atualizar o Valor Total da Hospedagem
		-- (Agora somamos os itens ao valor das diárias)
		-- -----------------------------------------------------
		SET v_valor_total = v_valor_diarias + v_valor_itens;
		UPDATE Hospedagem SET valorTotal = v_valor_total WHERE Reserva_idReserva = v_id_reserva;
        
		-- -----------------------------------------------------
		-- 10. Ligar Hóspede à Hospedagem (N:M)
		-- -----------------------------------------------------
		INSERT INTO Hospedar (Hospedagem_Reserva_idReserva, Hospede_docIdentificacao)
		VALUES (v_id_reserva, v_doc_hospede);

		-- -----------------------------------------------------
		-- 11. Criar Forma de Pagamento
		-- (Usa o v_valor_total que acabamos de atualizar)
		-- -----------------------------------------------------
		INSERT INTO FormaPag (tipo, valorPago, qtdParcelas, Hospedagem_Reserva_idReserva)
		VALUES (
			(SELECT ELT(1 + FLOOR(RAND() * 3), 'PIX', 'Cartão de Crédito', 'Cartão de Débito')),
			v_valor_total, -- Valor final correto
			(SELECT ELT(1 + FLOOR(RAND() * 3), 1, 1, 3)),
			v_id_reserva
		);

		-- -----------------------------------------------------
		-- 12. (Opcional) Adicionar uma Ocorrência aleatória 
		-- -----------------------------------------------------
		IF RAND() > 0.8 THEN 
			INSERT INTO Ocorrencia (tipo, obs, valor, Hospedagem_Reserva_idReserva)
			VALUES ('Observação', 'Dados gerados automaticamente.', NULL, v_id_reserva);
		END IF;

		SET i = i + 1;
	END WHILE;

	SELECT CONCAT(i, ' hospedagens completas geradas.') AS Resultado;
	
END$$

-- -----------------------------------------------------
-- 4. Retorne o delimitador ao padrão
-- -----------------------------------------------------
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
