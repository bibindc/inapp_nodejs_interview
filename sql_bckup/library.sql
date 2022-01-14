-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 14, 2022 at 07:22 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `book_name` varchar(200) NOT NULL,
  `book_auther` varchar(100) DEFAULT NULL,
  `book_description` text DEFAULT NULL,
  `book_publishedby` varchar(100) DEFAULT NULL,
  `book_addedon` datetime NOT NULL DEFAULT current_timestamp(),
  `book_updatedon` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `book_name`, `book_auther`, `book_description`, `book_publishedby`, `book_addedon`, `book_updatedon`) VALUES
(1, 'wings of fire', 'apj abdul kalam', 'auto biography of apj abdul kalam', 'ck publishicaations', '2022-01-14 17:20:30', '2022-01-14 17:20:30'),
(2, 'harry potter', 'jk rowling', 'fantacy', 'jk publishicaations', '2022-01-14 20:28:48', '2022-01-14 20:28:48'),
(3, 'the god of small things', 'arundhati roy', 'novel', 'ar publishicaations', '2022-01-14 23:32:35', '2022-01-14 23:32:35');

-- --------------------------------------------------------

--
-- Table structure for table `log_request`
--

CREATE TABLE `log_request` (
  `log_id` int(11) NOT NULL,
  `log_url` varchar(200) NOT NULL,
  `log_raw_header` text NOT NULL,
  `log_remote_address` varchar(200) NOT NULL,
  `log_http_version` varchar(10) NOT NULL,
  `log_remote_family` varchar(50) NOT NULL,
  `log_req_method` varchar(10) NOT NULL,
  `log_req_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_request`
--

INSERT INTO `log_request` (`log_id`, `log_url`, `log_raw_header`, `log_remote_address`, `log_http_version`, `log_remote_family`, `log_req_method`, `log_req_date`) VALUES
(1, '/books', 'Content-Type,application/json,User-Agent,PostmanRuntime/7.28.4,Accept,*/*,Postman-Token,d8ac0b12-afcf-4f4b-a621-2a805aecad65,Host,127.0.0.1:3000,Accept-Encoding,gzip, deflate, br,Connection,keep-alive,Content-Length,87', '::ffff:127.0.0.1', '1.1', 'IPv6', 'GET', '2022-01-14 21:49:03'),
(2, '/books', 'Content-Type,application/json,User-Agent,PostmanRuntime/7.28.4,Accept,*/*,Cache-Control,no-cache,Postman-Token,ba68960b-68e2-4311-b80f-4ea11533de3b,Host,127.0.0.1:3000,Accept-Encoding,gzip, deflate, br,Connection,keep-alive,Content-Length,87', '::ffff:127.0.0.1', '1.1', 'IPv6', 'GET', '2022-01-14 23:28:48'),
(3, '/auth_user', 'Content-Type,application/json,User-Agent,PostmanRuntime/7.28.4,Accept,*/*,Cache-Control,no-cache,Postman-Token,702ed115-08d9-43d8-adc7-e1d909766e9d,Host,127.0.0.1:3000,Accept-Encoding,gzip, deflate, br,Connection,keep-alive,Content-Length,60', '::ffff:127.0.0.1', '1.1', 'IPv6', 'POST', '2022-01-14 23:29:20'),
(4, '/new_book', 'Authorization,Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6ImJpYmkiLCJpYXQiOjE2NDIxODMxNjEsImV4cCI6MTY0MjE4Mzc2MX0.tXhK_wiaQiG5iLpJVl-Vfendp8oShat-HuJm2VC-Lmo,Content-Type,application/json,User-Agent,PostmanRuntime/7.28.4,Accept,*/*,Cache-Control,no-cache,Postman-Token,74643c85-1535-45cc-a1dc-b170bb51fa1f,Host,127.0.0.1:3000,Accept-Encoding,gzip, deflate, br,Connection,keep-alive,Content-Length,163', '::ffff:127.0.0.1', '1.1', 'IPv6', 'POST', '2022-01-14 23:32:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_password` varchar(200) NOT NULL,
  `user_displayname` varchar(50) NOT NULL,
  `user_status` int(11) NOT NULL DEFAULT 1 COMMENT '1. Active 2. Blocked'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_password`, `user_displayname`, `user_status`) VALUES
(1, 'bibin', '18acfcc3da942abae464939676974dc8', 'bibi', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `log_request`
--
ALTER TABLE `log_request`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `log_request`
--
ALTER TABLE `log_request`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
