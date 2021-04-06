Use `uminhotransportes`;

DELIMITER $$
CREATE PROCEDURE `insereFuncionario` (IN id INT , IN nome VARCHAR(50) , IN telemovel CHAR(9))
BEGIN
	INSERT INTO funcionario ( id , Nome , Telemovel)
    VALUES ( id , nome , telemovel);
END $$

DELIMITER $$
CREATE PROCEDURE `insereVeiculo` (IN matricula CHAR(8) , IN marca VARCHAR(45) , IN modelo VARCHAR(45) , IN ano YEAR ,  IN obs TEXT)
BEGIN
	INSERT INTO veiculo ( Matricula,  Marca , Modelo , AnoFabrico , Observacoes)
    VALUES ( matricula,  marca , modelo , ano , obs);
END $$

DELIMITER $$
CREATE PROCEDURE `insereCliente` (IN id INT , IN nome VARCHAR(50) , IN email CHAR(45), IN codp CHAR(8) , IN loc VARCHAR(45) , IN rua VARCHAR(45))
BEGIN
	INSERT INTO cliente  (NIF, Nome, Email, Cod_Postal, Localidade, Rua)
    VALUES (id , nome, email, codp , loc , rua);
END $$

DELIMITER $$
CREATE PROCEDURE `insereContacto` (IN num CHAR(9) , IN tipo VARCHAR(45) , IN cliente_id CHAR(9))
BEGIN
	INSERT INTO contacto ( Numero , Tipo , cliente_id)
    VALUES (num , tipo, cliente_id);
END $$

DELIMITER $$
CREATE PROCEDURE `insereEncomenda` (IN id INT,IN Estado VARCHAR(45),IN DataEncomenda DATE,IN DataEntrega DATE,IN Taxa DECIMAL(8,2),IN Peso DECIMAL(8,2),IN Conteudo VARCHAR(45),IN LocalEntrega VARCHAR(45), IN TipoPagamento VARCHAR(45),IN  Urgente BIT(1),IN ValorFatura DECIMAL(8,2),IN DataFatura DATE,IN funcionario_id INT, IN cliente_id CHAR(9))
BEGIN
INSERT INTO encomenda (id , Estado , DataEncomenda , DataEntrega , Taxa , Peso , Conteudo , LocalEntrega , TipoPagamento , Urgente , ValorFatura , DataFatura , funcionario_id , cliente_id)
    VALUES (id , Estado , DataEncomenda , DataEntrega , Taxa , Peso , Conteudo , LocalEntrega , TipoPagamento , Urgente , ValorFatura , DataFatura , funcionario_id , cliente_id);
END $$

DELIMITER $$
CREATE PROCEDURE `insereUtiliza` (IN id_enc INT , IN matricula VARCHAR(8))
BEGIN
INSERT INTO utiliza ( id_Encomenda , Matricula_Veiculo )
    VALUES (id_enc , matricula);
END $$

DELIMITER $$
CREATE FUNCTION calculaValor(peso INTEGER, taxa float, urgencia BIT ) RETURNS float
  DETERMINISTIC NO SQL READS SQL DATA
  BEGIN
    DECLARE i INT DEFAULT peso * taxa;
    RETURN IF(urgencia, i * 1.20, i);
END$$
DELIMITER ;



call insereCliente('123456789' , 'Luís Marques', 'luismarques@gmail.com' , '4750-123' , 'Braga' , 'Rua das Pedras');
call insereCliente('123456790' , 'Paulo Costa', 'paulocostinha@gmail.com' , '4745-247' , 'Guimarães' , 'Rua S.Tiago Candoso');
call insereCliente('123456791' , 'Daniel Ribeiro', 'danydimitri@gmail.com' , '4745-765' , 'Barcelos' , 'Rua da Cantoria');
call insereCliente('123456792' , 'André Araújo', null , '4745-765' , 'Barcelos' , 'Rua da Cantoria');
call insereCliente('123456793' , 'Carlos Ferreira' , null , '4745-767' , 'Barcelos' , 'Rua Barcelense');
call insereCliente('123456794' , 'Maria Teixeira', 'mariajoao@hotmail.com' , '4843-432' , 'Famalicão' , 'Rua do Estádio');
call insereCliente('123456795' , 'Ana Silva', 'anasilivia@gmail.com' , '4785-247' , 'Fafe' , 'Rua Aqui Não Fanfa');
call insereCliente('123456796' , 'Castro Diogo', 'dioguinho2008@gmail.com' , '4745-769' , 'Póvoa de Varzim' , 'Rua da Ventosa');
call insereCliente('123456797' , 'Célia Cardoso', null , '4575-765' , 'Amarante' , 'Rua do D. Infante Amaro');
call insereCliente('123456798' , 'Paula Ribeiro' , null , '4743-767' , 'Braga' , 'Rua D. Diogo');

