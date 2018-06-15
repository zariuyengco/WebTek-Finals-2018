-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 24, 2018 at 11:28 PM
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
  `email` varchar(30) NOT NULL,
  `contact` varchar(11) NOT NULL,
  PRIMARY KEY (`adminID`)
) ENGINE=InnoDB AUTO_INCREMENT=215506 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminID`, `firstName`, `lastName`, `email`, `contact`) VALUES
(215405, 'Mitchelle', 'Buen', 'mitchiebuen@gmail.com', '09276589324'),
(215505, 'Graeham', 'Solis', 'grae@gmail.com', '09356789523');

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
CREATE TABLE IF NOT EXISTS `car` (
  `carID` int(6) NOT NULL AUTO_INCREMENT,
  `spID` int(11) NOT NULL,
  `brandCar` enum('Toyota','Nissan','Chevrolet','Hyundai','Honda','Ford','Kia','Mazda','Mitsubishi') CHARACTER SET utf8 NOT NULL,
  `typeCar` enum('Sedan','Van','Pick Up','SUV','MUV / MPV','Hatchback','Crossover','Coupe') CHARACTER SET utf8 NOT NULL,
  `yearCar` year(4) NOT NULL,
  `numSeat` int(2) NOT NULL,
  `modelCar` varchar(30) CHARACTER SET utf8 NOT NULL,
  `mileage` double NOT NULL,
  `transmission` enum('Manual','Automatic','') CHARACTER SET utf8 NOT NULL,
  `rate` int(10) NOT NULL,
  `carStatus` enum('Available','Unavailable') NOT NULL DEFAULT 'Available',
  `statusQuantity` int(2) NOT NULL DEFAULT '1',
  `carStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `carQuantity` int(2) NOT NULL,
  `plateNo` varchar(7) NOT NULL,
  `image` longblob,
  PRIMARY KEY (`carID`),
  UNIQUE KEY `Unique` (`plateNo`),
  KEY `spID` (`spID`)
) ENGINE=InnoDB AUTO_INCREMENT=125007 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`carID`, `spID`, `brandCar`, `typeCar`, `yearCar`, `numSeat`, `modelCar`, `mileage`, `transmission`, `rate`, `carStatus`, `statusQuantity`, `carStamp`, `carQuantity`, `plateNo`, `image`) VALUES
(123001, 215105, 'Toyota', 'Sedan', 2012, 5, 'Camry 2.5 V', 2000, 'Automatic', 1500, 'Available', 2, '2018-05-24 13:52:40', 2, 'AAA 123', NULL),
(123002, 215105, 'Toyota', 'Sedan', 2015, 5, 'Camry 2.5 G', 2000, 'Manual', 1000, 'Unavailable', 2, '2018-05-24 14:09:25', 2, 'ABA 124', NULL),
(123003, 215105, 'Toyota', 'Hatchback', 2016, 5, 'Wigo 1.0 TRD', 2000, 'Automatic', 1500, 'Unavailable', 1, '2018-05-24 14:15:10', 1, 'ACA 125', NULL),
(123004, 215105, 'Honda', 'MUV / MPV', 2018, 7, 'New Mobilio', 1500, 'Automatic', 3000, 'Unavailable', 1, '2018-05-24 14:21:41', 1, 'ADA 126', NULL),
(123005, 215105, 'Honda', 'SUV', 2017, 7, 'All-New Cr-V', 1500, 'Automatic', 2500, 'Unavailable', 1, '2018-05-24 14:28:34', 1, 'AEA 127', NULL),
(124001, 215205, 'Hyundai', 'Van', 2014, 8, 'Grand Starex', 2000, 'Automatic', 2500, 'Unavailable', 1, '2018-05-24 14:37:38', 2, 'BBB 133', NULL),
(124002, 215205, 'Hyundai', 'Van', 2013, 8, 'Grand Starex', 2500, 'Manual', 2000, 'Available', 1, '2018-05-24 14:37:38', 2, 'BAB 134', NULL),
(124003, 215205, 'Toyota', 'Van', 2014, 11, 'Super Grandia', 4000, 'Automatic', 3000, 'Available', 1, '2018-05-24 14:48:53', 1, 'BCB 135', NULL),
(124004, 215205, 'Hyundai', 'Sedan', 2016, 5, 'Accent', 3455, 'Manual', 1500, 'Available', 1, '2018-05-24 14:52:06', 1, 'BDB 136', NULL),
(124005, 215205, 'Mazda', 'Pick Up', 2014, 5, 'Strada GL', 2000, 'Manual', 2000, 'Available', 1, '2018-05-24 15:00:50', 1, 'BEB 137', NULL),
(125001, 215305, 'Ford', 'SUV', 2017, 5, 'EcoSport', 2000, 'Automatic', 2000, 'Available', 1, '2018-05-24 15:07:13', 1, 'CCC 143', NULL),
(125002, 215305, 'Nissan', 'SUV', 2015, 8, 'PatrolRoyale', 3455, 'Automatic', 2500, 'Unavailable', 1, '2018-05-24 15:13:48', 1, 'CAC 144', NULL),
(125003, 215305, 'Nissan', 'Sedan', 2015, 5, 'Sylphy', 2500, 'Automatic', 1500, 'Unavailable', 1, '2018-05-24 15:17:24', 1, 'CBC 145', NULL),
(125004, 215305, 'Kia', 'MUV / MPV', 2015, 7, 'Sorento', 2500, 'Automatic', 2500, 'Available', 1, '2018-05-24 15:25:29', 1, 'CDC 146', NULL),
(125005, 215305, 'Kia', 'Van', 2016, 8, 'Grand Carnival', 3500, 'Automatic', 3000, 'Available', 1, '2018-05-24 15:29:04', 1, 'CEC 147', NULL),
(125006, 215105, 'Toyota', 'Sedan', 2018, 5, 'Corolla', 1200, 'Automatic', 2000, 'Available', 1, '2018-05-24 16:57:30', 2, 'DED 169', NULL);

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
(216305, 'Shaira', 'Bautista', '#098 Nama, Pozorrubio, Pangasinan', 'sharandre@gmail,com', '09059167644', 'D06-11-009385', '1999-03-16', 18),
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paymentdetails`
--

INSERT INTO `paymentdetails` (`payID`, `transID`, `payDate`, `totalAmount`, `paidAmount`, `miscFee`) VALUES
(1, 1, '2018-05-24 20:28:08', 22000, 10000, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `resID` int(6) NOT NULL AUTO_INCREMENT,
  `custID` int(6) NOT NULL,
  `carID` int(11) NOT NULL,
  `resStatus` enum('Ongoing','Pending','Denied','Done','Accepted') NOT NULL DEFAULT 'Pending',
  `startDate` varchar(30) NOT NULL,
  `endDate` varchar(30) NOT NULL,
  `purpose` enum('Vacation','Business','Everyday Use','') NOT NULL,
  `reservedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`resID`),
  UNIQUE KEY `custID` (`custID`) USING BTREE,
  KEY `carID` (`carID`)
) ENGINE=InnoDB AUTO_INCREMENT=102031 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`resID`, `custID`, `carID`, `resStatus`, `startDate`, `endDate`, `purpose`, `reservedDate`) VALUES
(102030, 216605, 125001, 'Ongoing', '2018-05-20T08:15:00', '2018-05-31T09:00:00', 'Vacation', '2018-05-24 20:25:27');

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
(216607, 'halllo', 'hiii', 'kiiayla@gmail.com', '09983481493');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transID`, `resID`, `timeStamp`, `transStatus`) VALUES
(1, 102030, '2018-05-24 20:28:08', 'Partially Paid');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userID` int(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(15) CHARACTER SET utf8 NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 NOT NULL,
  `userType` enum('Administrator','Customer','Service Provider','SuperAdmin') CHARACTER SET utf8 NOT NULL,
  `status` enum('Activated','Deactivated') NOT NULL DEFAULT 'Deactivated',
  `question` enum('What is your favorite color?','What is the name of your pet?','What is your favorite book?','What is your wifi password','What is your childhood nickname') NOT NULL,
  `answer` varchar(200) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `USERNAME` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=216608 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `username`, `password`, `userType`, `status`, `question`, `answer`) VALUES
