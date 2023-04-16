CREATE TABLE produto (codigo NUMBER(4), preco NUMBER(7,2));

CREATE TABLE valor_produto (codigo NUMBER(4),
valor_anterior NUMBER(7,2), valor_atual NUMBER(7,2));

CREATE OR REPLACE TRIGGER verifica_valor
BEFORE UPDATE OF preco ON produto
FOR EACH ROW
BEGIN


INSERT INTO valor_produto VALUES
(:OLD.codigo, :OLD.preco, :NEW.preco);
END;


INSERT INTO produto VALUES(1,'20,54');
INSERT INTO produto VALUES(2,'32,66');
INSERT INTO produto VALUES (3,'58,99');

UPDATE produto set preco = '40,44' WHERE codigo =3; 
SELECT * FROM valor_produto;

alter table valor_produto ADD (usuario  VARCHAR(30),data_trans DATE);

CREATE OR REPLACE TRIGGER verifica_valor
BEFORE UPDATE OF preco ON produto
FOR EACH ROW
BEGIN
INSERT INTO valor_produto VALUES
(:OLD.codigo,:OLD.preco,:NEW.preco,user,sysdate);
END;