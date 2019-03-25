

create database LMS;

use LMS ;
 

create table Usuario(
					ID_Usuario int,
					Login_Usuario varchar,
					Senha int,
					Dt_Expiracao datetime  constraint DF_Dt_Expiracao default (getdate()),

constraint PK_ID_Usuario primary key (ID_Usuario),
constraint UQ_Login_Usuario unique (Login_Usuario),
);


create table Coordenador(
						ID_Coordenador int, 
						ID_Usuario int,
						Nome char ,
						Email varchar,
						Celular smallint,
constraint PK_ID_Coordenador primary key (ID_Coordenador),
constraint FK_ID_Usuario_Coordenador foreign key (ID_Usuario ) references Usuario(ID_Usuario),
constraint UQ_Email_Coordenador unique (Email),
constraint UQ_Celular_Coordenador unique(Celular)


);


create table Aluno(
					ID_Aluno int ,
					ID_Usuario int ,
					Nome char ,
					Email varchar, 
					Celular smallint ,
					RA int, 
					Foto varbinary,
constraint PK_ID_Aluno primary key (ID_Aluno),
constraint FK_ID_Usuario_Aluno foreign key (ID_Usuario) references Usuario(ID_Usuario),
constraint UQ_Email_Aluno unique (Email),
constraint UQ_Celular_Aluno unique (Celular)
);

create table Professor(
						ID_Professor int,
						ID_Usuario int,
						Email varchar,
						Celular smallint, 
						Apelido varchar,
constraint PK_ID_Professor primary key (ID_Professor ),
constraint FK_ID_Usuario_Professor foreign key (ID_Usuario) references Usuario(ID_Usuario),
constraint UQ_Email_Professor unique (Email),
constraint UQ_Celular_Professor unique (Celular)
);


create table Disciplina(
						ID_Disciplina int , 
						Nome char, 
						Data datetime constraint DF_Data default(getdate()), 
						Status_Disciplina varchar constraint DF_Status_Disciplina default('Aberto'),
						Plano_de_Ensino text, 
						Carga_Horaria int,
						Competencias varchar,
						Habilidades text,
						Ementa varchar, 
						Conteudo_Programatico varchar,
						Bibliografia_Basica varchar,
						Bibliografia_Complementar varchar,
						Percentual_Pratico int,
						Percentual_Teorico int,
						ID_Coordenador int ,
constraint PK_ID_Disciplina primary key (ID_Disciplina),
constraint UQ_Nome_Disciplina unique (Nome),
constraint CK_Status_Disciplina check (Status_Disciplina  in ( 'Aberto') or Status_Disciplina in ('Fechado')) ,
constraint CK_Carga_Horaria check (Carga_Horaria in ('40') or Carga_Horaria in ('80')),
constraint CK_Percentual_Pratico check (Percentual_Pratico >= 00 and Percentual_Pratico <=100 ),
constraint CK_Percentual_Teorico check (Percentual_Teorico >=00 and Percentual_Teorico <=100),
constraint FK_ID_Coordenador_Disciplina foreign key (ID_Coordenador) references Coordenador(ID_Coordenador)
						 
);
 

 create table Curso(
					ID_curso int,
					Nome varchar,
constraint PK_ID_Curso primary key (ID_Curso),
constraint UQ_Nome_Curso unique (Nome)

);


create table Disciplina_Ofertada(
								ID_Disciplina_Ofertada int,
								ID_Coordenador int, 
								Dt_Inicio_Matricula date,
								Dt_Fim_Matricula date,
								Id_Disciplina int,
								ID_Curso int,
								Ano int,
								Semestre smallint,
								Turma varchar, 
								ID_Professor int not null,
								Metodologia varchar not null, 
								Recursos varchar not null,
								Cristerio_Avalicao varchar not null,
								Plano_de_Aulas varchar not null,
constraint PK_ID_Disciplina_Ofertada primary key (ID_Disciplina_Ofertada),
constraint FK_ID_Coordenador_Disciplina_Ofertada foreign key (ID_Coordenador) references Coordenador(ID_Coordenador),
constraint FK_ID_Disciplina_Disciplina_Ofertada  foreign key (ID_Disciplina) references Disciplina(ID_Disciplina),
constraint FK_ID_Curso_Disciplina_Ofertada  foreign key (ID_Curso) references Curso(ID_Curso), 
constraint CK_Ano check (Ano >= 1900 and Ano <=2100),
constraint CK_Semestre check (Semestre in ('1') or Semestre in('2')),
constraint CK_Turma check ( Turma in ('A' ) or Turma in ('Z')),
constraint FK_ID_Professor_Disciplina_Ofertada  foreign key (ID_Professor) references Professor(ID_Professor)  , 

);




