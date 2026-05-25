-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Focus
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Focus
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Focus` DEFAULT CHARACTER SET utf8 ;
USE `Focus` ;

-- -----------------------------------------------------
-- Table `Focus`.`Semestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Semestre` (
  `id_sem` INT NOT NULL AUTO_INCREMENT,
  `nom_sem` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_sem`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Estudiante` (
  `id_est` INT NOT NULL AUTO_INCREMENT,
  `nom_est` VARCHAR(45) NOT NULL,
  `con_est` VARCHAR(45) NOT NULL,
  `pun_est` INT NOT NULL,
  `id_sem` INT NOT NULL,
  `correo_est` VARCHAR(45) NOT NULL,
  `fec_nac` VARCHAR(45) NULL,
  PRIMARY KEY (`id_est`),
  INDEX `fk_Estudiante_Semestre_idx` (`id_sem` ASC) VISIBLE,
  CONSTRAINT `fk_Estudiante_Semestre`
    FOREIGN KEY (`id_sem`)
    REFERENCES `Focus`.`Semestre` (`id_sem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Parcial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Parcial` (
  `id_par` INT NOT NULL AUTO_INCREMENT,
  `num_par` VARCHAR(45) NOT NULL,
  `id_sem` INT NOT NULL,
  PRIMARY KEY (`id_par`),
  INDEX `fk_Parcial_Semestre1_idx` (`id_sem` ASC) VISIBLE,
  CONSTRAINT `fk_Parcial_Semestre1`
    FOREIGN KEY (`id_sem`)
    REFERENCES `Focus`.`Semestre` (`id_sem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Materia` (
  `id_mat` INT NOT NULL,
  `nom_mat` VARCHAR(45) NOT NULL,
  `id_par` INT NOT NULL,
  PRIMARY KEY (`id_mat`),
  INDEX `fk_Materia_Parcial1_idx` (`id_par` ASC) VISIBLE,
  CONSTRAINT `fk_Materia_Parcial1`
    FOREIGN KEY (`id_par`)
    REFERENCES `Focus`.`Parcial` (`id_par`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Tema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Tema` (
  `id_tem` INT NOT NULL AUTO_INCREMENT,
  `tit_tem` VARCHAR(45) NOT NULL,
  `int_tem` VARCHAR(45) NOT NULL,
  `exp_tem` VARCHAR(45) NOT NULL,
  `ima_tem` VARCHAR(45) NOT NULL,
  `id_mat` INT NOT NULL,
  PRIMARY KEY (`id_tem`),
  INDEX `fk_Tema_Materia1_idx` (`id_mat` ASC) VISIBLE,
  CONSTRAINT `fk_Tema_Materia1`
    FOREIGN KEY (`id_mat`)
    REFERENCES `Focus`.`Materia` (`id_mat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Cuestionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Cuestionario` (
  `id_cue` INT NOT NULL AUTO_INCREMENT,
  `dif_cue` VARCHAR(45) NOT NULL,
  `id_tem` INT NOT NULL,
  PRIMARY KEY (`id_cue`),
  INDEX `fk_Cuestionario_Tema1_idx` (`id_tem` ASC) VISIBLE,
  CONSTRAINT `fk_Cuestionario_Tema1`
    FOREIGN KEY (`id_tem`)
    REFERENCES `Focus`.`Tema` (`id_tem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Calificacion` (
  `id_cal` INT NOT NULL AUTO_INCREMENT,
  `cal` INT NOT NULL,
  `id_cue` INT NOT NULL,
  `id_est` INT NOT NULL,
  PRIMARY KEY (`id_cal`),
  INDEX `fk_Calificacion_Cuestionario1_idx` (`id_cue` ASC) VISIBLE,
  INDEX `fk_Calificacion_Estudiante1_idx` (`id_est` ASC) VISIBLE,
  CONSTRAINT `fk_Calificacion_Cuestionario1`
    FOREIGN KEY (`id_cue`)
    REFERENCES `Focus`.`Cuestionario` (`id_cue`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Calificacion_Estudiante1`
    FOREIGN KEY (`id_est`)
    REFERENCES `Focus`.`Estudiante` (`id_est`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Calendario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Calendario` (
  `id_cal` INT NOT NULL AUTO_INCREMENT,
  `mes_cal` INT NOT NULL,
  `año_cal` INT NOT NULL,
  `id_est` INT NOT NULL,
  PRIMARY KEY (`id_cal`),
  INDEX `fk_Calendario_Estudiante1_idx` (`id_est` ASC) VISIBLE,
  CONSTRAINT `fk_Calendario_Estudiante1`
    FOREIGN KEY (`id_est`)
    REFERENCES `Focus`.`Estudiante` (`id_est`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Actividad` (
  `id_act` INT NOT NULL AUTO_INCREMENT,
  `nom_act` VARCHAR(45) NOT NULL,
  `des_act` VARCHAR(45) NOT NULL,
  `fec_act` VARCHAR(45) NOT NULL,
  `est_act` VARCHAR(45) NOT NULL,
  `pri_act` VARCHAR(45) NOT NULL,
  `hora_act` TIME NOT NULL,
  `pos_act` INT NOT NULL,
  `id_dia` INT NOT NULL,
  `id_cal` INT NOT NULL,
  PRIMARY KEY (`id_act`),
  INDEX `fk_Actividad_Calendario1_idx` (`id_cal` ASC) VISIBLE,
  CONSTRAINT `id_cal`
    FOREIGN KEY (`id_cal`)
    REFERENCES `Focus`.`Calendario` (`id_cal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Notificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Notificacion` (
  `id_not` INT NOT NULL AUTO_INCREMENT,
  `tip_not` VARCHAR(45) NOT NULL,
  `con_not` VARCHAR(45) NOT NULL,
  `id_act` INT NOT NULL,
  PRIMARY KEY (`id_not`),
  INDEX `fk_Notificacion_Actividad1_idx` (`id_act` ASC) VISIBLE,
  CONSTRAINT `fk_Notificacion_Actividad1`
    FOREIGN KEY (`id_act`)
    REFERENCES `Focus`.`Actividad` (`id_act`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Focus`.`Metas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Focus`.`Metas` (
  `id_met` INT NOT NULL AUTO_INCREMENT,
  `nom_met` VARCHAR(45) NOT NULL,
  `des_met` VARCHAR(45) NOT NULL,
  `id_est` INT NOT NULL,
  PRIMARY KEY (`id_met`),
  INDEX `fk_Metas_Estudiante1_idx` (`id_est` ASC) VISIBLE,
  CONSTRAINT `fk_Metas_Estudiante1`
    FOREIGN KEY (`id_est`)
    REFERENCES `Focus`.`Estudiante` (`id_est`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
