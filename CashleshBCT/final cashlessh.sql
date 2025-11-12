-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.19


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema cashless_india_bct
--

CREATE DATABASE IF NOT EXISTS cashless_india_bct;
USE cashless_india_bct;

--
-- Definition of table `setpassword`
--

DROP TABLE IF EXISTS `setpassword`;
CREATE TABLE `setpassword` (
  `UserName` varchar(500) NOT NULL,
  `imageName` varchar(200) DEFAULT NULL,
  `password` varchar(200) NOT NULL,
  PRIMARY KEY (`UserName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `setpassword`
--

/*!40000 ALTER TABLE `setpassword` DISABLE KEYS */;
/*!40000 ALTER TABLE `setpassword` ENABLE KEYS */;


--
-- Definition of table `tbl_account_details`
--

DROP TABLE IF EXISTS `tbl_account_details`;
CREATE TABLE `tbl_account_details` (
  `account_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_holder` varchar(200) NOT NULL,
  `bank_name` varchar(200) NOT NULL,
  `bank_id` varchar(200) NOT NULL,
  `account_no` varchar(200) NOT NULL,
  `balance` double NOT NULL DEFAULT '0',
  `bank_address` varchar(200) NOT NULL,
  `account_status` varchar(200) NOT NULL DEFAULT 'Deactive',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_account_details`
--

/*!40000 ALTER TABLE `tbl_account_details` DISABLE KEYS */;
INSERT INTO `tbl_account_details` (`account_id`,`account_holder`,`bank_name`,`bank_id`,`account_no`,`balance`,`bank_address`,`account_status`) VALUES 
 (1,'Tvm28qbrghegz+F/hVZfQEdmrM1L/qh7qEofYZ37GMc=','Xc6LeSPJcisq87XjC8lNCQ==','Fk7uPLAjyQa+jXRCCfYHmkKF+/lK8Rg8hJyzu9c1kjw=','azcJpUmXSWpvM4sOBhSimw==',10000,'Vb+2wL9c043F4KLD2UMkEw==','Active');
/*!40000 ALTER TABLE `tbl_account_details` ENABLE KEYS */;


--
-- Definition of table `tbl_beneficiary`
--

DROP TABLE IF EXISTS `tbl_beneficiary`;
CREATE TABLE `tbl_beneficiary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_email` varchar(200) NOT NULL,
  `account_holder` varchar(200) NOT NULL,
  `holder_address` varchar(200) NOT NULL,
  `account_no` varchar(200) NOT NULL,
  `ifsc_code` varchar(200) NOT NULL,
  `beneficiary_status` varchar(200) NOT NULL,
  `account_type` varchar(200) NOT NULL,
  `beneficiary_email` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_beneficiary`
--

/*!40000 ALTER TABLE `tbl_beneficiary` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_beneficiary` ENABLE KEYS */;


--
-- Definition of table `tbl_blockchain`
--

DROP TABLE IF EXISTS `tbl_blockchain`;
CREATE TABLE `tbl_blockchain` (
  `sr` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` varchar(200) NOT NULL,
  `receiver_id` varchar(200) NOT NULL,
  `amount` varchar(200) NOT NULL,
  `prev_hash` varchar(500) NOT NULL,
  `current_hash` varchar(500) NOT NULL,
  `transaction_date` varchar(200) NOT NULL DEFAULT 'success',
  `status` varchar(200) NOT NULL DEFAULT 'success',
  `account_no` varchar(200) NOT NULL DEFAULT 'xxxxxxxx',
  `transaction_id` varchar(200) NOT NULL,
  PRIMARY KEY (`sr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_blockchain`
--

/*!40000 ALTER TABLE `tbl_blockchain` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_blockchain` ENABLE KEYS */;


--
-- Definition of table `tbl_users`
--

DROP TABLE IF EXISTS `tbl_users`;
CREATE TABLE `tbl_users` (
  `sr` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usertype` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `address` text NOT NULL,
  `mobile` varchar(200) NOT NULL,
  `name` text NOT NULL,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '1',
  `status` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`sr`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_users`
--

/*!40000 ALTER TABLE `tbl_users` DISABLE KEYS */;
INSERT INTO `tbl_users` (`sr`,`usertype`,`email`,`password`,`address`,`mobile`,`name`,`parent_id`,`status`) VALUES 
 (1,'0iSFVgzMKQeN+uDp/+xYmg==','3IwEw3UEdDUIYYTinGOLlA==','oNwE0+0t9iffxn5N+wY6eA==','F25M5q/RmWAIdL3Y9xN3VQ==','ffDfTzXPrcbZXvJq4A5QpQ==','xuY/fqH2vEthaLAGD2wbIg==',1,0),
 (2,'zaDq6CuKMByJfO6ygYBkkg==','Fk7uPLAjyQa+jXRCCfYHmkKF+/lK8Rg8hJyzu9c1kjw=','SoG6le9E6sMFhlNreVzNjQ==','Vb+2wL9c043F4KLD2UMkEw==','ffDfTzXPrcbZXvJq4A5QpQ==','Xc6LeSPJcisq87XjC8lNCQ==',1,0),
 (3,'zaDq6CuKMByJfO6ygYBkkg==','Dz3mhDlUaaF4oh3TX6ms8g==','Me7+SCkz+npxeou7BGIR6w==','Vb+2wL9c043F4KLD2UMkEw==','+/7QjlLL0gqP8oFjQwbfNA==','4mSLJIPn7C5prCEsPk/pTuDxLGB7agAKEMztxJ9RGJQ=',1,0),
 (4,'cY2u53Nlgz1YhMO7hbTINg==','Tvm28qbrghegz+F/hVZfQEdmrM1L/qh7qEofYZ37GMc=','sM4GVNIwPmNxPXDdRWYbAg==','OX4Pv2SWK50DMQduF2IDIg==','ffDfTzXPrcbZXvJq4A5QpQ==','6tXHVxNbRoqfquiw9dmJYg==',1,0);
/*!40000 ALTER TABLE `tbl_users` ENABLE KEYS */;


--
-- Definition of table `tbl_usertype`
--

DROP TABLE IF EXISTS `tbl_usertype`;
CREATE TABLE `tbl_usertype` (
  `sr` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` varchar(45) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sr`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_usertype`
--

/*!40000 ALTER TABLE `tbl_usertype` DISABLE KEYS */;
INSERT INTO `tbl_usertype` (`sr`,`user_type`,`user_id`) VALUES 
 (1,'Admin',1),
 (2,'Bank',2),
 (3,'Customer',3);
/*!40000 ALTER TABLE `tbl_usertype` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
