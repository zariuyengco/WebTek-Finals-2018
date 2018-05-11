-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 11, 2018 at 03:12 PM
-- Server version: 5.7.21
-- PHP Version: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cargo database`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `adminID` int(6) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  PRIMARY KEY (`adminID`)
) ENGINE=InnoDB AUTO_INCREMENT=215506 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminID`, `firstName`, `lastName`) VALUES
(215405, 'Mitchelle', 'Buen'),
(215505, 'Graeham', 'Solis');

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
CREATE TABLE IF NOT EXISTS `car` (
  `carID` int(6) NOT NULL AUTO_INCREMENT,
  `brandCar` enum('Toyota','Nissan','Chevrolet','Hyundai','Honda','Ford','Kia','Mazda','Mitsubishi') CHARACTER SET utf8 NOT NULL,
  `typeCar` enum('Sedan','Van','Pick Up','SUV','MUV / MPV','Hatchback','Crossover','Coupe') CHARACTER SET utf8 NOT NULL,
  `yearCar` year(4) NOT NULL,
  `numSeat` int(2) NOT NULL,
  `modelCar` varchar(30) CHARACTER SET utf8 NOT NULL,
  `mileage` double NOT NULL,
  `transmission` enum('Manual','Automatic','') CHARACTER SET utf8 NOT NULL,
  `rate` int(10) NOT NULL,
  `carStatus` enum('Available','Rented','Under Repair') NOT NULL,
  PRIMARY KEY (`carID`)
) ENGINE=InnoDB AUTO_INCREMENT=1251 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`carID`, `brandCar`, `typeCar`, `yearCar`, `numSeat`, `modelCar`, `mileage`, `transmission`, `rate`, `carStatus`) VALUES
(1230, 'Hyundai', 'Van', 2016, 9, 'Starex', 4000, 'Automatic', 3500, 'Available'),
(1231, 'Toyota', 'Van', 2017, 9, 'Hiace', 3500, 'Manual', 3000, 'Available'),
(1232, 'Toyota', 'Van', 2016, 9, 'Grandria', 2500, 'Automatic', 2500, 'Available'),
(1234, 'Toyota', 'MUV / MPV', 2016, 5, 'Camry', 2500, 'Automatic', 2000, 'Rented'),
(1235, 'Toyota', 'Coupe', 2017, 5, 'Vios 1.3', 3000, 'Manual', 2000, 'Rented'),
(1236, 'Toyota', 'Coupe', 2012, 5, 'Altis', 4000, 'Automatic', 1000, 'Rented'),
(1238, 'Toyota', 'SUV', 2013, 5, 'Innova', 1900, 'Automatic', 1500, 'Available'),
(1239, 'Toyota', 'Van', 2015, 5, 'Innova', 1300, 'Manual', 1300, 'Available'),
(1250, 'Mazda', 'SUV', 2014, 6, 'new', 3500, 'Automatic', 2000, 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `custID` int(6) NOT NULL,
  `firstName` varchar(30) CHARACTER SET utf8 NOT NULL,
  `lastName` varchar(30) CHARACTER SET utf8 NOT NULL,
  `address` varchar(50) CHARACTER SET utf8 NOT NULL,
  `email` varchar(30) CHARACTER SET utf8 NOT NULL,
  `contactNo` varchar(11) CHARACTER SET utf8 NOT NULL,
  `license` varchar(13) CHARACTER SET utf8 NOT NULL,
  `birthDate` date NOT NULL,
  PRIMARY KEY (`custID`),
  UNIQUE KEY `EMAIL` (`email`),
  UNIQUE KEY `CONTACTNO` (`contactNo`) USING BTREE,
  UNIQUE KEY `LICENSE` (`license`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`custID`, `firstName`, `lastName`, `address`, `email`, `contactNo`, `license`, `birthDate`) VALUES
(216305, 'Shaira', 'Bautista', '#098 Nama, Pozorrubio, Pangasinan', 'sharandre@gmail,com', '09059167644', 'D06-11-009385', '1999-03-16'),
(216405, 'Alessandra', 'Ramos', 'Villamor Manzano Street Zone 5 Bangued, Abra', '2165457@slu.edu.ph', '09350478888', 'M02-04-004237', '1999-02-15'),
(216505, 'Zari', 'Uyengco', 'St.1Madapdap Resettlement, Mabalacat City,Pampanga', 'zar.Uy@gmail.com', '09214578622', 'L02-0G1-00030', '1997-01-14'),
(216605, 'Sean', 'Sahagun', '#15 Purok 7, Navy Base, Baguio City', 'sean.pogi@gmail.com', '09212256287', 'G06-07-003901', '1997-02-15');

-- --------------------------------------------------------

--
-- Table structure for table `paymentdetails`
--

DROP TABLE IF EXISTS `paymentdetails`;
CREATE TABLE IF NOT EXISTS `paymentdetails` (
  `payID` int(6) NOT NULL AUTO_INCREMENT,
  `transID` int(6) NOT NULL,
  `payDate` date NOT NULL,
  `totalAmount` decimal(8,2) NOT NULL,
  `paidAmount` decimal(8,2) NOT NULL,
  `miscFee` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`payID`),
  UNIQUE KEY `transID` (`transID`)
) ENGINE=InnoDB AUTO_INCREMENT=301012 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paymentdetails`
--

INSERT INTO `paymentdetails` (`payID`, `transID`, `payDate`, `totalAmount`, `paidAmount`, `miscFee`) VALUES
(301010, 203010, '2018-05-10', '4000.00', '2500.00', '0.00'),
(301011, 203020, '2018-05-17', '1300.00', '1300.00', '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `resID` int(6) NOT NULL AUTO_INCREMENT,
  `custID` int(6) NOT NULL,
  `spID` int(6) NOT NULL,
  `carID` int(6) NOT NULL,
  `resStatus` enum('Ongoing','Pending') NOT NULL DEFAULT 'Pending',
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `purpose` enum('Vacation','Business','Everyday Use','') NOT NULL,
  `reservedDate` timestamp NOT NULL,
  PRIMARY KEY (`resID`),
  UNIQUE KEY `custID` (`custID`),
  UNIQUE KEY `spID` (`spID`),
  UNIQUE KEY `carID` (`carID`)
) ENGINE=InnoDB AUTO_INCREMENT=102041 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`resID`, `custID`, `spID`, `carID`, `resStatus`, `startDate`, `endDate`, `purpose`, `reservedDate`) VALUES
(102010, 216305, 215105, 1230, 'Ongoing', '2018-05-13 09:00:00', '2018-05-16 09:00:00', 'Vacation', '2018-05-10 03:00:00'),
(102020, 216405, 215205, 1239, 'Ongoing', '2018-05-20 10:00:00', '2018-05-26 10:00:00', 'Business', '2018-05-15 17:00:00'),
(102040, 216505, 215305, 1232, 'Ongoing', '2018-06-01 01:00:00', '2018-06-11 01:00:00', 'Everyday Use', '2018-05-29 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `service_provider`
--

DROP TABLE IF EXISTS `service_provider`;
CREATE TABLE IF NOT EXISTS `service_provider` (
  `spID` int(6) NOT NULL,
  `firstName` varchar(30) CHARACTER SET utf8 NOT NULL,
  `lastName` varchar(30) CHARACTER SET utf8 NOT NULL,
  `email` varchar(30) CHARACTER SET utf8 NOT NULL,
  `contactNo` varchar(11) CHARACTER SET utf8 NOT NULL,
  `birthDate` date NOT NULL,
  PRIMARY KEY (`spID`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `contactNo` (`contactNo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service_provider`
--

INSERT INTO `service_provider` (`spID`, `firstName`, `lastName`, `email`, `contactNo`, `birthDate`) VALUES
(215105, 'Kyla', 'Alunday', 'Kylala@gmail.com', '09854678132', '1998-08-03'),
(215205, 'Julie', 'Cruz', 'Julii@gmail.com', '09765445678', '1997-08-21'),
(215305, 'Riechel', 'Fabrigas', 'achel.gel@gmail.com', '09295200241', '1996-12-22');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
  `transID` int(6) NOT NULL AUTO_INCREMENT,
  `resID` int(6) NOT NULL,
  `timeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payStatus` enum('Paid','Partial Paid','Unpaid','') CHARACTER SET utf8 NOT NULL,
  `transStatus` enum('Approved','Denied','Cancelled','') NOT NULL,
  PRIMARY KEY (`transID`),
  UNIQUE KEY `resID` (`resID`)
) ENGINE=InnoDB AUTO_INCREMENT=203031 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transID`, `resID`, `timeStamp`, `payStatus`, `transStatus`) VALUES
(203010, 102010, '2018-05-10 03:45:10', 'Partial Paid', 'Approved'),
(203020, 102020, '2018-05-16 17:00:00', 'Paid', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userID` int(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(15) CHARACTER SET utf8 NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 NOT NULL,
  `userType` enum('Administrator','Customer','Service Provider','') CHARACTER SET utf8 NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `USERNAME` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=216606 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `username`, `password`, `userType`, `status`) VALUES
(215105, 'Kylala', '1234KKA', 'Service Provider', 1),
(215205, 'Juliee', '1235JAC', 'Service Provider', 0),
(215305, 'Acheline', '1236RAF', 'Service Provider', 0),
(215405, 'Mmitchie', '1237MMB', 'Administrator', 0),
(215505, 'Graevity', '1238GS', 'Administrator', 0),
(216305, 'Shaii', '1334SMB', 'Customer', 1),
(216405, 'Alexx', '1344ANR', 'Customer', 1),
(216505, 'Zarii', '1354ZU', 'Customer', 1),
(216605, 'Ssean', '1364SWS', 'Customer', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`adminID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`custID`) REFERENCES `users` (`userID`);

--
-- Constraints for table `paymentdetails`
--
ALTER TABLE `paymentdetails`
  ADD CONSTRAINT `paymentdetails_ibfk_1` FOREIGN KEY (`transID`) REFERENCES `transaction` (`transID`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`custID`) REFERENCES `customer` (`custID`),
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`carID`) REFERENCES `car` (`carID`),
  ADD CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`spID`) REFERENCES `service_provider` (`spID`);

--
-- Constraints for table `service_provider`
--
ALTER TABLE `service_provider`
  ADD CONSTRAINT `service_provider_ibfk_1` FOREIGN KEY (`spID`) REFERENCES `users` (`userID`) ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`resID`) REFERENCES `reservation` (`resID`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
