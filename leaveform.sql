-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 01, 2023 at 05:10 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `leaveform`
--

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `employee_type` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `firstname`, `lastname`, `email`, `employee_type`, `username`, `password`) VALUES
(1, 'Yasmi', 'Navodya', 'navodya@ieee.org', 'Supervisor', 'yasmi', '76d80224611fc919a5d54f0ff9fba446'),
(2, 'Ovindu', 'Jeewanga', 'ovindu@ieee.org', 'Manager', 'ovinduuu', '76d80224611fc919a5d54f0ff9fba446'),
(5, 'Ovintha', 'Sathsara', 'ovintha@gmail.com', 'Employee', 'ovintha', '76d80224611fc919a5d54f0ff9fba446'),
(6, 'Tharaka', 'Sandaruwan', 'mts.samare@gmail.com', 'Employee', 'mts', '76d80224611fc919a5d54f0ff9fba446'),
(11, 'Ureni', 'Vidunika', 'ureni@gmail.com', 'Employee', 'ureni', '76d80224611fc919a5d54f0ff9fba446');

-- --------------------------------------------------------

--
-- Table structure for table `leaverequest`
--

CREATE TABLE `leaverequest` (
  `id` int(11) NOT NULL,
  `req_date` datetime DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `leaverequest`
--

INSERT INTO `leaverequest` (`id`, `req_date`, `username`, `reason`, `start_date`, `end_date`, `status`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, NULL),
(2, NULL, 'ovintha', 'Sick', '2023-07-28', '2023-08-04', 'Approved'),
(3, NULL, 'ovintha', 'Vacation', '2023-08-05', '2023-08-12', 'Approved'),
(4, NULL, 'mts', 'Sick', '2023-07-28', '2023-07-29', 'Approved'),
(5, NULL, 'mts', 'Vacation', '2023-07-31', '2023-07-06', 'SubmittedToSupervisor'),
(6, NULL, 'mts', 'Vacation', '2023-08-01', '2023-08-08', 'SubmittedToManager'),
(7, NULL, 'mts', 'Vacation', '2023-08-01', '2023-08-15', 'DeclinedByManager'),
(8, NULL, 'mts', 'Sick', '2023-08-05', '2023-08-12', 'DeclinedBySupervisor'),
(9, NULL, 'ovintha', 'sick', '2023-07-30', '2023-08-05', 'DeclinedByManager'),
(10, NULL, 'ovintha', 'Sick', '2023-08-27', '2023-09-03', 'Approved'),
(11, NULL, 'cst19038', 'Vacation', '2023-07-31', '2023-08-05', 'SubmittedToManager'),
(12, NULL, 'cst19038', 'Vacation', '2023-07-31', '2023-08-05', 'SubmittedToManager'),
(13, NULL, 'cst19038', 'Sick', '2023-07-30', '2023-08-01', 'SubmittedToManager'),
(14, NULL, 'cst19038', 'sick', '2023-07-30', '2023-08-05', 'SubmittedToManager'),
(15, NULL, 'cst19038', 'sick', '2023-08-03', '2023-08-05', 'SubmittedToManager'),
(16, NULL, 'cst19038', 'vacation', '2023-08-05', '2023-08-12', 'SubmittedToManager'),
(17, NULL, 'cst19038', 'sick', '2023-07-31', '2023-08-03', 'DeclinedByManager'),
(18, NULL, 'mts', 'vacation', '2023-07-31', '2023-08-03', 'SubmittedToSupervisor'),
(19, NULL, 'mts', 'Vacation', '2023-07-30', '2023-08-15', 'SubmittedToSupervisor'),
(20, NULL, 'cst19038', 'Study Leave', '2023-07-31', '2023-08-01', 'SubmittedToManager'),
(21, NULL, 'cst19038', 'Sick', '2023-07-31', '2023-08-05', 'SubmittedToManager'),
(22, NULL, 'ovintha', 'Personal Matter', '2023-08-05', '2023-08-12', 'DeclinedBySupervisor'),
(23, '2023-07-31 02:02:30', 'ovintha', 'Sick', '2023-07-31', '2023-08-01', 'SubmittedToSupervisor'),
(24, '2023-07-31 10:37:31', 'ureni', 'Vacation', '2023-08-05', '2023-08-12', 'Approved'),
(25, '2023-07-31 10:38:59', 'yasmi', 'Sick', '2023-07-31', '2023-08-05', 'DeclinedByManager');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `leaverequest`
--
ALTER TABLE `leaverequest`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `leaverequest`
--
ALTER TABLE `leaverequest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
