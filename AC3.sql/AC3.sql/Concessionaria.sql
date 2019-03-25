create database Concessionaria 

use Concessionaria ;
 


create table Ano(
				idAno int identity(1,1),
				ano numeric (200) not null,
constraint pkidAno primary key (idAno)

);




create table Mes(
				idMes int identity(15,3),
				mes numeric(200) not null ,
constraint pkidMes primary key(idMes)

);


create table Modelo(
					idModelo int identity(1,1),
					Descricao varchar(50) not null,

constraint pkidModelo primary key (idModelo)

	);


	create table Fabricante(
							idFabricante int identity(1,1),
							Nome varchar(50) not null,
							cidade varchar(50) not null,
							endereco varchar(100),
							UF char(2) ,
							telefone varchar(20),
							contato varchar(50) not null,

	constraint pkidFabricante primary key (idFabricante)
						 
	);







	create table Veiculo(
						idVeiculo smallint identity (1,1) ,
						descricao varchar(50) not null ,
						valor money not null,
						idModelo int,
						idFabricante int,
						idAnoFabricacao int,						
						dataCompra date not null,

	constraint pkidVeiculo primary key (idVeiculo),
	constraint fkIdModelo foreign key (idModelo) references Modelo(idModelo),
	constraint fkidFabricante foreign key (idFabricante) references Fabricante(idFabricante),
	constraint fkidAnoFabricacao foreign key (idAnoFabricacao) references Ano(idAno)
	

	);


	create table VendasAnuais(
							idVendas smallint identity(1,1),
							qtd int not null,
							idVeiculo smallint,
							idAnodaVenda int,
							idMesdaVenda int,
	constraint pkidVendas primary key(idVendas),
	constraint fkidVeiculo foreign key (idVeiculo) references Veiculo(idVeiculo),
	constraint fkidAnodaVenda foreign key (idAnodaVenda) references Ano(idAno),
	constraint fkidMesdaVenda foreign key (idMesdaVenda) references Mes(idMes)

	);