create table Solicitacao_Matricula(
								ID_Solicitacao_Matricula int,
								ID_Aluno int,
								ID_Disciplina_Ofertada int,
								Dt_Solicitacao datetime constraint DF_Dt_Solicitacao default (sysdatetime()),
								ID_Coordenador int null,
								Status_Solicitacao_Matricula varchar constraint DF_Status_Solicitacao_Matricula  default('Solicitada'),
constraint PK_ID_Solicitacao_Matricula primary key (ID_Solicitacao_Matricula),
constraint FK_ID_Aluno_Solicitacao_Matricula foreign key (ID_Aluno) references Aluno(ID_Aluno),
constraint FK_ID_Disciplina_Ofertada_Solicitacao_Matricula foreign key (ID_Disciplina_Ofertada) references Disciplina_Ofertada(ID_Disciplina_Ofertada),
constraint FK_ID_Coordenador_Solicitacao_Matricula foreign key (ID_Coordenador) references Coordenador(ID_Coordenador),
constraint CK_Status_Solicitacao_Matricula check( Status_Solicitacao_Matricula in ('Solicitada') and  Status_Solicitacao_Matricula in('Aprovado') and  Status_Solicitacao_Matricula in('Rejeitada') or  Status_Solicitacao_Matricula in ('Cancelada')),


);


create table Atividade(
						ID_Atividade int, 
						Titulo varchar,
						Descricao varchar,
						Conteudo varchar,
						Tipo varchar, 
						Extras varchar , 
						ID_Professor int,
constraint PK_ID_Atividade  primary key (ID_Atividade),
constraint UQ_Titulo_Atividade unique (Titulo), 
constraint CK_Tipo check (Tipo in('Resposta Aberta') or Tipo in ('Teste')),
constraint FK_ID_Professor_Atividade foreign key (ID_Professor) references Professor (ID_Professor)

);

create table Atividade_Vinculada(
								ID_Atividade_Vinculada int,
								ID_Atividade int ,
								ID_Professor int,
								ID_Disciplina_Ofertada int,
								Rotulo varchar , 
								Status_Atividade_Vinculada varchar , 
								Dt_Inicio_Respostas date , 
								Dt_Fim_Respostas date ,
constraint PK_ID_Atividade_Vinculada primary key (ID_Atividade_Vinculada),
constraint UQ_Rotulo_Atividade_Vinculada unique (Rotulo, ID_Atividade , ID_Disciplina_Ofertada),
constraint FK_ID_Atividade_Atividade_Vinculada foreign key (ID_Atividade) references Atividade(ID_Atividade),
constraint FK_ID_Professor_Atividade_Vinculada foreign key (ID_Professor) references Professor(ID_Professor),
constraint FK_ID_Disciplina_Ofertada_Atividade_Vinculada foreign key (ID_Disciplina_Ofertada) references Disciplina_Ofertada(ID_Disciplina_Ofertada),
constraint CK_Status_Atividade_Vinculada check (Status_Atividade_Vinculada in ('Disponibilizada') and Status_Atividade_Vinculada in('Aberta') and Status_Atividade_Vinculada in ('Fechada') and Status_Atividade_Vinculada in ('Encerrada') or Status_Atividade_Vinculada in ('Prorrogada')),

);

create table Entrega(
					ID_Entrega int, 
					ID_Aluno int,
					ID_Atividade_Vinculada int,
					Titulo varchar, 
					Resposta varchar, 
					Dt_Entrega datetime constraint DF_Dt_Entrega default (sysdatetime()), 
					Status_Entrega varchar constraint DF_Status_Entrega default('Entregue'),
					ID_Professor int  not null,
					Nota float not null ,
					Dt_Avaliacao date null, 
					Obs text null , 
constraint PK_ID_Entrega primary key (ID_Entrega),
constraint FK_ID_Aluno_Entrega foreign key (ID_Aluno) references Aluno(ID_Aluno),
constraint UQ_Atividade_Vinculada_Aluno unique (ID_Aluno , ID_Atividade_Vinculada),
constraint FK_ID_Atividade_Vinculada_Entrega foreign key (ID_Atividade_Vinculada) references Atividade_Vinculada(ID_Atividade_Vinculada),
constraint CK_Status_Entrega check ( Status_Entrega in ('Entregue') or Status_Entrega in ('Corrigido')),
constraint FK_ID_Professor_Entrega foreign key (ID_Entrega) references Professor(ID_Professor),
constraint CK_Nota check (Nota >=0.00 and Nota <=10.00),

);


create table Mensagem(
					ID_Mensagem int,
					ID_Aluno int,
					ID_Professor int , 
					Assunto text , 
					Referencia varchar , 
					Conteudo varchar , 
					Status_Mensagem varchar constraint DF_Status_Mensagem default('Respondido ''Lido'),
					Dt_Envio date constraint DF_Dt_Envio default (getdate()),
					Dt_Resposta date, 
					Resposta varchar ,
constraint PK_ID_Mensagem primary key (ID_Mensagem),
constraint FK_ID_Aluno_Mensagem foreign key (ID_Aluno) references Aluno(ID_Aluno),
constraint FK_ID_Professor_Mensagem foreign key (ID_Professor) references Professor(ID_Professor),
constraint CK_Status_Mensagem check ( Status_Mensagem in('Enviado') and Status_Mensagem in('Lido') or Status_Mensagem in ('Respondido')),


);




