Create database tigger;
use tigger;

-- 2.Crie um trigger que, ao inserir uma nova transação na tabela "transacoes", atualize automaticamente o saldo da conta correspondente na tabela "contas". Se o tipo da transação for "entrada", adicione o valor ao saldo. Se o tipo for "saída", subtraia o valor do saldo.

create table Contas(
	ID int auto_increment primary key,
	nome varchar(255),
	saldo decimal(10.2)
);

insert into Contas(nome,saldo)
values("Maria",1500);

insert into Contas(nome,saldo)
values("Gundes",750);

create table Transacoes(
	ID int auto_increment primary key,
	id_conta int, 
	tipo varchar(255), 
	valor decimal(10.2),
	foreign key (id_conta) references Contas(ID)
);


DELIMITER //
CREATE TRIGGER atualiza_conta
AFTER INSERT ON Transacoes
FOR EACH ROW
BEGIN
    IF New.tipo="Entrada" THEN
    UPDATE Contas
    SET saldo = saldo + new.valor
    WHERE ID = NEW.id_conta;
    ELSE
    UPDATE Contas
    SET saldo = saldo - new.valor
    WHERE  ID = NEW.id_conta;
    END IF;
END;
//
DELIMITER ;

insert into Transacoes(id_conta,tipo,valor)
values(1,"Entrada",1000);

insert into Transacoes(id_conta,tipo,valor)
values(2,"Saída",10.00);

select * from Contas;
drop database tigger;
