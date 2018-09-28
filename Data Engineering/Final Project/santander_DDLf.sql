-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Schema santander
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `santander` DEFAULT CHARACTER SET latin1 ;
USE `santander` ;

-- -----------------------------------------------------
-- Table `santander`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `santander`.`customer` (
  `customer_id` INT(20) NOT NULL,
  `gender` VARCHAR(20) NOT NULL,
  `foreign_cntr` CHAR(20) NULL DEFAULT NULL,
  `join_channel` VARCHAR(45) NULL DEFAULT NULL,
  `first_join` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `santander`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `santander`.`product` (
  `product_id` SMALLINT(5) NOT NULL,
  `product` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `santander`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `santander`.`province` (
  `province_id` SMALLINT(5) NOT NULL,
  `province` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`province_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `santander`.`segment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `santander`.`segment` (
  `segment_id` SMALLINT(5) NOT NULL,
  `segment` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`segment_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `santander`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `santander`.`transaction` (
  `transaction_id` INT(20) NOT NULL,
  `date` DATE NOT NULL,
  `customer_id` INT(20) NOT NULL,
  `product_id` SMALLINT(5) NOT NULL,
  `age` SMALLINT(3) NULL,
  `senior_mo` SMALLINT(5) NULL,
  `rel_type` VARCHAR(20) NULL,
  `gross_house_inc` INT(20) NULL,
  `segment_id` SMALLINT(5) NOT NULL,
  `province_id` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `fk_transaction_customer1_idx` (`customer_id` ASC),
  INDEX `fk_transaction_product1_idx` (`product_id` ASC),
  INDEX `fk_transaction_segment1_idx` (`segment_id` ASC),
  INDEX `fk_transaction_province1_idx` (`province_id` ASC),
  CONSTRAINT `fk_transaction_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `santander`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `santander`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_segment1`
    FOREIGN KEY (`segment_id`)
    REFERENCES `santander`.`segment` (`segment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_province1`
    FOREIGN KEY (`province_id`)
    REFERENCES `santander`.`province` (`province_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `santander`.`stdata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `santander`.`stdata` (
  `date` DATE NOT NULL,
  `customer_id` INT(20) NOT NULL,
  `gender` VARCHAR(45) NULL,
  `age` SMALLINT(3) NULL,
  `first_join` VARCHAR(45) NULL,
  `senior_mo` SMALLINT(5) NULL,
  `activeness` VARCHAR(45) NULL,
  `foreign_citizen` VARCHAR(45) NULL,
  `join_channel` VARCHAR(45) NULL,
  `province_id` SMALLINT(5) NULL,
  `province` VARCHAR(45) NULL,
  `gross_house_inc` FLOAT NULL,
  `segment_id` SMALLINT(3) NULL,
  `cus_segment` VARCHAR(45) NULL,
  PRIMARY KEY (`date`, `customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `santander`.`sttransaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `santander`.`sttransaction` (
  `transaction_id` INT(20) NOT NULL,
  `date` DATE NULL,
  `customer_id` INT(20) NULL,
  `product_id` SMALLINT(5) NULL,
  PRIMARY KEY (`transaction_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