-- DELETE FROM Cliente;
-- SELECT * FROM Cliente;


call insereFuncionario(1,'Jose Carlos','933000123');
call insereFuncionario(2,'Rafael Costa','912456870');
call insereFuncionario(3,'Ana Castro','963933666');
call insereFuncionario(4,'Joana Gomes','923123555');
call insereFuncionario(5,'Tiago Silva','934512000');
call insereFuncionario(6,'Filipe Faria','918309377');

-- DELETE FROM funcionario;
-- SELECT * FROM funcionario;  


call insereContacto	('912345678','Telemovel','123456789');
call insereContacto	('253441098','Telefone','123456790');
call insereContacto	('253679765','Telefone','123456791');
call insereContacto	('929292929','Telemovel','123456791');
call insereContacto	('912305463','Telemovel','123456792');
call insereContacto	('253111536','Telefone','123456792');
call insereContacto	('253444555','Telefone','123456793');
call insereContacto	('911441111','Telemovel','123456794');
call insereContacto	('933366633','Telemovel','123456795');
call insereContacto	('253854123','Telefone','123456796');
call insereContacto	('253667302','Telefone','123456797');
call insereContacto	('912345645','Telemovel','123456798');

-- DELETE FROM contacto;
-- SELECT * FROM contacto;


call insereVeiculo('35-22-ZV','Opel','Corsa','2006',null);
call insereVeiculo('30-VX-53','Ford','Transit','2018',null);
call insereVeiculo('50-PD-70','Renault','Midlum','2010',null);
call insereVeiculo('ZA-50-53','Toyota','Yaris','2001','Carro não está nas melhores condições');
call insereVeiculo('66-22-AA', 'Audi', 'A4', '2002', 'Como Novo');
call insereVeiculo('55-BP-12','Fiat','Stilo','2008',null);   

-- DELETE FROM veiculo;
-- SELECT * FROM veiculo;

-- entregas pedidas a 30 / 11 / 2020
call insereEncomenda( 1 , 'Pedida' , '2020/11/30' , null , 20 , 3 , null , 'Rua das Pedras' , 'Ainda não pago' , 0 , calculaValor(20,3,0) ,'2020/11/30',1 , '123456789' );
call insereEncomenda( 2 , 'Pedida' , '2020/11/30' , null , 40 , 7 , null , ' Rua das Pedras' , 'Ainda não pago' , 0 , calculaValor(40,7,0) ,'2020/11/30' , 2 , '123456789' ); 
call insereEncomenda( 3 , 'Pedida' , '2020/11/30' , null , 30 , 3 , null , ' Rua da Cantoria' , 'Ainda não pago' , 0 ,calculaValor(30,3,0) , '2020/11/30',3 , '123456791' );
call insereEncomenda( 4 , 'Paga' , '2020/11/30' , null , 50 , 20 , null , ' Rua da Cantoria', 'Trasnferência bancaria' , 0 , calculaValor(50,20,0) ,'2020/11/30' , 4 ,'123456792' );
call insereEncomenda( 5 , 'Paga' , '2020/11/30' , null , 20 , 8 , null , 'Rua Barcelense' , 'Trasnferência bancaria' , 0 , calculaValor(20,8,0) ,'2020/11/30' , 5 , '123456793' );
call insereEncomenda( 6 , 'Paga' , '2020/11/30' , null , 25 , 10 , null , 'Rua do Estádio' , 'Trasnferência bancaria' , 0 ,calculaValor(25,10,0) ,'2020/11/30' ,6 , '123456794' );
call insereEncomenda( 7 , 'Paga' , '2020/11/30' , null , 10 , 30 , null , 'Rua Aqui Não Fanfa' , 'Trasnferência bancaria' , 0 ,calculaValor(10,30,0) ,'2020/11/30', 1 , '123456795' );
call insereEncomenda( 8 , 'Paga' , '2020/11/30' , null , 20 , 10 , '10KG comida cão' , 'Rua da Ventosa' , 'Trasnferência bancaria' , 0 ,calculaValor(20,10,0) ,'2020/11/30', 2 , '123456796' );

