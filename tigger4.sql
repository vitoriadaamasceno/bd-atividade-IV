Create database tigger;
use tigger;

-- 4 Crie um trigger que, ao inserir um novo item de venda na tabela "itens_venda", verifique se a quantidade em estoque do produto correspondente é suficiente para a venda. Se não for, retorne um erro informando que o produto está fora de estoque.

Create table Produtos(
	ID int primary key auto_increment,
	nome varchar(255),
	quantidade_estoque int
);

insert into Produtos(nome,quantidade_estoque)
values("Arvore de Natal",1);

Create table Vendas(
	ID int primary key auto_increment,
	data_venda date
);
insert into Vendas(data_venda)
values("2023-06-10");

create table Itens_venda(
	ID int primary key auto_increment,
	ID_Venda int,
	ID_Produto int,
	Quantidade int,
	foreign key (ID_venda) references Vendas(ID),
	foreign key (ID_Produto) references Produtos(ID)
);


DELIMITER //

CREATE TRIGGER verificar_estoque
BEFORE INSERT ON Itens_venda
FOR EACH ROW
BEGIN
  IF (
        SELECT quantidade_estoque
        FROM Produtos
        WHERE ID = NEW.id_produto
    ) < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantidade em estoque insuficiente para o produto.';
    END IF;
END;
//
DELIMITER ;

insert into Itens_venda(ID_Venda,ID_Produto,Quantidade)
values(1,1,3);

drop database tigger;
