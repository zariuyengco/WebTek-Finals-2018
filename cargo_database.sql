-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 23, 2018 at 02:43 AM
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
  `carStatus` enum('Available','Rented','Under Repair') NOT NULL DEFAULT 'Available',
  `statusQuantity` int(2) NOT NULL DEFAULT '1',
  `carStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `carQuantity` int(2) NOT NULL,
  PRIMARY KEY (`carID`)
) ENGINE=InnoDB AUTO_INCREMENT=1256 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`carID`, `brandCar`, `typeCar`, `yearCar`, `numSeat`, `modelCar`, `mileage`, `transmission`, `rate`, `carStatus`, `statusQuantity`, `carStamp`, `carQuantity`) VALUES
(1230, 'Mazda', 'Sedan', 2014, 5, 'model8', 6000, 'Automatic', 1500, 'Rented', 1, '2018-05-15 06:17:42', 2),
(1231, 'Nissan', 'Van', 2013, 10, 'model1', 5000, 'Automatic', 3500, 'Available', 1, '2018-05-15 04:51:42', 1),
(1232, 'Chevrolet', 'Van', 2012, 9, 'Starex', 4000, 'Manual', 3500, 'Rented', 0, '2018-05-15 04:51:42', 1),
(1234, 'Kia', 'SUV', 2013, 6, 'model5', 5000, 'Manual', 1200, 'Rented', 0, '2018-05-15 04:51:42', 1),
(1235, 'Honda', 'Sedan', 2017, 5, 'Civic', 1200, 'Automatic', 3000, 'Available', 1, '2018-05-15 04:51:42', 1),
(1236, 'Kia', 'MUV / MPV', 2012, 9, 'model6', 3500, 'Automatic', 2000, 'Under Repair', 1, '2018-05-15 04:51:42', 1),
(1238, 'Ford', 'Sedan', 2012, 9, 'model7', 4000, 'Manual', 3500, 'Available', 1, '2018-05-15 04:51:42', 1),
(1239, 'Nissan', 'SUV', 2013, 7, 'model9', 2000, 'Automatic', 2000, 'Rented', 0, '2018-05-15 04:51:42', 1),
(1250, 'Mitsubishi', 'SUV', 2015, 7, 'model10', 3100, 'Automatic', 2500, 'Available', 1, '2018-05-15 04:51:42', 1),
(1251, 'Honda', 'SUV', 2015, 7, 'model11', 5000, 'Automatic', 2000, 'Under Repair', 1, '2018-05-15 09:22:59', 2),
(1252, 'Nissan', 'Sedan', 2015, 5, 'Sentra', 15000, 'Manual', 1399, 'Available', 1, '2018-05-17 09:40:05', 1),
(1253, 'Mazda', 'Hatchback', 2013, 5, 'Mazda 2', 20000, 'Automatic', 1000, 'Available', 2, '2018-05-17 09:42:34', 2),
(1254, 'Toyota', 'Sedan', 2012, 5, 'asda', 20000, 'Automatic', 2000, 'Rented', 0, '2018-05-22 18:33:12', 1),
(1255, 'Hyundai', 'Van', 2015, 9, 'sdasd', 13000, 'Automatic', 2000, 'Rented', 0, '2018-05-23 02:40:19', 1);

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
  `age` int(2) NOT NULL,
  PRIMARY KEY (`custID`),
  UNIQUE KEY `EMAIL` (`email`),
  UNIQUE KEY `CONTACTNO` (`contactNo`) USING BTREE,
  UNIQUE KEY `LICENSE` (`license`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`custID`, `firstName`, `lastName`, `address`, `email`, `contactNo`, `license`, `birthDate`, `age`) VALUES
(215303, 'wyatt', 'cute', '69 purok 11 city camp ', 'wyatt@gwapoako.com', '09273450892', 'G05-01-003901', '1965-09-13', 53),
(216305, 'Shaira', 'Bautista', '#098 Nama, Pozorrubio, Pangasinan', 'sharandre@gmail,com', '09059167644', 'D06-11-009385', '1999-03-16', 18),
(216405, 'Alessandra', 'Ramos', 'Villamor Manzano Street Zone 5 Bangued, Abra', '2165457@slu.edu.ph', '09350478888', 'M02-04-004237', '1999-02-15', 19),
(216505, 'Zari', 'Uyengco', 'St.1Madapdap Resettlement, Mabalacat City,Pampanga', 'zar.Uy@gmail.com', '09214578622', 'L02-0G1-00030', '1997-01-14', 20),
(216605, 'Sean', 'Sahagun', '#15 Purok 7, Navy Base, Baguio City', 'sean.pogi@gmail.com', '09212256287', 'G06-07-003901', '1997-02-15', 21);

-- --------------------------------------------------------

--
-- Table structure for table `paymentdetails`
--

DROP TABLE IF EXISTS `paymentdetails`;
CREATE TABLE IF NOT EXISTS `paymentdetails` (
  `payID` int(6) NOT NULL AUTO_INCREMENT,
  `transID` int(6) NOT NULL,
  `payDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `totalAmount` int(15) NOT NULL,
  `paidAmount` int(15) NOT NULL,
  `miscFee` int(15) DEFAULT NULL,
  PRIMARY KEY (`payID`),
  UNIQUE KEY `transID` (`transID`)
) ENGINE=InnoDB AUTO_INCREMENT=301030 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paymentdetails`
--

INSERT INTO `paymentdetails` (`payID`, `transID`, `payDate`, `totalAmount`, `paidAmount`, `miscFee`) VALUES
(301029, 203069, '2018-05-23 02:38:50', 12000, 13000, 1000);

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
  `resStatus` enum('Ongoing','Pending','Denied','Done','Accepted') NOT NULL DEFAULT 'Pending',
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `purpose` enum('Vacation','Business','Everyday Use','') NOT NULL,
  `reservedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`resID`),
  UNIQUE KEY `custID` (`custID`) USING BTREE,
  KEY `spID` (`spID`) USING BTREE,
  KEY `carID` (`carID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=102051 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`resID`, `custID`, `spID`, `carID`, `resStatus`, `startDate`, `endDate`, `purpose`, `reservedDate`) VALUES
(102010, 216305, 215105, 1230, 'Denied', '2018-05-13 09:00:00', '2018-05-16 08:00:00', 'Vacation', '2018-05-10 03:00:00'),
(102020, 216405, 215205, 1239, 'Done', '2018-05-20 14:00:00', '2018-05-26 11:00:00', 'Business', '2018-05-15 17:00:00'),
(102030, 216605, 215105, 1232, 'Pending', '2018-05-16 11:00:00', '2018-05-24 14:00:00', 'Vacation', '2018-05-12 10:24:18'),
(102040, 216505, 215305, 1232, 'Pending', '2018-06-01 12:00:00', '2018-06-11 16:00:00', 'Everyday Use', '2018-05-29 00:00:00'),
(102050, 215303, 215305, 1239, 'Pending', '2018-05-30 12:00:00', '2018-05-31 15:00:00', 'Business', '2018-05-15 09:20:26');

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
  PRIMARY KEY (`spID`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `contactNo` (`contactNo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service_provider`
--

INSERT INTO `service_provider` (`spID`, `firstName`, `lastName`, `email`, `contactNo`) VALUES
(215105, 'Kyla', 'Cardenas', 'Kylala@gmail.com', '09854678132'),
(215205, 'Julie', 'Cruz', 'Julii@gmail.com', '09765445678'),
(215305, 'Riechel', 'Fabrigas', 'achel.gel@gmail.com', '09295200241'),
(216611, 'wyatts', 'Cardenas', 'kyla.kate@gmail.com', '01923123013'),
(216618, 'shobe', 'shobs', 'shobe@email.com', '09275689023'),
(216619, 'kyla', 'kyla', 'kiiayla@gmail.com', '09283576981');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
  `transID` int(6) NOT NULL AUTO_INCREMENT,
  `resID` int(6) NOT NULL,
  `timeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transStatus` enum('Partially Paid','Fully Paid') NOT NULL,
  PRIMARY KEY (`transID`),
  UNIQUE KEY `resID` (`resID`)
) ENGINE=InnoDB AUTO_INCREMENT=203070 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transID`, `resID`, `timeStamp`, `transStatus`) VALUES
(203069, 102020, '2018-05-23 02:38:50', 'Fully Paid');

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
  `status` enum('Activate','Deactivate') NOT NULL DEFAULT 'Activate',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `USERNAME` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=216620 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `username`, `password`, `userType`, `status`) VALUES
(215105, 'Kylala', '1234KKA', 'Service Provider', 'Activate'),
(215205, 'Juliee', '1235JAC', 'Service Provider', 'Deactivate'),
(215303, 'wyattski', 'hallo', 'Customer', 'Activate'),
(215305, 'Acheline', '1236RAF', 'Service Provider', 'Activate'),
(215405, 'Mmitchie', '1237MMB', 'Administrator', 'Activate'),
(215505, 'Graevity', '1238GS', 'Administrator', 'Activate'),
(216305, 'Shaii', '1334SMB', 'Customer', 'Activate'),
(216405, 'Alexx', '1344ANR', 'Customer', 'Activate'),
(216505, 'Zarii', '1354ZU', 'Customer', 'Activate'),
(216605, 'Ssean', '1364SWS', 'Customer', 'Activate'),
(216611, 'wyatt', 'password', 'Service Provider', 'Activate'),
(216618, 'shobe', '123456', 'Service Provider', 'Activate'),
(216619, 'kiiayla', 'hahaha', 'Service Provider', 'Activate');

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
  ADD CONSTRAINT `paymentdetails_ibfk_1` FOREIGN KEY (`transID`) REFERENCES `transaction` (`transID`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`resID`) REFERENCES `reservation` (`resID`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
