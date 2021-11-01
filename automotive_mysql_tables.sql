-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`building` (
  `building_id` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`building_id`),
  UNIQUE INDEX `building_id_UNIQUE` (`building_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `pswd` VARCHAR(45) NOT NULL,
  `builidng_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `builidng_id`),
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE,
  INDEX `building_id_idx` (`builidng_id` ASC) VISIBLE,
  CONSTRAINT `building_id`
    FOREIGN KEY (`builidng_id`)
    REFERENCES `mydb`.`building` (`building_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `address_id` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `street_number` VARCHAR(45) NULL,
  `zip_code` VARCHAR(45) NULL,
  UNIQUE INDEX `address_id_UNIQUE` (`address_id` ASC) VISIBLE,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`job`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`job` (
  `job_id` INT NOT NULL,
  `job_type` VARCHAR(45) NOT NULL,
  `salary` FLOAT NULL,
  PRIMARY KEY (`job_id`),
  UNIQUE INDEX `job_id_UNIQUE` (`job_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employee_has_address` (
  `employee_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `address_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`, `address_id`),
  INDEX `address_id_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `mydb`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee_has_contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employee_has_contract` (
  `contract_expiration` DATETIME NULL,
  `employee_id_fk` INT NOT NULL,
  `job_id` INT NOT NULL,
  PRIMARY KEY (`employee_id_fk`, `job_id`),
  INDEX `job_id_idx` (`job_id` ASC) VISIBLE,
  CONSTRAINT `employee_id_fk`
    FOREIGN KEY (`employee_id_fk`)
    REFERENCES `mydb`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `job_id`
    FOREIGN KEY (`job_id`)
    REFERENCES `mydb`.`job` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customer_id` INT NOT NULL,
  `customer_f_name` VARCHAR(45) NOT NULL,
  `customer_s_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`car` (
  `car_id` INT NOT NULL,
  `car_brand` VARCHAR(45) NOT NULL,
  `car_color` VARCHAR(45) NOT NULL,
  `customer_id` INT NULL,
  UNIQUE INDEX `car_id_UNIQUE` (`car_id` ASC) VISIBLE,
  PRIMARY KEY (`car_id`, `customer_id`),
  INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`car_has_workers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`car_has_workers` (
  `car_id` INT NOT NULL,
  `employee_id_fk1` INT NOT NULL,
  `deadline` DATETIME NULL,
  PRIMARY KEY (`car_id`, `employee_id_fk1`),
  INDEX `employee_id_idx` (`employee_id_fk1` ASC) VISIBLE,
  CONSTRAINT `employee_id_fk1`
    FOREIGN KEY (`employee_id_fk1`)
    REFERENCES `mydb`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `car_id`
    FOREIGN KEY (`car_id`)
    REFERENCES `mydb`.`car` (`car_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`manager` (
  `manager_id` INT NOT NULL,
  `manager_firstname` VARCHAR(45) NOT NULL,
  `manager_surname` VARCHAR(45) NOT NULL,
  `salary` FLOAT NOT NULL,
  `building_id` INT NOT NULL,
  PRIMARY KEY (`manager_id`, `building_id`),
  UNIQUE INDEX `manager_id_UNIQUE` (`manager_id` ASC) VISIBLE,
  INDEX `buliding_id_idx` (`building_id` ASC) VISIBLE,
  CONSTRAINT `buliding_id`
    FOREIGN KEY (`building_id`)
    REFERENCES `mydb`.`building` (`building_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`car_in_builidng`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`car_in_builidng` (
  `car_id_fk` INT NOT NULL,
  `building_id_fk` INT NOT NULL,
  `parts` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`car_id_fk`, `building_id_fk`),
  INDEX `building_id_idx` (`building_id_fk` ASC) VISIBLE,
  CONSTRAINT `car_id_fk`
    FOREIGN KEY (`car_id_fk`)
    REFERENCES `mydb`.`car` (`car_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `building_id_fk`
    FOREIGN KEY (`building_id_fk`)
    REFERENCES `mydb`.`building` (`building_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`manager_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`manager_has_address` (
  `manager_id_fk` INT NOT NULL,
  `address_id_fk` INT NOT NULL,
  `address_type` VARCHAR(45) NULL,
  PRIMARY KEY (`manager_id_fk`, `address_id_fk`),
  INDEX `address_id_idx` (`address_id_fk` ASC) VISIBLE,
  CONSTRAINT `manager_id_fk`
    FOREIGN KEY (`manager_id_fk`)
    REFERENCES `mydb`.`manager` (`manager_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `address_id_fk`
    FOREIGN KEY (`address_id_fk`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contact` (
  `contact_id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(13) NOT NULL,
  `customer_id_fk1` INT NOT NULL,
  PRIMARY KEY (`contact_id`),
  INDEX `customer_id_idx` (`customer_id_fk1` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk1`
    FOREIGN KEY (`customer_id_fk1`)
    REFERENCES `mydb`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