(215105, 'Kylala', 'kkalunday', 'Service Provider', 'Activated', 'What is the name of your pet?', 'mona mona'),
(215205, 'Juliee', '1235JAC', 'Service Provider', 'Activated', 'What is your favorite color?', 'fushcia'),
(215305, 'Acheline', '1236RAF', 'Service Provider', 'Activated', 'What is the name of your pet?', 'Potchi'),
(215405, 'Mmitchie', '1237MMB', 'SuperAdmin', 'Activated', 'What is your favorite book?', 'Fifty Shades of Grae'),
(215505, 'Graevity', '1238GS', 'Administrator', 'Activated', 'What is your wifi password', 'SaglitLang'),
(216305, 'Shaii', '1334SMB', 'Customer', 'Activated', 'What is your childhood nickname', 'shai shai'),
(216505, 'Zarii', '1354ZU', 'Customer', 'Activated', 'What is your favorite color?', 'Red'),
(216605, 'Ssean', '1364SWS', 'Customer', 'Activated', 'What is the name of your pet?', 'Rambol'),
(216607, 'kiiayla', 'hahaha', 'Service Provider', 'Deactivated', 'What is your favorite color?', 'pink');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`adminID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `car_ibfk_1` FOREIGN KEY (`spID`) REFERENCES `service_provider` (`spID`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`custID`) REFERENCES `customer` (`custID`) ON DELETE NO ACTION,
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`carID`) REFERENCES `car` (`carID`) ON DELETE CASCADE ON UPDATE CASCADE;

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
