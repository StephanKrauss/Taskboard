-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               10.1.22-MariaDB - mariadb.org binary distribution
-- Server Betriebssystem:        Win32
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Exportiere Datenbank Struktur für taskboard
CREATE DATABASE IF NOT EXISTS `taskboard` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `taskboard`;

-- Exportiere Struktur von Tabelle taskboard.activity
CREATE TABLE IF NOT EXISTS `activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `comment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timestamp` int(11) unsigned DEFAULT NULL,
  `item_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_foreignkey_activity_item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportiere Daten aus Tabelle taskboard.activity: ~7 rows (ungefähr)
DELETE FROM `activity`;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` (`id`, `comment`, `old_value`, `new_value`, `timestamp`, `item_id`) VALUES
	(1, 'admin logged in.', 'null', 'null', 1543351199, NULL),
	(2, 'admin changed their password.', '{"id":"1","username":"admin","is_admin":"1","logins":"1","last_login":"1543351199","default_board":null,"password":"admin","email":""}', '{"id":"1","username":"admin","is_admin":"1","logins":"1","last_login":"1543351199","default_board":null,"password":"stephan","email":""}', 1543351232, NULL),
	(3, 'admin changed username to stephan', '{"id":"1","username":"admin","is_admin":"1","logins":"1","last_login":"1543351199","default_board":null,"password":"stephan","email":""}', '{"id":"1","username":"stephan","is_admin":"1","logins":"1","last_login":"1543351199","default_board":null,"password":"stephan","email":""}', 1543351255, NULL),
	(4, 'stephan changed email to info@stephankrauss.de', '{"id":"1","username":"stephan","is_admin":"1","logins":"1","last_login":"1543351199","default_board":null,"password":"stephan","email":""}', '{"id":"1","username":"stephan","is_admin":"1","logins":"1","last_login":"1543351199","default_board":null,"password":"stephan","email":"info@stephankrauss.de"}', 1543351286, NULL),
	(5, 'stephan added board System', 'null', '{"id":"1","name":"System","active":"1"}', 1543351790, NULL),
	(6, 'stephan changed their default board.', '{"id":"1","username":"stephan","is_admin":"1","logins":"1","last_login":"1543351199","default_board":null,"password":"stephan","email":"info@stephankrauss.de"}', '{"id":"1","username":"stephan","is_admin":"1","logins":"1","last_login":"1543351199","default_board":"1","password":"stephan","email":"info@stephankrauss.de"}', 1543351919, NULL),
	(7, 'stephan logged in.', 'null', 'null', 1543352079, NULL);
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle taskboard.board
CREATE TABLE IF NOT EXISTS `board` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportiere Daten aus Tabelle taskboard.board: ~1 rows (ungefähr)
DELETE FROM `board`;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` (`id`, `name`, `active`) VALUES
	(1, 'System', 1);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle taskboard.board_user
CREATE TABLE IF NOT EXISTS `board_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL,
  `board_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_88f1d209b238c308843d93d505c76596c7780d70` (`board_id`,`user_id`),
  KEY `index_foreignkey_board_user_user` (`user_id`),
  KEY `index_foreignkey_board_user_board` (`board_id`),
  CONSTRAINT `c_fk_board_user_board_id` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `c_fk_board_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportiere Daten aus Tabelle taskboard.board_user: ~1 rows (ungefähr)
DELETE FROM `board_user`;
/*!40000 ALTER TABLE `board_user` DISABLE KEYS */;
INSERT INTO `board_user` (`id`, `user_id`, `board_id`) VALUES
	(1, 1, 1);
/*!40000 ALTER TABLE `board_user` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle taskboard.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `board_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_foreignkey_category_board` (`board_id`),
  CONSTRAINT `c_fk_category_board_id` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportiere Daten aus Tabelle taskboard.category: ~3 rows (ungefähr)
DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `name`, `color`, `board_id`) VALUES
	(1, 'Hinweis', '#34f736', 1),
	(2, 'Zustand', '#3964f5', 1),
	(3, 'Fehler', '#f95444', 1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle taskboard.jwt
CREATE TABLE IF NOT EXISTS `jwt` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportiere Daten aus Tabelle taskboard.jwt: ~1 rows (ungefähr)
DELETE FROM `jwt`;
/*!40000 ALTER TABLE `jwt` DISABLE KEYS */;
INSERT INTO `jwt` (`id`, `token`) VALUES
	(1, '$2y$10$DPSdVmKZJbnmHHU7QbqbWetvyCSCRfyXPMg1SfRqyzXd0VytkSAOu');
/*!40000 ALTER TABLE `jwt` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle taskboard.lane
CREATE TABLE IF NOT EXISTS `lane` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) unsigned DEFAULT NULL,
  `board_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_foreignkey_lane_board` (`board_id`),
  CONSTRAINT `c_fk_lane_board_id` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportiere Daten aus Tabelle taskboard.lane: ~4 rows (ungefähr)
DELETE FROM `lane`;
/*!40000 ALTER TABLE `lane` DISABLE KEYS */;
INSERT INTO `lane` (`id`, `name`, `position`, `board_id`) VALUES
	(1, 'zu erledigen', 0, 1),
	(2, 'in Arbeit', 1, 1),
	(3, 'Kontrolle', 2, 1),
	(4, 'fertig', 3, 1);
/*!40000 ALTER TABLE `lane` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle taskboard.option
CREATE TABLE IF NOT EXISTS `option` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tasks_order` int(11) unsigned DEFAULT NULL,
  `show_animations` tinyint(1) unsigned DEFAULT NULL,
  `show_assignee` tinyint(1) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_foreignkey_option_user` (`user_id`),
  CONSTRAINT `c_fk_option_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportiere Daten aus Tabelle taskboard.option: ~1 rows (ungefähr)
DELETE FROM `option`;
/*!40000 ALTER TABLE `option` DISABLE KEYS */;
INSERT INTO `option` (`id`, `tasks_order`, `show_animations`, `show_assignee`, `user_id`) VALUES
	(1, 0, 1, 1, 1);
/*!40000 ALTER TABLE `option` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle taskboard.token
CREATE TABLE IF NOT EXISTS `token` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_foreignkey_token_user` (`user_id`),
  CONSTRAINT `c_fk_token_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportiere Daten aus Tabelle taskboard.token: ~2 rows (ungefähr)
DELETE FROM `token`;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` (`id`, `token`, `user_id`) VALUES
	(1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NDMzNTY1OTcsInVpZCI6IjEifQ.zGIPYD4J-uChZjOBCGemW69yFEMpd1GELem2ZxaLsC0', 1),
	(2, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NDQ1NjE2NzksInVpZCI6IjEifQ.jayk7J04CyT1UN84CxfhVU8-0GKrl-i0I0uwj6RvoEY', 1);
/*!40000 ALTER TABLE `token` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle taskboard.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_admin` tinyint(1) unsigned DEFAULT NULL,
  `logins` int(11) unsigned DEFAULT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `default_board` tinyint(1) unsigned DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportiere Daten aus Tabelle taskboard.user: ~1 rows (ungefähr)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `is_admin`, `logins`, `last_login`, `default_board`, `password`, `email`) VALUES
	(1, 'stephan', 1, 2, 1543352079, 1, 'stephan', 'info@stephankrauss.de');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
