Create database tigger;
use tigger;

-- 1-Crie um trigger que, ao inserir um novo empréstimo na tabela "emprestimos", atualize automaticamente a quantidade de estoque do livro correspondente na tabela "livros", subtraindo 1.
create table Livros(
	ID int auto_increment primary key,
	titulo varchar(255), 
	autor varchar(255), 
	quantidade_estoque int
);

insert into Livros(titulo,autor,quantidade_estoque)
values("Vitoria Campeao","Colossal",4);

create table Emprestimos(
	ID int auto_increment primary key,
	id_livro int, 
	data_emprestimo date, 
	data_devolucao date,
	foreign key (id_livro) references Livros(ID)
);

DELIMITER //
CREATE TRIGGER atualizar_estoque
AFTER INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    UPDATE Livros
    SET quantidade_estoque = quantidade_estoque - 1
    WHERE ID = NEW.id_livro;
END;
//
DELIMITER ;

insert into Emprestimos(id_livro,data_emprestimo,data_devolucao)
values(1,"2023-09-11","2023-12-25");

SELECT * FROM Livros;
SELECT * FROM Emprestimos;
drop database tigger;
