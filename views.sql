Create database views;
use views;

-- 1 Crie uma view chamada "relatorio_pedidos_cliente" que exiba o nome do cliente, o número de pedidos realizados por ele e o valor total gasto em pedidos.

create table Clientes(
	ID int primary key auto_increment, 
	nome varchar(255), 
	email varchar(255), 
	telefone varchar(255)
);

insert into Clientes(nome,email,telefone)
values("Maria","ma@gmail.com","(11) 11111-1111");

create table Pedidos(
ID int primary key auto_increment, 
ID_cliente int, 
data_pedido date,
valor_total float,
foreign key (ID_cliente) references Clientes(ID)
);

insert into Pedidos(ID_cliente,data_pedido,valor_total)
values(1,"2022-02-22",15);

create view relatorio_pedidos_cliente as
select C.nome as "Nome",
count(P.ID) as "Quantidade de Pedidos",
P.valor_total as "Valor total"
From Clientes C
inner join Pedidos P on C.ID = P.ID_Cliente;


select * from relatorio_pedidos_cliente;
drop database views;


-- 2 Crie uma view chamada "estoque_critico" que exiba o nome e a quantidade em estoque dos produtos que possuem quantidade abaixo de um determinado limite estabelecido pela empresa.    
Create database views;
use views;
create table Produtos(
	ID int primary key auto_increment, 
	nome varchar (255), 
	preco_unitario decimal(10.2), 
	categoria varchar(255)
);

insert into Produtos(nome,preco_unitario,categoria)
values("Blusa",2.00,"Roupas");

insert into Produtos(nome,preco_unitario,categoria)
values("Calça",10.00,"Roupas");

create table Estoque(
ID int auto_increment primary key,
ID_Produto int, 
quantidade int,
foreign key (ID_Produto) references Produtos(ID)
);

insert into Estoque(ID_Produto,quantidade)
values(1,6);

insert into Estoque(ID_Produto,quantidade)
values(2,11);

create view estoque_critico as
select P.nome as "Nome",
E.quantidade as "Quantidade"
from Produtos P
inner join Estoque E
on P.ID = E.ID_Produto
where Quantidade < 10;

select * from  estoque_critico;

drop database views;

-- 3 Crie uma view chamada "relatorio_vendas_funcionario" que exiba o nome do funcionário, o número de vendas realizadas por ele e o valor total das vendas.
Create database views;
use views;

create table funcionarios(
ID int primary key auto_increment,
nome varchar(255),
cargo varchar(255),
salario decimal(10.2)
);

insert into funcionarios(nome,cargo,salario)
values("Memel","faxineira",10000.00);

insert into funcionarios(nome,cargo,salario)
values("Bruninho","Chefe",1110.00);


create table vendas(
	ID int primary key auto_increment,
	ID_Funcionario int,
	data_venda date,
	valor_venda decimal(10.2)
);

insert into vendas(ID_Funcionario,data_venda,valor_venda)
values(1,"2022-10-02",2000);

insert into vendas(ID_Funcionario,data_venda,valor_venda)
values(2,"2023-08-11",1000);

create view relatorio_vendas_funcionario as
select F.nome as "Nome do Funcionário",
count(V.ID) as "Número de Vendas",
Sum(V.valor_venda) as "Valor Total das Vendas"
from funcionarios F 
left join vendas V
on F.ID = V.ID_Funcionario
group by F.nome;


select * from relatorio_vendas_funcionario;

drop database views;

-- 4  Crie uma view chamada "relatorio_produtos_categoria" que exiba o nome da categoria e a quantidade de produtos pertencentes a cada categoria.
Create database views;
use views;

create table categorias(
	ID int primary key auto_increment,
	Nome varchar(255),
	descricao text
);

insert into categorias(Nome,descricao)
values("Blusas","Verdes");

insert into categorias(Nome,descricao)
values("Short","Brancas");


create table produtos_1(
	ID int primary key auto_increment, 
	nome varchar (255), 
	preco_unitario decimal(10.2), 
	ID_Categoria int,
	foreign key (ID_Categoria) references categorias(ID)
);

insert into produtos_1(nome,preco_unitario,ID_Categoria)
values("Nike",1200,2);

insert into produtos_1(nome,preco_unitario,ID_Categoria)
values("Adidas",112.00,1);



create view relatorio_produtos_categoria as
select C.nome as "Nome",
count(P.ID) as "Quantidade de Produtos"
from categorias C
left join produtos_1 P
on C.ID = P.ID_Categoria
group by C.nome;


select * from relatorio_produtos_categoria;
drop database views;

-- 5 Crie uma view chamada "relatorio_pagamentos_cidade" que exiba o nome da cidade e o valor total de pagamentos realizados por clientes dessa cidade.
Create database views;
use views;

create table Clientes(
	ID int primary key auto_increment, 
	nome varchar(255), 
	endereco varchar(255), 
	cidade varchar(255)
);

insert into Clientes(nome,endereco,cidade)
values("Laura","Rua 10","Salvador");

insert into Clientes(nome,endereco,cidade)
values("Laila","Rua 20","Rio de Janeiro");


create table Pagamento(
	ID int primary key auto_increment,
	ID_Cliente int,
	data_pagamento date,
	valor_pagamento float,
	foreign key (ID_Cliente) references Clientes(ID)
);

insert into Pagamento(ID_Cliente,data_pagamento,valor_pagamento)
values(1,"2022-10-22",1000);

insert into Pagamento(ID_Cliente,data_pagamento,valor_pagamento)
values(2,"2022-08-10",3000);



create view relatorio_pagamentos_cidade as
select C.nome as "Nome do Cliente",
C.cidade as "Cidade do Cliente",
sum(P.valor_pagamento) as "Valor total de pagamentos"
from Clientes C
inner join Pagamento P
on C.ID = P.ID_Cliente
group by C.nome;

select * from relatorio_pagamentos_cidade;