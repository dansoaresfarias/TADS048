-- SQL DDL - ALTER

alter table funcionario add column RG varchar(15) unique not null;

alter table funcionario change column RG 
	RG varchar(20) unique not null after carteiraTrab;
    
alter table funcionario drop column RG;