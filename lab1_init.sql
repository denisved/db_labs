-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Vedernikov
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Vedernikov
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Vedernikov` DEFAULT CHARACTER SET utf8 ;
USE `Vedernikov` ;

-- -----------------------------------------------------
-- Table `Vedernikov`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`City` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vedernikov`.`Stadium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`Stadium` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `City_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`id`, `City_id`),
  INDEX `fk_Stadium_City1_idx` (`City_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_Stadium_City1`
    FOREIGN KEY (`City_id`)
    REFERENCES `Vedernikov`.`City` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vedernikov`.`Match`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`Match` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Stadium_id` INT NOT NULL,
  `winner` VARCHAR(45) NULL,
  `loser` VARCHAR(45) NULL,
  `draw` TINYINT NULL,
  `final_score` VARCHAR(5) NOT NULL,
  `goals_total` INT NOT NULL,
  `red_cards` INT NOT NULL,
  `yellow_cards` INT NOT NULL,
  `number_of_replacements` INT NOT NULL,
  `number_of_fouls` INT NOT NULL,
  `number_of_offsides` INT NOT NULL,
  `number_of_corners` INT NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `Stadium_id`),
  INDEX `fk_Match_Stadium1_idx` (`Stadium_id` ASC) VISIBLE,
  CONSTRAINT `fk_Match_Stadium1`
    FOREIGN KEY (`Stadium_id`)
    REFERENCES `Vedernikov`.`Stadium` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vedernikov`.`Main_Coach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`Main_Coach` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `salary_for_season_in_euros` INT NOT NULL,
  `start_of_contract` DATE NOT NULL,
  `end_of_contract` DATE NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vedernikov`.`Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`Team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Main_Coach_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `UPL_position` INT NOT NULL,
  `number_of_wins` INT NOT NULL,
  `number_of_loses` INT NOT NULL,
  `number_of_draws` INT NOT NULL,
  `number_of_points` INT NOT NULL,
  PRIMARY KEY (`id`, `Main_Coach_id`),
  INDEX `fk_Team_Main_Coach1_idx` (`Main_Coach_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `Main_Coach_id_UNIQUE` (`Main_Coach_id` ASC) VISIBLE,
  UNIQUE INDEX `UPL_position_UNIQUE` (`UPL_position` ASC) VISIBLE,
  CONSTRAINT `fk_Team_Main_Coach1`
    FOREIGN KEY (`Main_Coach_id`)
    REFERENCES `Vedernikov`.`Main_Coach` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vedernikov`.`Player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`Player` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Team_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `positon` VARCHAR(30) NOT NULL,
  `salary_for_season_in_euros` INT NOT NULL,
  `start_of_contract` DATE NOT NULL,
  `end_of_contract` DATE NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `goals` INT NOT NULL,
  `assists` INT NOT NULL,
  PRIMARY KEY (`id`, `Team_id`),
  INDEX `fk_Player_Team1_idx` (`Team_id` ASC) VISIBLE,
  CONSTRAINT `fk_Player_Team1`
    FOREIGN KEY (`Team_id`)
    REFERENCES `Vedernikov`.`Team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vedernikov`.`Sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`Sponsor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `start_of_contract` DATE NOT NULL,
  `end_of_contract` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vedernikov`.`Referee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`Referee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Match_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `Match_id`),
  INDEX `fk_Referee_Match1_idx` (`Match_id` ASC) VISIBLE,
  CONSTRAINT `fk_Referee_Match1`
    FOREIGN KEY (`Match_id`)
    REFERENCES `Vedernikov`.`Match` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vedernikov`.`Team_has_Sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`Team_has_Sponsor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Team_id` INT NOT NULL,
  `Sponsor_id` INT NOT NULL,
  INDEX `fk_Team_has_Sponsor_Sponsor1_idx` (`Sponsor_id` ASC) VISIBLE,
  INDEX `fk_Team_has_Sponsor_Team1_idx` (`Team_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Team_has_Sponsor_Team1`
    FOREIGN KEY (`Team_id`)
    REFERENCES `Vedernikov`.`Team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Team_has_Sponsor_Sponsor1`
    FOREIGN KEY (`Sponsor_id`)
    REFERENCES `Vedernikov`.`Sponsor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vedernikov`.`Match_has_Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vedernikov`.`Match_has_Team` (
  `Match_id` INT NOT NULL,
  `Team_id` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_Match_has_Team_Team1_idx` (`Team_id` ASC) VISIBLE,
  INDEX `fk_Match_has_Team_Match1_idx` (`Match_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Match_has_Team_Match1`
    FOREIGN KEY (`Match_id`)
    REFERENCES `Vedernikov`.`Match` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Match_has_Team_Team1`
    FOREIGN KEY (`Team_id`)
    REFERENCES `Vedernikov`.`Team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