-- entregas pedidas a 29 / 11 / 2020
call insereEncomenda( 9 , 'Entregue' , '2020/11/29' , '2020/11/29' , 20 , 10 , null , 'Rua do D. Infante Amaro' , 'Cartão de Crédito' , 0 , calculaValor(20,10,0),'2020/11/30', 3 , '123456797' );
call insereEncomenda( 10 , 'Entregue' , '2020/11/29' , '2020/11/29' , 25 , 20 , null , 'Rua do D. Infante Amaro' , 'Dinheiro' , 0 ,calculaValor(25,20,0),'2020/11/30' , 4 , '123456797' );
call insereEncomenda( 11, 'Entregue' , '2020/11/29' , '2020/11/29' , 25 , 7 , null , 'Rua S.Tiago Candoso' , 'Dinheiro' , 0 , calculaValor(25,7,0),'2020/11/29', 5 , '123456790' ); 
call insereEncomenda( 12 , 'Entregue' , '2020/11/29' , '2020/11/29' , 42 , 30 , null , 'Rua D. Diogo' , 'Cartão de Crédito' , 0 , calculaValor(42,30,0),'2020/11/29' , 6 , '123456798' );
call insereEncomenda( 13 , 'Entregue' , '2020/11/29' , '2020/11/29' , 28 , 18 , null , 'Rua da Cantoria' , 'Dinheiro' , 0 , calculaValor(28,18,0),'2020/11/29', 1 , '123456791' ); 
call insereEncomenda( 14 , 'Entregue' , '2020/11/29' , '2020/11/29' , 30 , 23 , null , 'Rua da Cantoria' , 'Cheque' , 0 , calculaValor(30,23,0),'2020/11/29' , 2 ,  '123456792' );
call insereEncomenda( 15 , 'Entregue' , '2020/11/29' , '2020/11/30' , 70 , 1 , 'Colar de Ouro' , 'Rua Barcelense' , 'Cartão de Crédito' , 1 ,  calculaValor(70,1,0), '2020/11/30', 3 , '123456793' );
call insereEncomenda( 16, 'Entregue' , '2020/11/29' , '2020/11/29' , 16 , 5 , null , 'Rua S.Tiago Candoso' , 'Dinheiro' , 0 , calculaValor(16,5,0),'2020/11/29', 3 , '123456790' ); 
call insereEncomenda( 17 , 'Entregue' , '2020/11/29' , '2020/11/29' , 10 , 2 , null , 'Rua D. Diogo' , 'Cartão de Crédito' , 0 , calculaValor(10,2,0),'2020/11/29' , 4 , '123456798' );

-- entregas pedidas a 28 / 11 / 2020
call insereEncomenda( 18 , 'Entregue' , '2020/11/28' , '2020/11/28' , 16 , 6 , 'Medicamentos' , 'Rua da Cantoria' , 'Dinheiro' , 1 , calculaValor(16,6,1),'2020/11/28', 5 , '123456791' ); 
call insereEncomenda( 19 , 'Entregue' , '2020/11/28' , '2020/11/28' , 32 , 12 , 'Medicamentos' , 'Rua da Cantoria' , 'Cheque' , 1 , calculaValor(32,12,1),'2020/11/28' , 4 ,  '123456792' );
call insereEncomenda( 20 , 'Entregue' , '2020/11/28' , '2020/11/28' , 70 , 1 , 'Colar de Ouro' , 'Rua Barcelense' , 'Cartão de Crédito' , 1 ,  calculaValor(70,1,0), '2020/11/28', 1 , '123456793' );

-- DELETE FROM encomenda;
-- SELECT * FROM encomenda;


call insereUtiliza(1,'35-22-ZV');
call insereUtiliza(2,'30-VX-53');
call insereUtiliza(3,'35-22-ZV');
call insereUtiliza(4,'66-22-AA');
call insereUtiliza(5,'35-22-ZV');
call insereUtiliza(6,'55-BP-12');
call insereUtiliza(7,'30-VX-53');
call insereUtiliza(8,'50-PD-70');
call insereUtiliza(9,'35-22-ZV');
call insereUtiliza(10,'50-PD-70');
call insereUtiliza(11,'66-22-AA');
call insereUtiliza(12,'30-VX-53');
call insereUtiliza(13,'ZA-50-53');
call insereUtiliza(14,'35-22-ZV');
call insereUtiliza(15,'55-BP-12');
call insereUtiliza(16,'66-22-AA');
call insereUtiliza(17,'30-VX-53');
call insereUtiliza(18,'30-VX-53');
call insereUtiliza(19,'35-22-ZV');
call insereUtiliza(20,'30-VX-53');

-- DELETE FROM utiliza;
-- SELECT * FROM utiliza;