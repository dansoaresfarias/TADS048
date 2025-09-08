-- SQL DDL
create schema pousdaDanilo;

drop schema pousdaDanilo;

create schema pousadaDanilo;

use pousadaDanilo;

create table funcionario (
	cpf varchar(14) primary key,
    nome varchar(60) not null
);

drop table funcionario;

-- SQL DDL : CREATE TABLE
create table funcionario(
	CPF varchar(14) primary key not null,
    nome varchar(60) not null,
    nomeSocial varchar(45),
    dataNasc date not null,
    genero varchar(25) not null,
    estadoCivil varchar(25) not null,
    email varchar(80) unique not null,
    carteiraTrab varchar(45) unique not null,
    cargaHoraria int unsigned not null,
    salario decimal(7,2) zerofill unsigned not null,
    chavePIX varchar(45) unique not null,
    `status` tinyint not null,
    fg decimal(6,2)
);

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

desc funcionario;

-- SQL DDL : CREATE TABLE
create table Endereco(
	Funcionario_CPF varchar(14) primary key not null,
    UF char(2) not null,
    cidade varchar(45) not null,
    bairro varchar(45) not null,
    rua varchar(45) not null,
    numero int not null,
    comp varchar(45),
    cep varchar(9) not null,
    foreign key (Funcionario_CPF) references Funcionario (CPF)
		on update cascade
        on delete cascade
);

desc endereco;

create table telefone(
	idTelefone int auto_increment not null,
    numero varchar(15) unique not null,
    Funcionario_CPF varchar(14) not null,
    primary key (idTelefone),
    foreign key (Funcionario_CPF) references Funcionario (CPF)
		on update cascade
        on delete cascade
);

desc telefone;

