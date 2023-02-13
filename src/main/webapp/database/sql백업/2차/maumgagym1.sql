-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.11-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- gym 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `gym` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci */;
USE `gym`;

-- 테이블 gym.admin 구조 내보내기
CREATE TABLE IF NOT EXISTS `admin` (
  `seq` int(11) NOT NULL,
  `id` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.admin:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;

-- 테이블 gym.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `category_seq` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` text DEFAULT NULL,
  `write_seq` int(11) NOT NULL,
  `write_date` datetime NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_category_TO_board_1` (`category_seq`),
  KEY `FK_member_TO_board_1` (`write_seq`),
  CONSTRAINT `FK_category_TO_board_1` FOREIGN KEY (`category_seq`) REFERENCES `category` (`seq`),
  CONSTRAINT `FK_member_TO_board_1` FOREIGN KEY (`write_seq`) REFERENCES `member` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.board:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 gym.board_delete 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_delete` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `delete_date` datetime NOT NULL,
  `board_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_board_TO_board_delete_1` (`board_seq`),
  CONSTRAINT `FK_board_TO_board_delete_1` FOREIGN KEY (`board_seq`) REFERENCES `board` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.board_delete:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board_delete` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_delete` ENABLE KEYS */;

-- 테이블 gym.board_modify 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_modify` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `modify_date` datetime NOT NULL,
  `board_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_board_TO_board_modify_1` (`board_seq`),
  CONSTRAINT `FK_board_TO_board_modify_1` FOREIGN KEY (`board_seq`) REFERENCES `board` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.board_modify:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board_modify` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_modify` ENABLE KEYS */;

-- 테이블 gym.cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `membership_seq` int(11) NOT NULL,
  `member_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_membership_TO_cart_1` (`membership_seq`),
  KEY `FK_member_TO_cart_1` (`member_seq`),
  CONSTRAINT `FK_member_TO_cart_1` FOREIGN KEY (`member_seq`) REFERENCES `member` (`seq`),
  CONSTRAINT `FK_membership_TO_cart_1` FOREIGN KEY (`membership_seq`) REFERENCES `membership` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.cart:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

-- 테이블 gym.category 구조 내보내기
CREATE TABLE IF NOT EXISTS `category` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(20) NOT NULL,
  `topic` varchar(20) NOT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.category:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- 테이블 gym.comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `comment` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `writer_seq` int(11) NOT NULL,
  `write_date` datetime NOT NULL,
  `status` int(1) NOT NULL,
  `board_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_member_TO_comment_1` (`writer_seq`),
  KEY `FK_board_TO_comment_1` (`board_seq`),
  CONSTRAINT `FK_board_TO_comment_1` FOREIGN KEY (`board_seq`) REFERENCES `board` (`seq`),
  CONSTRAINT `FK_member_TO_comment_1` FOREIGN KEY (`writer_seq`) REFERENCES `member` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.comment:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;

-- 테이블 gym.comment_delete 구조 내보내기
CREATE TABLE IF NOT EXISTS `comment_delete` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `delete_date` datetime NOT NULL,
  `comment_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_comment_TO_comment_delete_1` (`comment_seq`),
  CONSTRAINT `FK_comment_TO_comment_delete_1` FOREIGN KEY (`comment_seq`) REFERENCES `comment` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.comment_delete:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `comment_delete` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_delete` ENABLE KEYS */;

-- 테이블 gym.comment_modify 구조 내보내기
CREATE TABLE IF NOT EXISTS `comment_modify` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `modify_date` datetime NOT NULL,
  `comment_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_comment_TO_comment_modify_1` (`comment_seq`),
  CONSTRAINT `FK_comment_TO_comment_modify_1` FOREIGN KEY (`comment_seq`) REFERENCES `comment` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.comment_modify:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `comment_modify` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_modify` ENABLE KEYS */;

-- 테이블 gym.image 구조 내보내기
CREATE TABLE IF NOT EXISTS `image` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `size` int(11) NOT NULL,
  `board_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_board_TO_image_1` (`board_seq`),
  CONSTRAINT `FK_board_TO_image_1` FOREIGN KEY (`board_seq`) REFERENCES `board` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.image:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
/*!40000 ALTER TABLE `image` ENABLE KEYS */;

-- 테이블 gym.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(100) DEFAULT NULL,
  `id` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(1000) DEFAULT NULL,
  `type` varchar(1) DEFAULT NULL,
  `zipcode` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `fulladdress` varchar(200) DEFAULT NULL,
  `referaddress` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.member:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
/*!40000 ALTER TABLE `member` ENABLE KEYS */;

-- 테이블 gym.membership 구조 내보내기
CREATE TABLE IF NOT EXISTS `membership` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `member_seq` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `period` int(2) NOT NULL,
  `board_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_member_TO_membership_1` (`member_seq`),
  KEY `FK_board_TO_membership_1` (`board_seq`),
  CONSTRAINT `FK_board_TO_membership_1` FOREIGN KEY (`board_seq`) REFERENCES `board` (`seq`),
  CONSTRAINT `FK_member_TO_membership_1` FOREIGN KEY (`member_seq`) REFERENCES `member` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.membership:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership` ENABLE KEYS */;

-- 테이블 gym.membership_hold 구조 내보내기
CREATE TABLE IF NOT EXISTS `membership_hold` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `hold_date` datetime NOT NULL,
  `hold_end_date` datetime DEFAULT NULL,
  `hold_sum_date` int(11) DEFAULT NULL,
  `register_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_membership_register_TO_membership_hold_1` (`register_seq`),
  CONSTRAINT `FK_membership_register_TO_membership_hold_1` FOREIGN KEY (`register_seq`) REFERENCES `membership_register` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.membership_hold:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `membership_hold` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_hold` ENABLE KEYS */;

-- 테이블 gym.membership_register 구조 내보내기
CREATE TABLE IF NOT EXISTS `membership_register` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `register_date` datetime DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `status` int(1) NOT NULL,
  `merchant_uid` varchar(100) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_pay_TO_membership_register_1` (`merchant_uid`),
  CONSTRAINT `FK_pay_TO_membership_register_1` FOREIGN KEY (`merchant_uid`) REFERENCES `pay` (`merchant_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.membership_register:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `membership_register` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_register` ENABLE KEYS */;

-- 테이블 gym.member_login_log 구조 내보내기
CREATE TABLE IF NOT EXISTS `member_login_log` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL,
  `member_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_member_TO_member_login_log_1` (`member_seq`),
  CONSTRAINT `FK_member_TO_member_login_log_1` FOREIGN KEY (`member_seq`) REFERENCES `member` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.member_login_log:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `member_login_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_login_log` ENABLE KEYS */;

-- 테이블 gym.news 구조 내보내기
CREATE TABLE IF NOT EXISTS `news` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `req_member_seq` int(11) NOT NULL,
  `req_date` datetime NOT NULL,
  `type` int(11) NOT NULL,
  `read_check` char(1) NOT NULL,
  `view_check` char(1) NOT NULL,
  `board_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_member_TO_news_1` (`req_member_seq`),
  KEY `FK_board_TO_news_1` (`board_seq`),
  CONSTRAINT `FK_board_TO_news_1` FOREIGN KEY (`board_seq`) REFERENCES `board` (`seq`),
  CONSTRAINT `FK_member_TO_news_1` FOREIGN KEY (`req_member_seq`) REFERENCES `member` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.news:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;

-- 테이블 gym.pay 구조 내보내기
CREATE TABLE IF NOT EXISTS `pay` (
  `merchant_uid` varchar(100) NOT NULL,
  `membership_seq` int(11) NOT NULL,
  `type` varchar(30) NOT NULL,
  `imp_uid` varchar(30) NOT NULL,
  `status` int(1) NOT NULL,
  `pay_date` datetime NOT NULL,
  `member_seq` int(11) NOT NULL,
  PRIMARY KEY (`merchant_uid`),
  KEY `FK_membership_TO_pay_1` (`membership_seq`),
  KEY `FK_member_TO_pay_1` (`member_seq`),
  CONSTRAINT `FK_member_TO_pay_1` FOREIGN KEY (`member_seq`) REFERENCES `member` (`seq`),
  CONSTRAINT `FK_membership_TO_pay_1` FOREIGN KEY (`membership_seq`) REFERENCES `membership` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.pay:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pay` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay` ENABLE KEYS */;

-- 테이블 gym.reaction 구조 내보내기
CREATE TABLE IF NOT EXISTS `reaction` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `view_count` int(11) NOT NULL,
  `like_count` int(11) NOT NULL,
  `board_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_board_TO_reaction_1` (`board_seq`),
  CONSTRAINT `FK_board_TO_reaction_1` FOREIGN KEY (`board_seq`) REFERENCES `board` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.reaction:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `reaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `reaction` ENABLE KEYS */;

-- 테이블 gym.review 구조 내보내기
CREATE TABLE IF NOT EXISTS `review` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `write_date` datetime NOT NULL,
  `writer_seq` int(11) NOT NULL,
  `star_score` float(2,1) NOT NULL,
  `status` int(1) NOT NULL,
  `board_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_member_TO_review_1` (`writer_seq`),
  KEY `FK_board_TO_review_1` (`board_seq`),
  CONSTRAINT `FK_board_TO_review_1` FOREIGN KEY (`board_seq`) REFERENCES `board` (`seq`),
  CONSTRAINT `FK_member_TO_review_1` FOREIGN KEY (`writer_seq`) REFERENCES `member` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.review:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;

-- 테이블 gym.tag 구조 내보내기
CREATE TABLE IF NOT EXISTS `tag` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(100) NOT NULL,
  `board_seq` int(11) NOT NULL,
  PRIMARY KEY (`seq`),
  KEY `FK_board_TO_tag_1` (`board_seq`),
  CONSTRAINT `FK_board_TO_tag_1` FOREIGN KEY (`board_seq`) REFERENCES `board` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- 테이블 데이터 gym.tag:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
