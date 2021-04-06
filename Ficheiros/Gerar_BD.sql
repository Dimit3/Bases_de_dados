-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema UminhoTransportes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema UminhoTransportes
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `uminhotransportes`;
CREATE SCHEMA IF NOT EXISTS `UminhoTransportes` DEFAULT CHARACTER SET utf8 ;
USE `UminhoTransportes` ;

-- -----------------------------------------------------
-- Table `UminhoTransportes`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UminhoTransportes`.`Funcionario` (
  `id` INT NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `Telemovel` CHAR(9) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UminhoTransportes`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UminhoTransportes`.`Cliente` (
  `NIF` CHAR(9) NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Cod_Postal` CHAR(8) NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NIF`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UminhoTransportes`.`Encomenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UminhoTransportes`.`Encomenda` (
  `id` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `DataEncomenda` DATE NOT NULL,
  `DataEntrega` DATE NULL,
  `Taxa` DECIMAL(8,2) NOT NULL,
  `Peso` DECIMAL(8,2) NOT NULL,
  `Conteudo` VARCHAR(45) NULL,
  `LocalEntrega` VARCHAR(45) NOT NULL,
  `TipoPagamento` VARCHAR(45) NOT NULL,
  `Urgente` BIT(1) NOT NULL,
  `ValorFatura` DECIMAL(8,2) NOT NULL,
  `DataFatura` DATE NOT NULL,
  `funcionario_id` INT NOT NULL,
  `cliente_id` CHAR(9) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Encomendas_Funcionario1_idx` (`funcionario_id` ASC) VISIBLE,
  INDEX `fk_Encomendas_Cliente1_idx` (`cliente_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Encomendas_Funcionario1`
    FOREIGN KEY (`funcionario_id`)
    REFERENCES `UminhoTransportes`.`Funcionario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Encomendas_Cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `UminhoTransportes`.`Cliente` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UminhoTransportes`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UminhoTransportes`.`Veiculo` (
  `Matricula` CHAR(8) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `AnoFabrico` YEAR(4) NOT NULL,
  `Observacoes` TEXT ,
  PRIMARY KEY (`Matricula`),
  UNIQUE INDEX `Matricula_UNIQUE` (`Matricula` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UminhoTransportes`.`Contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UminhoTransportes`.`Contacto` (
  `Numero` CHAR(9) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `cliente_id` CHAR(9) NOT NULL,
  PRIMARY KEY (`Numero`),
  INDEX `fk_Contacto_Cliente1_idx` (`cliente_id` ASC) VISIBLE,
  UNIQUE INDEX `Numero_UNIQUE` (`Numero` ASC) VISIBLE,
  CONSTRAINT `fk_Contacto_Cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `UminhoTransportes`.`Cliente` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UminhoTransportes`.`Utiliza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UminhoTransportes`.`Utiliza` (
  `id_Encomenda` INT NOT NULL,
  `Matricula_Veiculo` VARCHAR(8) NOT NULL,
  INDEX `fk_Utiliza_Veiculo1_idx` (`Matricula_Veiculo` ASC) VISIBLE,
  PRIMARY KEY (`id_Encomenda`, `Matricula_Veiculo`),
  CONSTRAINT `fk_Utiliza_Encomendas1`
    FOREIGN KEY (`id_Encomenda`)
    REFERENCES `UminhoTransportes`.`Encomenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Utiliza_Veiculo1`
    FOREIGN KEY (`Matricula_Veiculo`)
    REFERENCES `UminhoTransportes`.`Veiculo` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
