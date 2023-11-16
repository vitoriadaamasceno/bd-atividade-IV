Create database tigger;
use tigger;

-- 3 Em um sistema de recursos humanos, crie um trigger que, ao inserir um novo funcionário na tabela "funcionarios", verifique se a data de admissão é maior que a data atual. Caso contrário, o trigger deve exibir uma mensagem de erro informando que a data de admissão deve ser maior que a data atual.

Create table Funcionarios(
	ID int primary key auto_increment,
	nome varchar(255),
	data_admissao date
);

DELIMITER //
CREATE TRIGGER validar_data
BEFORE INSERT ON Funcionarios
FOR EACH ROW
BEGIN
    IF NEW.data_admissao <= CURDATE()  THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A DATA DE ADMISSÃO TEM QUE SER MAIOR QUE A DATA ATUAL';
    END IF;
END;
//
DELIMITER ;

insert into Funcionarios(nome,data_admissao)
values("Marta","2023-02-04");


drop database tigger;
