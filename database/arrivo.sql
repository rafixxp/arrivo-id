/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: arrivo
-- ------------------------------------------------------
-- Server version	10.11.13-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `approvals`
--

DROP TABLE IF EXISTS `approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `approvals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `employee_id` bigint(20) unsigned DEFAULT NULL,
  `attendance_id` bigint(20) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `attachment_path` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `approved_notes` text DEFAULT NULL,
  `approved_by` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approvals`
--

/*!40000 ALTER TABLE `approvals` DISABLE KEYS */;
INSERT INTO `approvals` VALUES
(2,1,1,2,13,'2026-01-12','2026-01-18','sakit','Sakit demam, masih dalam fase recovery',NULL,'approved','Iyaa, sok istirahatin dulu. Kalo perlu apa-apa bilang aja (akumah HR tapi emang suka ngebadut aja) 🙂','Rafi Ahfa Fauzan',NULL,NULL),
(3,1,1,2,14,'2026-01-14','2026-01-31','izin','Pulang kampung dulu (uhuyyy)',NULL,'rejected','katanya mau gaji 2 digit, masa mentalnya masih ketinggalan di rumahmu deck 😜','Rafi Ahfa Fauzan',NULL,NULL),
(4,1,1,11,525,'2026-01-02','2026-01-04','sakit','saya sakit',NULL,'approved','Baik, istirahatkan saja dulu sampai benar-benar sembuh, Get Well Soon :D','Rafi Ahfa Fauzan',NULL,NULL);
/*!40000 ALTER TABLE `approvals` ENABLE KEYS */;

--
-- Table structure for table `attendance_details`
--

DROP TABLE IF EXISTS `attendance_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `attendance_id` bigint(20) unsigned DEFAULT NULL,
  `time` time DEFAULT NULL,
  `attend` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(30) DEFAULT 'NULL',
  `device` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_details`
--

/*!40000 ALTER TABLE `attendance_details` DISABLE KEYS */;
INSERT INTO `attendance_details` VALUES
(22,1,2,520,'07:51:48','Tepat Waktu','clockin','/storage/clockin/clockin_1767315108.jpg',NULL,NULL,'127.0.0.1','SM-G955U - Android'),
(23,1,1,515,'08:04:26','Tepat Waktu','clockin','/storage/clockin/clockin_1767315866.jpg',NULL,NULL,'127.0.0.1','SM-G955U - Android'),
(24,1,1,529,'09:51:10','Terlambat','clockin','/storage/clockin/clockin_1767322270.jpg',NULL,NULL,'127.0.0.1',' - '),
(25,1,2,520,'10:42:02','Terlalu Awal','clockout','/storage/clockout/clockout_1767325322.jpg',NULL,NULL,'127.0.0.1','SM-G955U - Android');
/*!40000 ALTER TABLE `attendance_details` ENABLE KEYS */;

--
-- Table structure for table `attendance_headers`
--

DROP TABLE IF EXISTS `attendance_headers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance_headers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  `schedule_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=534 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_headers`
--

/*!40000 ALTER TABLE `attendance_headers` DISABLE KEYS */;
INSERT INTO `attendance_headers` VALUES
(515,1,1,2,'2026-01-02',679,1,NULL,NULL,'attendance'),
(516,1,1,2,'2026-01-03',680,0,NULL,NULL,'attendance'),
(517,1,1,2,'2026-01-04',681,0,NULL,NULL,'attendance'),
(518,1,1,2,'2026-01-05',682,0,NULL,NULL,'attendance'),
(519,1,1,2,'2026-01-06',683,0,NULL,NULL,'attendance'),
(520,1,2,3,'2026-01-02',684,1,NULL,NULL,'attendance'),
(521,1,2,3,'2026-01-03',685,0,NULL,NULL,'attendance'),
(522,1,2,3,'2026-01-04',686,0,NULL,NULL,'attendance'),
(523,1,2,3,'2026-01-05',687,0,NULL,NULL,'attendance'),
(524,1,2,3,'2026-01-06',688,0,NULL,NULL,'attendance'),
(525,1,1,11,'2026-01-02',689,2,NULL,NULL,'attendance'),
(526,1,1,11,'2026-01-03',690,0,NULL,NULL,'attendance'),
(527,1,1,11,'2026-01-04',691,0,NULL,NULL,'attendance'),
(528,1,1,11,'2026-01-05',692,0,NULL,NULL,'attendance'),
(529,1,1,7,'2026-01-02',693,1,NULL,NULL,'attendance'),
(530,1,1,7,'2026-01-03',694,0,NULL,NULL,'attendance'),
(531,1,1,7,'2026-01-04',695,0,NULL,NULL,'attendance'),
(532,1,1,7,'2026-01-05',696,0,NULL,NULL,'attendance'),
(533,1,1,7,'2026-01-06',697,0,NULL,NULL,'attendance');
/*!40000 ALTER TABLE `attendance_headers` ENABLE KEYS */;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `employee_total` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES
(1,1,'Kantor Boulevard 1','Jl. Boulevard, No.3 BSD, Bekasi',NULL,NULL,NULL),
(2,1,'Kantor Dukuhsari 2','Jl. Dukuhsari, No.3 BSD, Bekasi',NULL,NULL,NULL),
(3,2,'Klinik Asyifa','Jl. Raya Banjar',NULL,NULL,NULL);
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `npwp` varchar(255) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES
(1,'Arrivo','Jl. Palangkaraya, No.3 Blok M, Jakarta Pusat','postmaster@arrivo.id','628532336132','0034741841846','arrivo.id',NULL,NULL),
(2,'Klinik Asy-Syifa','Jl. Raya Banjar, Dsn. Cimaragas, Kec. Cimaragas, Kab. Ciamis','klinikasyyifa@gmail.com','6285323452381',NULL,'arrivo.id',NULL,NULL);
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;

