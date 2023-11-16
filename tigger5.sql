Create database tigger;
use tigger;

-- 5 Crie um trigger que, ao inserir uma nova matrícula na tabela "matriculas", verifique se o aluno correspondente possui idade suficiente para a série em que está sendo matriculado. Se não tiver, retorne um erro informando que o aluno não atende aos requisitos de idade para a série.

Create table Aluno(
	ID int primary key auto_increment, 
	Nome varchar(255), 
	Data_nascimento date, 
	Serie int
);

Create table Matriculas(
	ID int primary key auto_increment,
	ID_Aluno int,
	Data_matricula date,
	Status varchar(255),
	foreign key (ID_Aluno) references Aluno(ID)
);

DELIMITER //
CREATE TRIGGER verificar_idade_aluno
BEFORE INSERT ON Matriculas
FOR EACH ROW
BEGIN
    DECLARE idade_aluno INT;

    SELECT YEAR(NEW.Data_matricula) - YEAR(Aluno.Data_nascimento) INTO idade_aluno
    FROM Aluno
    WHERE Aluno.ID = NEW.ID_Aluno;


    IF idade_aluno < NEW.Aluno.Serie THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O aluno não atende aos requisitos de idade para a série.';
    END IF;
END;
//
DELIMITER ;

insert into Aluno(Nome,Data_nascimento,Serie)
values('Maria', '2010-01-01', 5);

insert into Matriculas(ID_Aluno,Data_matricula,Status)
values(1, '2023-01-01', 'Ativa');

select * from Aluno;

drop database tigger;
