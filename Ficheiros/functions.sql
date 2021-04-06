Use `uminhotransportes`;

-- Visualizar clientes

SELECT * FROM cliente;

-- Visualizar funcionarios

SELECT * FROM funcionario;

-- Visualisar contactos dos clientes

SELECT * FROM contacto order by contacto.cliente_id;

-- Visualizar encomendas

SELECT * FROM encomenda;

-- Visualisar veiculos

SELECT * FROM veiculo;

-- Visualizar tabela utiliza

SELECT * FROM utiliza ORDER BY 1;

-- contacto com nome do cliente

SELECT 
    cliente.Nome, contacto.Numero
FROM
    cliente
        INNER JOIN
    contacto
ON
    cliente.NIF = contacto.cliente_id
ORDER BY cliente.Nome;


DELIMITER $$
CREATE PROCEDURE `encomendasDeCliente` (IN nif CHAR(9))
BEGIN
	SELECT * FROM encomenda
    WHERE encomenda.cliente_id=nif;
    
END $$

DELIMITER $$
CREATE PROCEDURE `encomendasEntreguesPorFuncionario` (IN idFuncionario INT , IN dataInicial DATE , IN dataFinal DATE)
BEGIN
	SELECT * FROM encomenda
    WHERE encomenda.funcionario_id=idFuncionario
    AND encomenda.Estado='Entregue'
    AND dataInicial <= encomenda.DataEntrega
    AND dataFinal >= encomenda.DataEntrega;
END $$

DELIMITER $$
CREATE PROCEDURE `valorPendenteCliente` (IN nif CHAR(9))
BEGIN
	SELECT cliente.NIF,cliente.Nome,sum(encomenda.ValorFatura) AS 'Valor Pendente' FROM cliente
		INNER JOIN encomenda
			ON encomenda.cliente_id = cliente.NIF
    WHERE encomenda.cliente_id=nif AND encomenda.Estado='Pedida';
END $$

DELIMITER $$
CREATE PROCEDURE `valorTotalCliente` (IN nif CHAR(9))
BEGIN
	SELECT cliente.NIF,cliente.Nome,sum(encomenda.ValorFatura) AS 'Valor Total' FROM cliente
		INNER JOIN encomenda
			ON encomenda.cliente_id = cliente.NIF
    WHERE encomenda.cliente_id=nif;
END $$

DELIMITER $$
CREATE PROCEDURE `contactoCliente` (IN nif CHAR(9))
BEGIN
	SELECT cliente.NIF , cliente.Nome , contacto.Numero AS 'Numero do cliente' FROM contacto
    INNER JOIN cliente ON contacto.cliente_id=cliente.nif
    WHERE contacto.cliente_id=nif;
END $$

DELIMITER $$
CREATE PROCEDURE `contactoFuncionario` (IN id INT)
BEGIN
	SELECT funcionario.id AS 'Nr funcionario' , funcionario.Nome , funcionario.Telemovel AS 'Numero do funcionario' FROM funcionario
    WHERE funcionario.id=id;
END $$

DELIMITER $$
CREATE PROCEDURE `mediaTaxa` ()
BEGIN
	SELECT AVG(encomenda.taxa) AS 'Media de Taxa' FROM encomenda;
END $$

DELIMITER $$
CREATE PROCEDURE `mediaPeso` ()
BEGIN
	SELECT AVG(encomenda.peso) AS 'Media de Peso' FROM encomenda;
END $$

DELIMITER $$
CREATE PROCEDURE `dadosFatura` (IN id INT)
BEGIN
	SELECT encomenda.id , encomenda.ValorFatura , encomenda.DataFatura FROM encomenda
    WHERE encomenda.id=id;
END $$

DELIMITER $$
CREATE PROCEDURE `top3Clientes` ()
BEGIN
	SELECT cliente.NIF , cliente.Nome , sum(encomenda.ValorFatura) AS 'Valor Gasto' FROM cliente
	INNER JOIN encomenda
	ON cliente.NIF = encomenda.cliente_id
	GROUP BY cliente.NIF
	ORDER BY 3 DESC , 2
	LIMIT 3;
END $$

CREATE PROCEDURE `desempenhoDosFuncionariosNoDia` (IN dia DATE)
BEGIN
	SELECT encomenda.funcionario_id  , count(*) AS NrEntregas ,  sum(encomenda.ValorFatura) AS ValorFaturado FROM encomenda
	INNER JOIN funcionario
	ON encomenda.funcionario_id=funcionario.id
    WHERE encomenda.DataEntrega = dia
	GROUP BY encomenda.funcionario_id
	ORDER BY 1;
END $$

CREATE PROCEDURE `utilizacaoVeiculos` ()
BEGIN
	SELECT veiculo.Matricula  , count(*) AS NrEntregas FROM utiliza
	INNER JOIN veiculo
	ON veiculo.Matricula = utiliza.Matricula_Veiculo
	GROUP BY veiculo.Matricula
	ORDER BY 2 DESC;
END $$








-- call encomendasDeCliente ('123456789');
-- call encomendasDeCliente ('123456790');
-- call encomendasDeCliente ('123456791');
-- call encomendasDeCliente ('123456792');
-- call encomendasDeCliente ('123456793');
-- call encomendasDeCliente ('123456794');
-- call encomendasDeCliente ('123456795');
-- call encomendasDeCliente ('123456796');
-- call encomendasDeCliente ('123456797');
call encomendasDeCliente ('123456798');


call encomendasEntreguesPorFuncionario(3 , '2020-11-30' , '2020-11-30');
call encomendasEntreguesPorFuncionario(1 , '2020-11-29' , '2020-11-30');

call valorTotalCliente ('123456791');

call valorPendenteCliente('123456789');
-- call valorPendenteCliente('123456790');
-- call valorPendenteCliente('123456791');

call contactoCliente ('123456789');
call contactoFuncionario ( 2 );
call mediaTaxa();
call mediaPeso();
call dadosFatura(2);
call top3Clientes();
call desempenhoDosFuncionariosNoDia('2020-11-29');
call utilizacaoVeiculos();