--
-- Table structure for table `criteria`
--

DROP TABLE IF EXISTS `criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `criteria` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `criteria`
--

/*!40000 ALTER TABLE `criteria` DISABLE KEYS */;
INSERT INTO `criteria` VALUES
(1,'Jumlah Presensi',NULL,NULL),
(2,'Jumlah Absensi',NULL,NULL),
(3,'Jumlah Terlambat',NULL,NULL),
(4,'Jumlah Sakit',NULL,NULL),
(5,'Jumlah Izin',NULL,NULL);
/*!40000 ALTER TABLE `criteria` ENABLE KEYS */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

--
-- Table structure for table `hours`
--

DROP TABLE IF EXISTS `hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hours` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branches_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `clock_in` time DEFAULT NULL,
  `late_time` time DEFAULT NULL,
  `clock_out` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hours`
--

/*!40000 ALTER TABLE `hours` DISABLE KEYS */;
INSERT INTO `hours` VALUES
(1,1,NULL,'Shift Pagi','09:00:00','09:15:00','16:00:00',NULL,NULL),
(2,2,NULL,'Shift Pagi','09:00:00','09:30:00','16:00:00',NULL,NULL),
(3,2,NULL,'Shift Sore','16:00:00','16:10:00','22:00:00',NULL,NULL),
(4,2,NULL,'Shift Sore','16:00:00','16:10:00','22:00:00',NULL,NULL),
(5,1,NULL,'Shift Sore','16:00:00','16:10:00','12:00:00',NULL,NULL);
/*!40000 ALTER TABLE `hours` ENABLE KEYS */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_reset_tokens_table',1),
(3,'2019_08_19_000000_create_failed_jobs_table',1),
(4,'2019_12_14_000001_create_personal_access_tokens_table',1),
(5,'2025_12_20_130729_create_companies_table',1),
(6,'2025_12_20_130741_create_branches_table',1),
(7,'2025_12_20_130753_create_positions_table',1),
(8,'2025_12_20_130805_create_shifts_table',1),
(9,'2025_12_20_130812_create_schedules_table',1),
(10,'2025_12_20_130834_create_attendance_headers_table',1),
(11,'2025_12_20_130842_create_attendance_details_table',1),
(12,'2025_12_27_195749_create_approvals_table',2),
(13,'2025_12_28_105000_create_payslip_components_table',3),
(14,'2025_12_28_105039_create_payslip_headers_table',3),
(15,'2025_12_28_105046_create_payslip_details_table',3),
(16,'2025_12_28_170305_create_times_table',3),
(17,'2025_12_29_111534_create_payslip_setting_headers_table',4),
(18,'2025_12_29_111542_create_payslip_setting_details_table',4),
(19,'2025_12_29_112512_create_criterias_table',4),
(20,'2025_12_29_224645_create_payslip_users_table',5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;

--
-- Table structure for table `payslip_components`
--

DROP TABLE IF EXISTS `payslip_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payslip_components` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `criteria_id` varchar(255) DEFAULT NULL,
  `time_id` bigint(20) unsigned DEFAULT NULL,
  `quantity` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payslip_components`
--

/*!40000 ALTER TABLE `payslip_components` DISABLE KEYS */;
INSERT INTO `payslip_components` VALUES
(14,1,NULL,'Gaji Pokok','1','1',1,'1',1,NULL,NULL),
(15,1,NULL,'Transport','1','1',1,'1',1,NULL,NULL),
(16,1,NULL,'Ketidakhadiran','2','2',1,'1',1,NULL,NULL),
(17,1,NULL,'Jaminan Hari Tua','2','1',1,'1',1,NULL,NULL);
/*!40000 ALTER TABLE `payslip_components` ENABLE KEYS */;

--
-- Table structure for table `payslip_details`
--

DROP TABLE IF EXISTS `payslip_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payslip_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `payslip_user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `time_id` bigint(20) unsigned DEFAULT NULL,
  `value` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `quantity` tinyint(4) DEFAULT NULL,
  `val` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payslip_details`
--

/*!40000 ALTER TABLE `payslip_details` DISABLE KEYS */;
INSERT INTO `payslip_details` VALUES
(86,1,NULL,1,39,'Gaji Pokok','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(87,1,NULL,1,39,'Transport','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(88,1,NULL,1,39,'Ketidakhadiran','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(89,1,NULL,1,39,'Jaminan Hari Tua','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(90,1,1,2,40,'Gaji Pokok','1',3,100000,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,100000),
(91,1,1,2,40,'Transport','1',3,10000,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,10000),
(92,1,1,2,40,'Ketidakhadiran','2',3,20000,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,10000),
(93,1,1,2,40,'Jaminan Hari Tua','2',1,50000,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,50000),
(94,1,2,3,41,'Gaji Pokok','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(95,1,2,3,41,'Transport','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(96,1,2,3,41,'Ketidakhadiran','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(97,1,2,3,41,'Jaminan Hari Tua','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(98,1,1,4,42,'Gaji Pokok','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(99,1,1,4,42,'Transport','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(100,1,1,4,42,'Ketidakhadiran','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(101,1,1,4,42,'Jaminan Hari Tua','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(102,1,2,5,43,'Gaji Pokok','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(103,1,2,5,43,'Transport','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(104,1,2,5,43,'Ketidakhadiran','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(105,1,2,5,43,'Jaminan Hari Tua','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(106,1,2,6,44,'Gaji Pokok','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(107,1,2,6,44,'Transport','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(108,1,2,6,44,'Ketidakhadiran','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(109,1,2,6,44,'Jaminan Hari Tua','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(110,1,1,7,45,'Gaji Pokok','1',3,300000,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,100000),
(111,1,1,7,45,'Transport','1',3,30000,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,10000),
(112,1,1,7,45,'Ketidakhadiran','2',3,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,10000),
(113,1,1,7,45,'Jaminan Hari Tua','2',1,50000,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,50000),
(114,1,1,8,46,'Gaji Pokok','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(115,1,1,8,46,'Transport','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(116,1,1,8,46,'Ketidakhadiran','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(117,1,1,8,46,'Jaminan Hari Tua','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(118,1,1,9,47,'Gaji Pokok','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(119,1,1,9,47,'Transport','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(120,1,1,9,47,'Ketidakhadiran','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(121,1,1,9,47,'Jaminan Hari Tua','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(122,1,1,10,48,'Gaji Pokok','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(123,1,1,10,48,'Transport','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(124,1,1,10,48,'Ketidakhadiran','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(125,1,1,10,48,'Jaminan Hari Tua','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(126,1,1,11,49,'Gaji Pokok','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(127,1,1,11,49,'Transport','1',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(128,1,1,11,49,'Ketidakhadiran','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(129,1,1,11,49,'Jaminan Hari Tua','2',1,0,'2025-12-30 01:30:03','2025-12-30 01:30:03',1,0),
(130,1,NULL,1,50,'Gaji Pokok','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(131,1,NULL,1,50,'Transport','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(132,1,NULL,1,50,'Ketidakhadiran','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(133,1,NULL,1,50,'Jaminan Hari Tua','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(134,1,1,2,51,'Gaji Pokok','1',3,300000,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,100000),
(135,1,1,2,51,'Transport','1',3,30000,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,10000),
(136,1,1,2,51,'Ketidakhadiran','2',3,20000,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,10000),
(137,1,1,2,51,'Jaminan Hari Tua','2',1,50000,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,50000),
(138,1,2,3,52,'Gaji Pokok','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(139,1,2,3,52,'Transport','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(140,1,2,3,52,'Ketidakhadiran','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(141,1,2,3,52,'Jaminan Hari Tua','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(142,1,1,4,53,'Gaji Pokok','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(143,1,1,4,53,'Transport','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(144,1,1,4,53,'Ketidakhadiran','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(145,1,1,4,53,'Jaminan Hari Tua','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(146,1,2,5,54,'Gaji Pokok','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(147,1,2,5,54,'Transport','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(148,1,2,5,54,'Ketidakhadiran','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(149,1,2,5,54,'Jaminan Hari Tua','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(150,1,2,6,55,'Gaji Pokok','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(151,1,2,6,55,'Transport','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(152,1,2,6,55,'Ketidakhadiran','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(153,1,2,6,55,'Jaminan Hari Tua','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(154,1,1,7,56,'Gaji Pokok','1',3,300000,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,100000),
(155,1,1,7,56,'Transport','1',3,30000,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,10000),
(156,1,1,7,56,'Ketidakhadiran','2',3,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,10000),
(157,1,1,7,56,'Jaminan Hari Tua','2',1,50000,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,50000),
(158,1,1,8,57,'Gaji Pokok','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(159,1,1,8,57,'Transport','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(160,1,1,8,57,'Ketidakhadiran','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(161,1,1,8,57,'Jaminan Hari Tua','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(162,1,1,9,58,'Gaji Pokok','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(163,1,1,9,58,'Transport','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(164,1,1,9,58,'Ketidakhadiran','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(165,1,1,9,58,'Jaminan Hari Tua','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(166,1,1,10,59,'Gaji Pokok','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(167,1,1,10,59,'Transport','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(168,1,1,10,59,'Ketidakhadiran','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(169,1,1,10,59,'Jaminan Hari Tua','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(170,1,1,11,60,'Gaji Pokok','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(171,1,1,11,60,'Transport','1',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(172,1,1,11,60,'Ketidakhadiran','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0),
(173,1,1,11,60,'Jaminan Hari Tua','2',1,0,'2025-12-30 10:47:36','2025-12-30 10:47:36',1,0);
/*!40000 ALTER TABLE `payslip_details` ENABLE KEYS */;

--
-- Table structure for table `payslip_headers`
--

DROP TABLE IF EXISTS `payslip_headers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payslip_headers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `start_from` date DEFAULT NULL,
  `end_at` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payslip_headers`
--

/*!40000 ALTER TABLE `payslip_headers` DISABLE KEYS */;
INSERT INTO `payslip_headers` VALUES
(15,1,NULL,1,'Desember 2025','2025-12-01','2025-12-31',NULL,'2025-12-30 01:30:03','2025-12-30 01:30:03'),
(16,1,NULL,1,'Periode Desember 2025','2025-12-01','2025-12-31',NULL,'2025-12-30 10:47:36','2025-12-30 10:47:36');
/*!40000 ALTER TABLE `payslip_headers` ENABLE KEYS */;

--
-- Table structure for table `payslip_setting_details`
--

DROP TABLE IF EXISTS `payslip_setting_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payslip_setting_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `payslip_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `time_id` bigint(20) unsigned DEFAULT NULL,
  `criteria_id` bigint(20) unsigned DEFAULT NULL,
  `quantity` tinyint(3) unsigned DEFAULT NULL,
  `value` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `component_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payslip_setting_details`
--

/*!40000 ALTER TABLE `payslip_setting_details` DISABLE KEYS */;
INSERT INTO `payslip_setting_details` VALUES
(37,2,3,32,'Gaji Pokok','1',1,1,1,0,'2025-12-30 00:13:19','2025-12-30 00:13:19',5,12),
(38,2,3,32,'Transport','1',1,1,1,0,'2025-12-30 00:13:19','2025-12-30 00:13:19',6,12),
(39,2,3,32,'Ketidakhadiran','2',1,2,0,0,'2025-12-30 00:13:19','2025-12-30 00:13:19',7,12),
(40,2,3,33,'Gaji Pokok','1',1,1,1,3600000,'2025-12-30 00:13:19','2025-12-30 00:13:47',5,13),
(41,2,3,33,'Transport','1',3,1,1,10000,'2025-12-30 00:13:19','2025-12-30 00:14:03',6,13),
(42,2,3,33,'Ketidakhadiran','2',3,2,0,10000,'2025-12-30 00:13:19','2025-12-30 00:14:18',7,13),
(43,2,3,32,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 00:15:05','2025-12-30 00:15:05',13,12),
(44,2,3,33,'Jaminan Hari Tua','2',1,1,1,100000,'2025-12-30 00:15:05','2025-12-30 00:15:23',13,13),
(45,1,NULL,34,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',8,1),
(46,1,NULL,34,'Transport','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',9,1),
(47,1,NULL,34,'Uang Makan','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',10,1),
(48,1,NULL,34,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',11,1),
(49,1,NULL,34,'Tunjangan BPJS','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',12,1),
(50,1,1,35,'Gaji Pokok','1',3,1,1,100000,'2025-12-30 01:15:07','2025-12-30 01:15:40',8,2),
(51,1,1,35,'Transport','1',3,1,1,20000,'2025-12-30 01:15:07','2025-12-30 01:15:54',9,2),
(52,1,1,35,'Uang Makan','1',3,1,1,10000,'2025-12-30 01:15:07','2025-12-30 01:16:07',10,2),
(53,1,1,35,'Jaminan Hari Tua','2',1,1,1,100000,'2025-12-30 01:15:07','2025-12-30 01:16:27',11,2),
(54,1,1,35,'Tunjangan BPJS','2',1,1,1,50000,'2025-12-30 01:15:07','2025-12-30 01:16:44',12,2),
(55,1,2,36,'Gaji Pokok','1',3,1,1,100000,'2025-12-30 01:15:07','2025-12-30 01:17:07',8,3),
(56,1,2,36,'Transport','1',3,1,1,15000,'2025-12-30 01:15:07','2025-12-30 01:17:21',9,3),
(57,1,2,36,'Uang Makan','1',3,1,1,10000,'2025-12-30 01:15:07','2025-12-30 01:17:34',10,3),
(58,1,2,36,'Jaminan Hari Tua','2',1,1,1,100000,'2025-12-30 01:15:07','2025-12-30 01:17:51',11,3),
(59,1,2,36,'Tunjangan BPJS','2',1,1,1,50000,'2025-12-30 01:15:07','2025-12-30 01:18:01',12,3),
(60,1,1,37,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',8,4),
(61,1,1,37,'Transport','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',9,4),
(62,1,1,37,'Uang Makan','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',10,4),
(63,1,1,37,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',11,4),
(64,1,1,37,'Tunjangan BPJS','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',12,4),
(65,1,2,38,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',8,5),
(66,1,2,38,'Transport','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',9,5),
(67,1,2,38,'Uang Makan','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',10,5),
(68,1,2,38,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',11,5),
(69,1,2,38,'Tunjangan BPJS','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',12,5),
(70,1,2,39,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',8,6),
(71,1,2,39,'Transport','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',9,6),
(72,1,2,39,'Uang Makan','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',10,6),
(73,1,2,39,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',11,6),
(74,1,2,39,'Tunjangan BPJS','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',12,6),
(75,1,1,40,'Gaji Pokok','1',3,1,1,100000,'2025-12-30 01:15:07','2025-12-30 01:18:25',8,7),
(76,1,1,40,'Transport','1',3,1,1,15000,'2025-12-30 01:15:07','2025-12-30 01:18:37',9,7),
(77,1,1,40,'Uang Makan','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',10,7),
(78,1,1,40,'Jaminan Hari Tua','2',1,1,1,100000,'2025-12-30 01:15:07','2025-12-30 01:18:54',11,7),
(79,1,1,40,'Tunjangan BPJS','2',1,1,1,50000,'2025-12-30 01:15:07','2025-12-30 01:19:06',12,7),
(80,1,1,41,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',8,8),
(81,1,1,41,'Transport','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',9,8),
(82,1,1,41,'Uang Makan','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',10,8),
(83,1,1,41,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',11,8),
(84,1,1,41,'Tunjangan BPJS','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',12,8),
(85,1,1,42,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',8,9),
(86,1,1,42,'Transport','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',9,9),
(87,1,1,42,'Uang Makan','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',10,9),
(88,1,1,42,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',11,9),
(89,1,1,42,'Tunjangan BPJS','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',12,9),
(90,1,1,43,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',8,10),
(91,1,1,43,'Transport','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',9,10),
(92,1,1,43,'Uang Makan','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',10,10),
(93,1,1,43,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',11,10),
(94,1,1,43,'Tunjangan BPJS','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',12,10),
(95,1,1,44,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',8,11),
(96,1,1,44,'Transport','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',9,11),
(97,1,1,44,'Uang Makan','1',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',10,11),
(98,1,1,44,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',11,11),
(99,1,1,44,'Tunjangan BPJS','2',1,1,1,0,'2025-12-30 01:15:07','2025-12-30 01:15:07',12,11),
(100,1,NULL,45,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',14,1),
(101,1,NULL,45,'Transport','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',15,1),
(102,1,NULL,45,'Ketidakhadiran','2',1,2,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',16,1),
(103,1,NULL,45,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',17,1),
(104,1,1,46,'Gaji Pokok','1',3,1,1,100000,'2025-12-30 01:27:20','2025-12-30 01:27:45',14,2),
(105,1,1,46,'Transport','1',3,1,1,10000,'2025-12-30 01:27:20','2025-12-30 01:27:58',15,2),
(106,1,1,46,'Ketidakhadiran','2',3,2,1,10000,'2025-12-30 01:27:20','2025-12-30 01:28:12',16,2),
(107,1,1,46,'Jaminan Hari Tua','2',1,1,1,50000,'2025-12-30 01:27:20','2025-12-30 01:28:29',17,2),
(108,1,2,47,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',14,3),
(109,1,2,47,'Transport','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',15,3),
(110,1,2,47,'Ketidakhadiran','2',1,2,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',16,3),
(111,1,2,47,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',17,3),
(112,1,1,48,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',14,4),
(113,1,1,48,'Transport','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',15,4),
(114,1,1,48,'Ketidakhadiran','2',1,2,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',16,4),
(115,1,1,48,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',17,4),
(116,1,2,49,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',14,5),
(117,1,2,49,'Transport','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',15,5),
(118,1,2,49,'Ketidakhadiran','2',1,2,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',16,5),
(119,1,2,49,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',17,5),
(120,1,2,50,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',14,6),
(121,1,2,50,'Transport','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',15,6),
(122,1,2,50,'Ketidakhadiran','2',1,2,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',16,6),
(123,1,2,50,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',17,6),
(124,1,1,51,'Gaji Pokok','1',3,1,1,100000,'2025-12-30 01:27:20','2025-12-30 01:28:51',14,7),
(125,1,1,51,'Transport','1',3,1,1,10000,'2025-12-30 01:27:20','2025-12-30 01:29:03',15,7),
(126,1,1,51,'Ketidakhadiran','2',3,2,1,10000,'2025-12-30 01:27:20','2025-12-30 01:29:15',16,7),
(127,1,1,51,'Jaminan Hari Tua','2',1,1,1,50000,'2025-12-30 01:27:20','2025-12-30 01:29:31',17,7),
(128,1,1,52,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',14,8),
(129,1,1,52,'Transport','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',15,8),
(130,1,1,52,'Ketidakhadiran','2',1,2,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',16,8),
(131,1,1,52,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',17,8),
(132,1,1,53,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',14,9),
(133,1,1,53,'Transport','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',15,9),
(134,1,1,53,'Ketidakhadiran','2',1,2,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',16,9),
(135,1,1,53,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',17,9),
(136,1,1,54,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',14,10),
(137,1,1,54,'Transport','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',15,10),
(138,1,1,54,'Ketidakhadiran','2',1,2,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',16,10),
(139,1,1,54,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',17,10),
(140,1,1,55,'Gaji Pokok','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',14,11),
(141,1,1,55,'Transport','1',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',15,11),
(142,1,1,55,'Ketidakhadiran','2',1,2,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',16,11),
(143,1,1,55,'Jaminan Hari Tua','2',1,1,1,0,'2025-12-30 01:27:20','2025-12-30 01:27:20',17,11);
/*!40000 ALTER TABLE `payslip_setting_details` ENABLE KEYS */;

--
-- Table structure for table `payslip_setting_headers`
--

DROP TABLE IF EXISTS `payslip_setting_headers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payslip_setting_headers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payslip_setting_headers`
--

/*!40000 ALTER TABLE `payslip_setting_headers` DISABLE KEYS */;
INSERT INTO `payslip_setting_headers` VALUES
(45,1,NULL,1,'Rafi Ahfa Fauzan',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(46,1,1,2,'Kanisa Ayra Nabila',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(47,1,2,3,'Bagas Saputra',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(48,1,1,4,'Satria Wisnuthama',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(49,1,2,5,'Danar Adi Saputra',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(50,1,2,6,'Muhammad Azka Fakhri Fairuz',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(51,1,1,7,'Rafi Ahfa Fauzan',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(52,1,1,8,'Tafriya Muhammad Afkar',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(53,1,1,9,'Muhammad Adrian Juliansyah',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(54,1,1,10,'Lutfi Fitriani',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(55,1,1,11,'Ikmal Firmansyah',NULL,1,'2025-12-30 01:27:20','2025-12-30 01:27:20'),
(56,2,3,12,'Dr. H. Uklauddin',NULL,1,'2025-12-31 10:44:20','2025-12-31 10:44:20'),
(57,2,3,13,'Astri Sulastri',NULL,1,'2025-12-31 10:44:20','2025-12-31 10:44:20'),
(58,2,3,14,'Rafi Ahfa Fauzan',NULL,1,'2025-12-31 10:44:20','2025-12-31 10:44:20');
/*!40000 ALTER TABLE `payslip_setting_headers` ENABLE KEYS */;

--
-- Table structure for table `payslip_users`
--

DROP TABLE IF EXISTS `payslip_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payslip_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `users_id` bigint(20) unsigned DEFAULT NULL,
  `payslip_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `present` tinyint(3) unsigned DEFAULT NULL,
  `absence` tinyint(3) unsigned DEFAULT NULL,
  `sick` tinyint(3) unsigned DEFAULT NULL,
  `leave` tinyint(3) unsigned DEFAULT NULL,
  `alpha` tinyint(3) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payslip_users`
--

/*!40000 ALTER TABLE `payslip_users` DISABLE KEYS */;
INSERT INTO `payslip_users` VALUES
(39,1,NULL,1,15,'Rafi Ahfa Fauzan',0,0,0,0,NULL,NULL,NULL),
(40,1,1,2,15,'Kanisa Ayra Nabila',1,2,1,1,NULL,NULL,NULL),
(41,1,2,3,15,'Bagas Saputra',0,0,0,0,NULL,NULL,NULL),
(42,1,1,4,15,'Satria Wisnuthama',1,0,0,0,NULL,NULL,NULL),
(43,1,2,5,15,'Danar Adi Saputra',1,0,0,0,NULL,NULL,NULL),
(44,1,2,6,15,'Muhammad Azka Fakhri Fairuz',0,0,0,0,NULL,NULL,NULL),
(45,1,1,7,15,'Rafi Ahfa Fauzan',3,0,0,0,NULL,NULL,NULL),
(46,1,1,8,15,'Tafriya Muhammad Afkar',1,0,0,0,NULL,NULL,NULL),
(47,1,1,9,15,'Muhammad Adrian Juliansyah',1,0,0,0,NULL,NULL,NULL),
(48,1,1,10,15,'Lutfi Fitriani',1,0,0,0,NULL,NULL,NULL),
(49,1,1,11,15,'Ikmal Firmansyah',1,0,0,0,NULL,NULL,NULL),
(50,1,NULL,1,16,'Rafi Ahfa Fauzan',0,0,0,0,NULL,NULL,NULL),
(51,1,1,2,16,'Kanisa Ayra Nabila',3,2,1,1,NULL,NULL,NULL),
(52,1,2,3,16,'Bagas Saputra',0,0,0,0,NULL,NULL,NULL),
(53,1,1,4,16,'Satria Wisnuthama',1,0,0,0,NULL,NULL,NULL),
(54,1,2,5,16,'Danar Adi Saputra',1,0,0,0,NULL,NULL,NULL),
(55,1,2,6,16,'Muhammad Azka Fakhri Fairuz',0,0,0,0,NULL,NULL,NULL),
(56,1,1,7,16,'Rafi Ahfa Fauzan',3,0,0,0,NULL,NULL,NULL),
(57,1,1,8,16,'Tafriya Muhammad Afkar',1,0,0,0,NULL,NULL,NULL),
(58,1,1,9,16,'Muhammad Adrian Juliansyah',1,0,0,0,NULL,NULL,NULL),
(59,1,1,10,16,'Lutfi Fitriani',1,0,0,0,NULL,NULL,NULL),
(60,1,1,11,16,'Ikmal Firmansyah',1,0,0,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `payslip_users` ENABLE KEYS */;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES
(1,'App\\Models\\User',1,'auth_token','c150d16e85bf217200f2bb3ce6eca1f5f98cba7e7b6770e3152f72686e231795','[\"*\"]',NULL,NULL,'2025-12-25 08:17:07','2025-12-25 08:17:07'),
(2,'App\\Models\\User',1,'auth_token','38e9c789845c4245ee107deb4600a50f1a41abe0ecbcb67724e9ed62923d1ff8','[\"*\"]',NULL,NULL,'2025-12-25 08:17:19','2025-12-25 08:17:19'),
(3,'App\\Models\\User',1,'auth_token','e44610cfce23b0c28baa08b30b3ad11394756bea8fd4acaa72d723415def97d6','[\"*\"]',NULL,NULL,'2025-12-25 08:19:58','2025-12-25 08:19:58'),
(4,'App\\Models\\User',1,'auth_token','90e36f759b6e2c31668e5bf218831e74be90f6df1efceacc9082435f46fe1b5a','[\"*\"]',NULL,NULL,'2025-12-25 08:21:40','2025-12-25 08:21:40'),
(6,'App\\Models\\User',1,'auth_token','7a6bfe8778dd094af21c2b83ac4c766dc366c325b2d98f571e439c456a0189f5','[\"*\"]',NULL,NULL,'2025-12-25 08:24:01','2025-12-25 08:24:01'),
(7,'App\\Models\\User',1,'auth_token','ef32b0bb5b523bf9bd8c78fcbe3b4b667afe84405194d53030aeab61e69707ed','[\"*\"]',NULL,NULL,'2025-12-25 08:25:08','2025-12-25 08:25:08'),
(8,'App\\Models\\User',1,'auth_token','b1f2e984ad5eae0b983cbd50a422c8e4e1354098b32b5aec4ff4d2ae4c0b0e47','[\"*\"]',NULL,NULL,'2025-12-25 08:25:50','2025-12-25 08:25:50'),
(9,'App\\Models\\User',1,'auth_token','abd9bd2b7a907bb1f70bc105ab7aa682cd8cebd5847a0e9d42cd6fec4d727338','[\"*\"]',NULL,NULL,'2025-12-25 08:33:55','2025-12-25 08:33:55'),
(10,'App\\Models\\User',1,'auth_token','0b6b8663df975bf44db22014d349bebe1d20f47691adecdf632f48dedd195dfa','[\"*\"]',NULL,NULL,'2025-12-25 08:34:13','2025-12-25 08:34:13'),
(11,'App\\Models\\User',1,'auth_token','7962141347b2c20081cdbf042ad796205207995dfc31268bf2be8bef034d8e0f','[\"*\"]',NULL,NULL,'2025-12-25 08:34:28','2025-12-25 08:34:28'),
(12,'App\\Models\\User',1,'auth_token','2a4ecac5ade254228403f84af021a4ee6a316f7e164a88959d0f523788d5f78c','[\"*\"]',NULL,NULL,'2025-12-25 08:35:47','2025-12-25 08:35:47'),
(25,'App\\Models\\User',2,'auth_token','292d6ed7871d8984b9866501850cd449757cbf11abe0909e2fc719101cd106f0','[\"*\"]','2025-12-26 18:19:29',NULL,'2025-12-26 09:11:54','2025-12-26 18:19:29'),
(42,'App\\Models\\User',9,'auth_token','6221bb76629b9bb79fcf46a63574f684c73c6dc70cc3b564eadcd2fc726e9064','[\"*\"]','2025-12-27 18:20:01',NULL,'2025-12-27 18:19:49','2025-12-27 18:20:01'),
(51,'App\\Models\\User',10,'auth_token','e2ac6009b174d9f7b77e0816e7930b4fa65b506dccabe876afd676b8478fa528','[\"*\"]','2025-12-28 16:38:10',NULL,'2025-12-28 16:30:16','2025-12-28 16:38:10'),
(54,'App\\Models\\User',10,'auth_token','3473d24e6cc4e1dd04f7cdee1ecdfc83111611236c642d4bb5e4e73dc2926549','[\"*\"]','2025-12-28 16:37:22',NULL,'2025-12-28 16:37:00','2025-12-28 16:37:22'),
(68,'App\\Models\\User',12,'auth_token','c653f8929a91accc9490a87d6ecd777cecfb35d8e5e147f6059f4bf68d29be8a','[\"*\"]',NULL,NULL,'2025-12-29 01:53:40','2025-12-29 01:53:40'),
(86,'App\\Models\\User',1,'auth_token','c30e201da6978752fd21a265f6106dc8db18a66b5505f28d955e335b052cf2fc','[\"*\"]','2025-12-30 04:19:06',NULL,'2025-12-30 04:18:59','2025-12-30 04:19:06'),
(90,'App\\Models\\User',1,'auth_token','a13b3a23f42f202174ef724d7a3359c23e89f9337e75e058dff5aabc5321f84f','[\"*\"]','2025-12-30 05:04:01',NULL,'2025-12-30 05:03:40','2025-12-30 05:04:01'),
(95,'App\\Models\\User',2,'auth_token','bacd069fc731fdc65cbdd55f4aecbe39db225af1bc007a20bb114fd85e258335','[\"*\"]','2025-12-30 10:22:04',NULL,'2025-12-30 10:22:00','2025-12-30 10:22:04'),
(98,'App\\Models\\User',2,'auth_token','73d39f430d193e86c572516bd0d6d9c47c756af491b8a2dd91de1bd87e96cb65','[\"*\"]',NULL,NULL,'2025-12-30 10:49:23','2025-12-30 10:49:23'),
(100,'App\\Models\\User',2,'auth_token','56276ae5f588669c0d915b92a588635f49a4aee40333470e79d6eabae2557958','[\"*\"]',NULL,NULL,'2025-12-30 13:10:12','2025-12-30 13:10:12'),
(103,'App\\Models\\User',2,'auth_token','8c35b6f4ee061f0145b96e372eae78e9d75f16ae35ac799bad013d557c411419','[\"*\"]','2025-12-30 13:53:10',NULL,'2025-12-30 13:53:08','2025-12-30 13:53:10'),
(104,'App\\Models\\User',1,'auth_token','e575cff8688d0a00415788d3cfb260805be49fbab9387eddca6ea53a3092d73c','[\"*\"]','2025-12-30 16:30:53',NULL,'2025-12-30 13:56:15','2025-12-30 16:30:53'),
(116,'App\\Models\\User',12,'auth_token','45f9eb4a91d8d33bb022159c778f75d0c11e6b9eedca1642717918b27e9ed39d','[\"*\"]','2025-12-31 07:18:37',NULL,'2025-12-31 07:15:25','2025-12-31 07:18:37'),
(117,'App\\Models\\User',12,'auth_token','60caa8991f2c060bb3b925e0b761b411d5349330789a9bb63b694cf772ab1f83','[\"*\"]','2025-12-31 07:20:52',NULL,'2025-12-31 07:19:18','2025-12-31 07:20:52'),
(118,'App\\Models\\User',12,'auth_token','e4624243f2d4b3c79b94c23625a939c6c4ac6e9d51162a8eb74e829e6d0eadb6','[\"*\"]','2025-12-31 07:22:35',NULL,'2025-12-31 07:21:05','2025-12-31 07:22:35'),
(125,'App\\Models\\User',1,'auth_token','c4ba0969b3768a52f6db8228771bcc5ed1b491b65ae83e5d46f6d0b8e3ed7c17','[\"*\"]',NULL,NULL,'2025-12-31 12:07:13','2025-12-31 12:07:13'),
(128,'App\\Models\\User',1,'auth_token','8cb3a4fae7c221ffdca2c6124412b6ca6730f3b69d245fe7ff84fc8b874ff1a5','[\"*\"]','2025-12-31 18:06:54',NULL,'2025-12-31 16:21:27','2025-12-31 18:06:54'),
(164,'App\\Models\\User',2,'auth_token','5aa95a0b70858224ca9ee8ad27a604465a85f52099422b4532722871ee752122','[\"*\"]','2026-01-03 03:10:43',NULL,'2026-01-02 16:28:16','2026-01-03 03:10:43'),
(166,'App\\Models\\User',7,'auth_token','f6a3582607e6c205e1201112f6c2e9d394ae8b81048aa7e66d675636ea1a9b5a','[\"*\"]','2026-01-02 18:01:00',NULL,'2026-01-02 17:47:19','2026-01-02 18:01:00'),
(167,'App\\Models\\User',2,'auth_token','5fdbf262fcc69da24b3541a02440ec7bb6db011c9ecd5e4279457c63b597a1d9','[\"*\"]','2026-01-03 03:11:39',NULL,'2026-01-03 03:11:21','2026-01-03 03:11:39'),
(168,'App\\Models\\User',2,'auth_token','cfe85bc4b47bec699b39f8de8800073c5f806825277e83d9dcb991d36a9b0bae','[\"*\"]','2026-01-03 03:16:44',NULL,'2026-01-03 03:16:22','2026-01-03 03:16:44'),
(169,'App\\Models\\User',2,'auth_token','4e2bc68f1701b519651fe9aa1cc0e752664b30ad82368815b0357e5366284ff0','[\"*\"]',NULL,NULL,'2026-01-03 03:16:38','2026-01-03 03:16:38');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `positions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branches_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `employee_total` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES
(1,1,NULL,'HRD',NULL,NULL,NULL),
(2,1,NULL,'Market Research',NULL,NULL,NULL),
(3,1,NULL,'Computer Engineer',NULL,NULL,NULL),
(4,1,NULL,'Supervisor',NULL,NULL,NULL),
(5,2,NULL,'Ahli Bedah',NULL,NULL,NULL),
(6,2,NULL,'Ahli Organ Dalam',NULL,NULL,NULL),
(7,2,NULL,'Farmasi',NULL,NULL,NULL),
(8,2,NULL,'Perawat',NULL,NULL,NULL),
(9,2,NULL,'Ahli Wajah dan Kulit',NULL,NULL,NULL);
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branches_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `shift` varchar(255) DEFAULT NULL,
  `clock_in` time DEFAULT NULL,
  `late_time` time DEFAULT NULL,
  `clock_out` time DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `hour_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=698 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES
(679,1,1,'2','2026-01-02','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(680,1,1,'2','2026-01-03','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(681,1,1,'2','2026-01-04','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(682,1,1,'2','2026-01-05','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(683,1,1,'2','2026-01-06','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(684,1,2,'3','2026-01-02','Shift Sore','16:00:00','16:10:00','12:00:00','1',NULL,NULL,5),
(685,1,2,'3','2026-01-03','Shift Sore','16:00:00','16:10:00','12:00:00','1',NULL,NULL,5),
(686,1,2,'3','2026-01-04','Shift Sore','16:00:00','16:10:00','12:00:00','1',NULL,NULL,5),
(687,1,2,'3','2026-01-05','Shift Sore','16:00:00','16:10:00','12:00:00','1',NULL,NULL,5),
(688,1,2,'3','2026-01-06','Shift Sore','16:00:00','16:10:00','12:00:00','1',NULL,NULL,5),
(689,1,1,'11','2026-01-02','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(690,1,1,'11','2026-01-03','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(691,1,1,'11','2026-01-04','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(692,1,1,'11','2026-01-05','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(693,1,1,'7','2026-01-02','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(694,1,1,'7','2026-01-03','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(695,1,1,'7','2026-01-04','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(696,1,1,'7','2026-01-05','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1),
(697,1,1,'7','2026-01-06','Shift Pagi','09:00:00','09:15:00','16:00:00','1',NULL,NULL,1);
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;

--
-- Table structure for table `times`
--

DROP TABLE IF EXISTS `times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `times` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `operator` varchar(2) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `times`
--

/*!40000 ALTER TABLE `times` DISABLE KEYS */;
INSERT INTO `times` VALUES
(1,'Perbulan',NULL,'1',NULL,NULL),
(2,'Perminggu',NULL,'7',NULL,NULL),
(3,'Perhari',NULL,'30',NULL,NULL),
(4,'Perjam',NULL,'1',NULL,NULL),
(5,'Permenit',NULL,'60',NULL,NULL);
/*!40000 ALTER TABLE `times` ENABLE KEYS */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `place_of_birth` text DEFAULT NULL,
  `position_id` bigint(20) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `hour_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,1,NULL,'Rafi Ahfa Fauzan','rafiahfa@arrivo.id',NULL,'085323376111','Jl. Raya Banjar','2025-07-09','Ciamis',1,'super admin','$2y$10$Ft4cKwPpkT.KQeIQiowsre5rkuKPjwLoiaKcTInawYhaQo0P99hda',NULL,NULL,NULL,NULL),
(2,1,1,'Kanisa Ayra Nabila','kanisa@arrivo.id',NULL,'628341851531','Jl. Garut Sumedang, Kec. Singajaya, Kab. Garut','2007-09-07','GARUT',2,'employee','$2y$10$b1CgGfIo/RNiEENov059XOHpbMHr9OeLlDVBytqD2pp.VxQS6LQlq',NULL,NULL,NULL,1),
(3,1,2,'Bagas Saputra','bagas@arrivo.id',NULL,'85167841641','Depok','2006-09-09','Depok',4,'employee','$2y$10$qBlWmsX4oZNZvTf2FOwXHeXkrk/emaLJf4H6w5AljApoYFxd1He/G',NULL,NULL,NULL,5),
(6,1,2,'Muhammad Azka Fakhri Fairuz','azkafakhri@arrivo.id',NULL,'87645141940','Cigalontang','2006-09-09','CIGALONTANG',4,'employee','$2y$10$nde/mwSH33AMq6wYXN0BtOaFJcnrlXJTLCZAHESog1.Kem1AqymxW',NULL,NULL,NULL,1),
(7,1,1,'Rafi Ahfa Fauzan','rafiahfafauzan@arrivo.id',NULL,'85323376111','Jl.Raya Banjar','2009-07-09','Ciamis',3,'employee','$2y$10$WjohuSf96Pphu7ZXGfdoyO/jO1/r3J2OUIwRSklO5QaFUHUXIYKnq',NULL,NULL,NULL,1),
(11,1,1,'Ikmal Firmansyah','ikmalfirman@arrivo.id',NULL,'85323376111','Gobras, Tawangsari','2006-09-08','Tasikmalaya',3,'employee','$2y$10$/9TDA2nZKsHRrx4oluzCGOTgEzXA.nM09YOF9soCO98KoemvAgf3K',NULL,NULL,NULL,1),
(12,2,3,'Dr. H. Uklauddin','uklauddin@klinikasyifa.id',NULL,'85323376182','Dsn. Beber, Kec. Cimaragas, Kab. Ciamis','1992-09-08','CIAMIS',6,'super admin','$2y$10$1LKVps6/8O43WScDBoXwiO7matemIZfF5uAaDQFZmXkzRecajMWZm',NULL,NULL,NULL,NULL),
(13,2,3,'Astri Sulastri','20021@arrivo.id',NULL,'824243331941','Jl. Padakembang, No.3, Dsn. Bojong','2000-08-02','CIAMIS',8,'employee','$2y$10$wOIwqXYC6Cmjs4Ujyr61M.TEJjC/Wvc5l3ZM5UIKR/U8QjoA4xwjy',NULL,NULL,NULL,3),
(14,2,3,'Rafi Ahfa Fauzan','rafiahfa01@klinikasyifa.id',NULL,'85323376111','Cineam, Kab. Tasikmalaya, Jawa Barat','2008-07-03','CIAMIS',7,'employee','$2y$10$JrrqU0D2/0.8zD7lQR.kUeGCzHmcMvmxROok1/kKH8C9eNNwzLzzu',NULL,NULL,NULL,3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

--
-- Dumping routines for database 'arrivo'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-03 10:20:08
