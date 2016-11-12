-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mayanreality
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mayanreality
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mayanreality` DEFAULT CHARACTER SET latin1 ;
USE `mayanreality` ;

-- -----------------------------------------------------
-- Table `mayanreality`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mayanreality`.`admin` (
  `CLAVE_ADMIN` INT(11) NOT NULL,
  `NOMBRE_ADMIN` VARCHAR(15) NULL DEFAULT NULL,
  `APELLIDO_PAT` VARCHAR(20) NULL DEFAULT NULL,
  `APELLIDO_MAT` VARCHAR(20) NULL DEFAULT NULL,
  `CORREO_ELEC` VARCHAR(80) NULL DEFAULT NULL,
  `TELEFONO` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`CLAVE_ADMIN`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mayanreality`.`eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mayanreality`.`eventos` (
  `ID_EVENTO` INT(11) NOT NULL,
  `BUSQUEDA` VARCHAR(20) NULL DEFAULT NULL,
  `UBICACION` VARCHAR(30) NULL DEFAULT NULL,
  `TIEMPO_LLEGADA` INT(20) NULL DEFAULT NULL,
  `INFADICIONAL` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_EVENTO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mayanreality`.`objeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mayanreality`.`objeto` (
  `ID_OBJ` INT(11) NOT NULL,
  `CLAVE_OBJ` INT(11) NULL DEFAULT NULL,
  `NOMBRE_OBJ` VARCHAR(30) NULL DEFAULT NULL,
  `DESCRIPCION` VARCHAR(120) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_OBJ`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mayanreality`.`eventos_has_objeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mayanreality`.`eventos_has_objeto` (
  `eventos_ID_EVENTO` INT(11) NOT NULL,
  `objeto_ID_OBJ` INT(11) NOT NULL,
  PRIMARY KEY (`eventos_ID_EVENTO`, `objeto_ID_OBJ`),
  INDEX `fk_eventos_has_objeto_objeto1_idx` (`objeto_ID_OBJ` ASC),
  INDEX `fk_eventos_has_objeto_eventos1_idx` (`eventos_ID_EVENTO` ASC),
  CONSTRAINT `fk_eventos_has_objeto_eventos1`
    FOREIGN KEY (`eventos_ID_EVENTO`)
    REFERENCES `mayanreality`.`eventos` (`ID_EVENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventos_has_objeto_objeto1`
    FOREIGN KEY (`objeto_ID_OBJ`)
    REFERENCES `mayanreality`.`objeto` (`ID_OBJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mayanreality`.`sitio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mayanreality`.`sitio` (
  `NOMBRE_SITIO` VARCHAR(50) NULL DEFAULT NULL,
  `DIRECCION` VARCHAR(100) NULL DEFAULT NULL,
  `NOMBRE_ENCARGADO` VARCHAR(50) NULL DEFAULT NULL,
  `TELEFONO_ENCARGADO` INT(11) NULL DEFAULT NULL,
  `id_sitio` INT NOT NULL,
  PRIMARY KEY (`id_sitio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mayanreality`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mayanreality`.`usuario` (
  `NUM_USUARIO` INT(11) NOT NULL,
  `NOMBRE_USUARIO` VARCHAR(30) NULL DEFAULT NULL,
  `APELLIDO_PAT` VARCHAR(20) NULL DEFAULT NULL,
  `APELLIDO_MAT` VARCHAR(20) NULL DEFAULT NULL,
  `CORREO_ELEC` VARCHAR(80) NULL DEFAULT NULL,
  `CONTRASEÑA` VARCHAR(25) NULL DEFAULT NULL,
  `eventos_ID_EVENTO` INT(11) NOT NULL,
  PRIMARY KEY (`NUM_USUARIO`),
  INDEX `fk_usuario_eventos1_idx` (`eventos_ID_EVENTO` ASC),
  CONSTRAINT `fk_usuario_eventos1`
    FOREIGN KEY (`eventos_ID_EVENTO`)
    REFERENCES `mayanreality`.`eventos` (`ID_EVENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mayanreality`.`admin_has_sitio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mayanreality`.`admin_has_sitio` (
  `admin_CLAVE_ADMIN` INT(11) NOT NULL,
  `sitio_id_sitio` INT NOT NULL,
  PRIMARY KEY (`admin_CLAVE_ADMIN`, `sitio_id_sitio`),
  INDEX `fk_admin_has_sitio_sitio1_idx` (`sitio_id_sitio` ASC),
  INDEX `fk_admin_has_sitio_admin1_idx` (`admin_CLAVE_ADMIN` ASC),
  CONSTRAINT `fk_admin_has_sitio_admin1`
    FOREIGN KEY (`admin_CLAVE_ADMIN`)
    REFERENCES `mayanreality`.`admin` (`CLAVE_ADMIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admin_has_sitio_sitio1`
    FOREIGN KEY (`sitio_id_sitio`)
    REFERENCES `mayanreality`.`sitio` (`id_sitio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mayanreality`.`usuario_has_sitio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mayanreality`.`usuario_has_sitio` (
  `usuario_NUM_USUARIO` INT(11) NOT NULL,
  `sitio_id_sitio` INT NOT NULL,
  PRIMARY KEY (`usuario_NUM_USUARIO`, `sitio_id_sitio`),
  INDEX `fk_usuario_has_sitio_sitio1_idx` (`sitio_id_sitio` ASC),
  INDEX `fk_usuario_has_sitio_usuario1_idx` (`usuario_NUM_USUARIO` ASC),
  CONSTRAINT `fk_usuario_has_sitio_usuario1`
    FOREIGN KEY (`usuario_NUM_USUARIO`)
    REFERENCES `mayanreality`.`usuario` (`NUM_USUARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_sitio_sitio1`
    FOREIGN KEY (`sitio_id_sitio`)
    REFERENCES `mayanreality`.`sitio` (`id_sitio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mayanreality`.`sitio_has_eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mayanreality`.`sitio_has_eventos` (
  `sitio_id_sitio` INT NOT NULL,
  `eventos_ID_EVENTO` INT(11) NOT NULL,
  PRIMARY KEY (`sitio_id_sitio`, `eventos_ID_EVENTO`),
  INDEX `fk_sitio_has_eventos_eventos1_idx` (`eventos_ID_EVENTO` ASC),
  INDEX `fk_sitio_has_eventos_sitio1_idx` (`sitio_id_sitio` ASC),
  CONSTRAINT `fk_sitio_has_eventos_sitio1`
    FOREIGN KEY (`sitio_id_sitio`)
    REFERENCES `mayanreality`.`sitio` (`id_sitio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sitio_has_eventos_eventos1`
    FOREIGN KEY (`eventos_ID_EVENTO`)
    REFERENCES `mayanreality`.`eventos` (`ID_EVENTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
