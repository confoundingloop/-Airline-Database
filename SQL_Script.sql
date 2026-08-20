-- MySQL Reverse Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-------------------------------------------------------
``sql
CREATE SCHEMA IF NOT EXISTS `mydb`
  DEFAULT CHARACTER SET utf8;

USE `mydb`;

CREATE TABLE IF NOT EXISTS `Airline` (
  `AirlineID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AirlineID`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Airport` (
  `IATACode` VARCHAR(5) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IATACode`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Flight` (
  `FlightNumber` VARCHAR(20) NOT NULL,
  `DepartureAirportID` VARCHAR(5) NOT NULL,
  `ArrivalAirportID` VARCHAR(5) NOT NULL,
  `AirlineID` INT NOT NULL,
  `DepartureDateTime` DATETIME NOT NULL,
  `ArrivalDateTime` DATETIME NOT NULL,
  `DurationinMinutes` INT NOT NULL,
  `DurationinMiles` VARCHAR(45) NOT NULL,

  PRIMARY KEY (`FlightNumber`),

  INDEX `DepartureAirportID_idx` (`DepartureAirportID`),
  INDEX `ArrivalAirportID_idx` (`ArrivalAirportID`),
  INDEX `AirlineID_idx` (`AirlineID`),

  CONSTRAINT `fk_Flight_DepartureAirport`
    FOREIGN KEY (`DepartureAirportID`)
    REFERENCES `Airport` (`IATACode`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,

  CONSTRAINT `fk_Flight_ArrivalAirport`
    FOREIGN KEY (`ArrivalAirportID`)
    REFERENCES `Airport` (`IATACode`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,

  CONSTRAINT `fk_Flight_Airline`
    FOREIGN KEY (`AirlineID`)
    REFERENCES `Airline` (`AirlineID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Passenger` (
  `PassengerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PassengerID`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Ticket` (
  `TicketNumber` VARCHAR(20) NOT NULL,
  `FlightNumber` VARCHAR(20) NOT NULL,
  `PassengerID` INT NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  `ConfirmationNumber` VARCHAR(45) NOT NULL,

  PRIMARY KEY (`TicketNumber`),

  INDEX `FlightNumber_idx` (`FlightNumber`),
  INDEX `PassengerID_idx` (`PassengerID`),

  CONSTRAINT `fk_Ticket_Flight`
    FOREIGN KEY (`FlightNumber`)
    REFERENCES `Flight` (`FlightNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_Ticket_Passenger`
    FOREIGN KEY (`PassengerID`)
    REFERENCES `Passenger` (`PassengerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;
```

