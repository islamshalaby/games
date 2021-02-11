-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 12, 2020 at 02:09 PM
-- Server version: 5.7.31-0ubuntu0.18.04.1
-- PHP Version: 7.2.33-1+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `games`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `visitor_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `latitude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `visitor_id`, `address_id`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES
(1, 6, 5, '29.332648', '48.0787923', '2020-10-04 07:53:09', '2020-10-11 06:21:11');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `add_data` tinyint(1) NOT NULL DEFAULT '0',
  `update_data` tinyint(1) NOT NULL DEFAULT '0',
  `delete_data` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=ucs2;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `created_at`, `updated_at`, `password`, `add_data`, `update_data`, `delete_data`) VALUES
(1, 'Super Admin', 'admin@admin.com', '2020-02-19 08:44:50', '2020-02-24 14:06:28', '$2y$10$IQ8M6C.879gvIw54Y08.N.D5ATolN9AktgFXBvAlTBxXE5PzRmd5G', 1, 1, 1),
(3, 'manager33', 'admin@admin3.com', '2020-02-19 10:50:31', '2020-02-19 11:06:12', '$2y$10$Ui0gZLEUy6YarW7okzvNgeBsoLfu4h2CndJkPLnZbu2Tcn9AfkQle', 0, 0, 0),
(4, 'test name', 'admin22@admin.com', '2020-02-19 12:43:40', '2020-02-19 12:43:40', '$2y$10$/7h98VQ0XrGgZ14TXiZn4OHMTmrWKoUykt1x5Q6o7h2Kdylo6k/CG', 0, 0, 0),
(5, 'manager4', 'manager@manager.co', '2020-02-19 13:00:00', '2020-02-19 13:00:00', '$2y$10$MHvXZVU8iSMTUhXtO4t8h.JuA80GcGADmmtMyp02DvI7hG5w7wtgi', 0, 0, 0),
(6, 'sadsa', 'asda@hgh.com', '2020-02-19 13:01:11', '2020-02-19 13:01:11', '$2y$10$861HYnfj/D68ZmEFBbaXqOpC7VegdABOBswCG1S00bc9I4HTtY5X.', 0, 0, 0),
(7, 'manager Name', 'manager@man.com', '2020-02-19 13:05:12', '2020-02-19 13:05:12', '$2y$10$dJiHXbxdeQeZk1PGVHEV7.pRrUT.sL7KOXrD4nfXItaOqh8qA1dXa', 0, 0, 0),
(8, 'Admin With Permition', 'admin@admin18.com', '2020-02-19 13:25:11', '2020-02-19 13:25:11', '$2y$10$2rELqWaPoWf/qFmOFiKYn.cCuOVQauWRe.MfKBZUk2jnT2aTtTK2m', 0, 0, 0),
(9, 'test', 'test@test.com', '2020-02-20 05:30:10', '2020-02-20 05:30:10', '$2y$10$7fHeRr886MOh.5E/2AoSTOI3nD9UpmHoIFG1tRbASiLfEk5XZT48O', 0, 0, 0),
(10, 'Admin Tested', 'tested@gmail.com', '2020-02-20 07:17:27', '2020-02-20 07:17:27', '$2y$10$B3TkLlv/T42Z//vMUuSYauAGEk44ae9JDNirmUZwyQ8xbkkzSzPpm', 0, 0, 0),
(11, 'Admin', 'admin28@admin.com', '2020-02-24 08:54:51', '2020-02-24 08:54:51', '$2y$10$tIjEcMcLtdoe5mjscdQrKOvm0rnhwVYpubw/MyBEliDPJQC1HfG2W', 0, 0, 0),
(12, 'gfgf', 'fdf@gh.vom', '2020-02-24 09:01:18', '2020-02-24 09:12:40', '$2y$10$eY.gEsu.8ule1zgs1Pfw1u7gnMKDC5wo.W7MfEj3zQmoD9zPeqGUS', 0, 1, 1),
(13, 'test', 'tets@tetst.com', '2020-04-12 13:26:02', '2020-04-12 13:26:02', '$2y$10$sKuir65TxpW.RrRhzCqRKe/nUKDUnWtv9cujab7ZqDVnFCNSl5UkC', 1, 1, 1),
(14, 'nooh', 'nooh@nooh.com', '2020-08-12 10:59:57', '2020-08-12 11:03:31', '$2y$10$K8BCIEvvs.zAfQeVo7fQ9O.dKyDWmilELwlam4Drqin4BmLk1y8O2', 0, 0, 0),
(15, '545454', 'grgrger@dfgdfg.com', '2020-08-12 11:05:57', '2020-08-12 11:05:57', '$2y$10$B3CT6SmTVtz8mlvmCN6KT.iA3ONelVz2rW8GV.up7BlYWNLIK.XE2', 0, 0, 0),
(16, 'fsdfsdfsd', 'sdfsdfsdf@sdfdsdfsd.com', '2020-08-12 11:09:32', '2020-08-12 11:09:32', '$2y$10$9PHvi8/vngjCEmZnIaWmSOwM69kiPNsEi79lNOtrVsET3r1Xag9cu', 0, 0, 0),
(17, 'dsfgdgdfg', 'erterterter@fgdfgdf.com', '2020-08-12 11:16:53', '2020-08-12 11:16:53', '$2y$10$cFO0OR7AaeSMinVPKIT6nurwU7Zyzes5DDKsPSKTrcV2mg/gQH7LS', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `admin_permissions`
--

CREATE TABLE `admin_permissions` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ucs2;

--
-- Dumping data for table `admin_permissions`
--

INSERT INTO `admin_permissions` (`id`, `admin_id`, `permission_id`, `created_at`, `updated_at`) VALUES
(27, 8, 1, '2020-02-20 07:16:53', '2020-02-20 07:16:53'),
(28, 8, 4, '2020-02-20 07:16:53', '2020-02-20 07:16:53'),
(29, 8, 5, '2020-02-20 07:16:53', '2020-02-20 07:16:53'),
(30, 8, 8, '2020-02-20 07:16:53', '2020-02-20 07:16:53'),
(31, 8, 9, '2020-02-20 07:16:53', '2020-02-20 07:16:53'),
(61, 10, 4, '2020-02-20 10:39:07', '2020-02-20 10:39:07'),
(62, 10, 5, '2020-02-20 10:39:07', '2020-02-20 10:39:07'),
(63, 10, 6, '2020-02-20 10:39:07', '2020-02-20 10:39:07'),
(64, 10, 7, '2020-02-20 10:39:07', '2020-02-20 10:39:07'),
(65, 10, 8, '2020-02-20 10:39:07', '2020-02-20 10:39:07'),
(66, 10, 9, '2020-02-20 10:39:07', '2020-02-20 10:39:07'),
(67, 10, 10, '2020-02-20 10:39:07', '2020-02-20 10:39:07'),
(116, 1, 1, '2020-02-20 11:18:23', '2020-02-20 11:18:23'),
(117, 1, 2, '2020-02-20 11:18:24', '2020-02-20 11:18:24'),
(118, 1, 3, '2020-02-20 11:18:24', '2020-02-20 11:18:24'),
(119, 1, 4, '2020-02-20 11:18:24', '2020-02-20 11:18:24'),
(120, 1, 5, '2020-02-20 11:18:24', '2020-02-20 11:18:24'),
(121, 1, 6, '2020-02-20 11:18:24', '2020-02-20 11:18:24'),
(122, 1, 7, '2020-02-20 11:18:24', '2020-02-20 11:18:24'),
(123, 1, 8, '2020-02-20 11:18:24', '2020-02-20 11:18:24'),
(124, 1, 9, '2020-02-20 11:18:24', '2020-02-20 11:18:24'),
(125, 1, 10, '2020-02-20 11:18:24', '2020-02-20 11:18:24'),
(126, 3, 1, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(127, 3, 2, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(128, 3, 3, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(129, 3, 4, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(130, 3, 5, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(131, 3, 6, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(132, 3, 7, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(133, 3, 8, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(134, 3, 9, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(135, 3, 10, '2020-02-20 11:21:03', '2020-02-20 11:21:03'),
(136, 9, 1, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(137, 9, 2, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(138, 9, 3, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(139, 9, 4, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(140, 9, 5, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(141, 9, 6, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(142, 9, 7, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(143, 9, 8, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(144, 9, 9, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(145, 9, 10, '2020-02-20 11:21:09', '2020-02-20 11:21:09'),
(146, 7, 1, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(147, 7, 2, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(148, 7, 3, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(149, 7, 4, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(150, 7, 5, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(151, 7, 6, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(152, 7, 7, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(153, 7, 8, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(154, 7, 9, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(155, 7, 10, '2020-02-20 11:21:18', '2020-02-20 11:21:18'),
(156, 6, 5, '2020-02-20 11:21:26', '2020-02-20 11:21:26'),
(157, 6, 9, '2020-02-20 11:21:26', '2020-02-20 11:21:26'),
(158, 5, 6, '2020-02-20 11:21:31', '2020-02-20 11:21:31'),
(159, 5, 10, '2020-02-20 11:21:31', '2020-02-20 11:21:31'),
(160, 4, 6, '2020-02-20 11:21:36', '2020-02-20 11:21:36'),
(161, 4, 10, '2020-02-20 11:21:36', '2020-02-20 11:21:36'),
(162, 11, 1, '2020-02-24 08:54:51', '2020-02-24 08:54:51'),
(163, 11, 2, '2020-02-24 08:54:51', '2020-02-24 08:54:51'),
(164, 11, 3, '2020-02-24 08:54:51', '2020-02-24 08:54:51'),
(165, 11, 4, '2020-02-24 08:54:51', '2020-02-24 08:54:51'),
(166, 11, 5, '2020-02-24 08:54:51', '2020-02-24 08:54:51'),
(167, 11, 6, '2020-02-24 08:54:52', '2020-02-24 08:54:52'),
(168, 11, 7, '2020-02-24 08:54:52', '2020-02-24 08:54:52'),
(169, 11, 8, '2020-02-24 08:54:52', '2020-02-24 08:54:52'),
(170, 11, 9, '2020-02-24 08:54:52', '2020-02-24 08:54:52'),
(171, 11, 10, '2020-02-24 08:54:52', '2020-02-24 08:54:52'),
(212, 12, 1, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(213, 12, 2, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(214, 12, 3, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(215, 12, 4, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(216, 12, 5, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(217, 12, 6, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(218, 12, 7, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(219, 12, 8, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(220, 12, 9, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(221, 12, 10, '2020-02-24 09:12:40', '2020-02-24 09:12:40'),
(222, 13, 2, '2020-04-12 13:26:02', '2020-04-12 13:26:02'),
(223, 13, 4, '2020-04-12 13:26:02', '2020-04-12 13:26:02'),
(224, 13, 6, '2020-04-12 13:26:02', '2020-04-12 13:26:02'),
(225, 13, 7, '2020-04-12 13:26:02', '2020-04-12 13:26:02'),
(226, 13, 10, '2020-04-12 13:26:02', '2020-04-12 13:26:02'),
(227, 13, 11, '2020-04-12 13:26:02', '2020-04-12 13:26:02'),
(228, 1, 11, '2020-04-11 21:00:00', '2020-04-11 21:00:00'),
(229, 1, 12, '2020-07-13 22:00:00', '2020-07-13 22:00:00'),
(230, 1, 13, '2020-07-13 22:00:00', '2020-07-13 22:00:00'),
(231, 1, 14, '2020-07-13 22:00:00', '2020-07-13 22:00:00'),
(232, 1, 15, '2020-07-13 22:00:00', '2020-07-13 22:00:00'),
(233, 1, 16, '2020-07-14 22:00:00', '2020-07-14 22:00:00'),
(234, 1, 17, '2020-07-15 22:00:00', '2020-07-15 22:00:00'),
(235, 1, 18, '2020-07-18 22:00:00', '2020-07-18 22:00:00'),
(236, 1, 19, '2020-07-20 22:00:00', '2020-07-20 22:00:00'),
(237, 1, 20, '2020-07-28 22:00:00', '2020-07-28 22:00:00'),
(241, 14, 13, '2020-08-12 11:03:31', '2020-08-12 11:03:31'),
(242, 14, 18, '2020-08-12 11:03:31', '2020-08-12 11:03:31'),
(243, 14, 19, '2020-08-12 11:03:31', '2020-08-12 11:03:31'),
(244, 15, 18, '2020-08-12 11:05:57', '2020-08-12 11:05:57'),
(245, 16, 1, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(246, 16, 2, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(247, 16, 3, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(248, 16, 4, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(249, 16, 5, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(250, 16, 6, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(251, 16, 7, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(252, 16, 8, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(253, 16, 9, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(254, 16, 10, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(255, 16, 11, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(256, 16, 12, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(257, 16, 13, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(258, 16, 14, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(259, 16, 15, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(260, 16, 16, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(261, 16, 17, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(262, 16, 18, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(263, 16, 19, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(264, 16, 20, '2020-08-12 11:09:32', '2020-08-12 11:09:32'),
(265, 17, 18, '2020-08-12 11:16:53', '2020-08-12 11:16:53'),
(266, 1, 21, '2020-08-12 22:00:00', '2020-08-12 22:00:00'),
(267, 1, 22, NULL, NULL),
(268, 1, 23, NULL, NULL),
(269, 1, 24, NULL, NULL),
(270, 1, 25, NULL, NULL),
(271, 1, 26, NULL, NULL),
(272, 1, 27, '2020-09-13 22:00:00', '2020-09-13 22:00:00'),
(273, 1, 28, NULL, NULL),
(274, 1, 29, NULL, NULL),
(275, 1, 30, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE `ads` (
  `id` int(10) UNSIGNED NOT NULL,
  `image` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int(11) DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `place` int(11) DEFAULT NULL,
  `content_type` int(11) DEFAULT '0',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ads`
--

INSERT INTO `ads` (`id`, `image`, `type`, `content`, `place`, `content_type`, `store_id`, `created_at`, `updated_at`) VALUES
(12, 'vj5ywnxdixadifc5nxgb.jpg', 1, '11', 2, 2, 1, '2020-09-10 09:09:58', '2020-09-17 08:59:09'),
(13, 'lqbyl2ybwaghhournjj7.jpg', 1, '1', 1, 3, 0, '2020-09-10 09:49:30', '2020-09-17 08:55:23'),
(14, 'vhtqvinmfxesjnnwodpz.jpg', 1, '2', 1, 1, 0, '2020-09-10 09:50:31', '2020-10-18 09:02:09'),
(15, 'k8ce7aciowcbqrspkdei.jpg', 2, 'https://cloudinary.com/users/login', 1, NULL, 0, '2020-09-13 12:13:49', '2020-10-18 09:00:50'),
(16, 'wax1isrwjzpba9uiwfwa.jpg', 1, '2', 2, 1, 1, '2020-09-17 10:33:49', '2020-10-18 09:00:31'),
(17, 'cwxewb1yswktmj5rc0wf.jpg', 1, '19', 1, 2, 1, '2020-09-21 09:35:15', '2020-10-18 09:00:02'),
(18, 'fjynytgpqqrntu1frov8.jpg', 1, '2', 2, 1, 0, '2020-09-28 07:53:11', '2020-10-18 08:59:45');

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `id` int(11) NOT NULL,
  `title_en` varchar(100) NOT NULL,
  `title_ar` varchar(100) NOT NULL,
  `delivery_cost` varchar(50) DEFAULT NULL,
  `place_id` varchar(255) DEFAULT NULL,
  `formatted_address` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`id`, `title_en`, `title_ar`, `delivery_cost`, `place_id`, `formatted_address`, `deleted`, `created_at`, `updated_at`) VALUES
(1, 'الجهراء', 'الجهراء', '5', 'ChIJmxzDjW4zxT8RHSyOnKJvDrY', 'Al Jahra Governorate, Kuwait', 0, '2020-06-09 20:09:52', '2020-10-04 06:03:51'),
(2, 'الفروانية', 'الفروانية', '5', 'ChIJXUiYX6Gazz8R4R7AzvKiGrg', 'Al Farwaniyah Governorate, Kuwait', 0, '2020-06-09 20:10:17', '2020-10-04 06:07:48'),
(4, 'العاصمة', 'العاصمة', '5', 'ChIJvY9dS9mNzz8RNv9jCvsjXeY', 'Al Asimah Governate, Kuwait', 0, '2020-07-27 09:48:54', '2020-10-04 06:10:11'),
(5, 'مبارك الكبير', 'مبارك الكبير', NULL, 'ChIJJ1QEgyOgzz8RtTKks8QASlQ', 'Mubarak Al-Kabeer Governorate, Kuwait', 0, '2020-09-21 10:54:03', '2020-10-04 06:15:35'),
(6, 'حولى', 'حولى', NULL, 'ChIJ9y4wzsydzz8RRjWrvMeem-w', 'Hawalli Governorate, Kuwait', 0, '2020-10-04 05:46:47', '2020-10-04 06:17:31'),
(7, 'الأحمدى', 'الأحمدى', NULL, 'ChIJm7GOze2nzz8RPDjGMoytp6c', 'Al Ahmadi Governorate, Kuwait', 0, '2020-10-04 05:47:10', '2020-10-04 06:20:53');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `title_en`, `title_ar`, `image`, `category_id`, `deleted`, `created_at`, `updated_at`) VALUES
(1, 'جهينة', 'جهينة', 'myzsxlxu3hvkkaplhmyx.png', 4, 0, '2020-05-11 22:07:54', '2020-07-27 04:20:22'),
(2, 'ساديا', 'ساديا', 'mkygisafenbbdd7urtsf.jpg', 4, 0, '2020-05-11 22:08:45', '2020-07-27 04:19:20'),
(3, 'المراعي', 'المراعي', 'ybiovzedxgzlllqlry4j.png', 4, 0, '2020-07-14 08:31:01', '2020-07-27 04:13:08'),
(4, 'شاي ليبتون', 'شاي ليبتون', 'hljbr3e9ust4fqrmsddr.png', 8, 1, '2020-07-27 04:25:59', '2020-08-12 10:37:08'),
(5, 'بيبسي', 'بيبسي', 'wncak2fpldq8iq4hkqst.png', 8, 0, '2020-07-27 04:27:05', '2020-07-27 04:27:05'),
(6, 'نستلة', 'نستلة', 'uhzrvnphmpkuynemdzxt.jpg', 5, 0, '2020-07-27 04:28:11', '2020-07-27 04:31:23'),
(7, 'dhjgdhdglllllll', 'kldfhkdfjgkdgjkd', 'mj13kox8eegpzpveumlg.png', NULL, 1, '2020-07-27 13:19:52', '2020-08-12 10:37:02');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `visitor_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `count` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `image` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_en` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_ar` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `image`, `title_en`, `title_ar`, `deleted`, `created_at`, `updated_at`) VALUES
(12, 'pkk9j7ur94orsradpvwi.jpg', 'PC', 'PC', 0, '2020-09-14 05:55:18', '2020-09-29 12:34:08'),
(18, 'iftekpakplbbngduoyhz.png', 'XBOX', 'XBOX', 0, '2020-09-23 05:54:04', '2020-09-29 12:33:11'),
(19, 'jqyhhdr99ukvk19afokf.png', 'Playstation', 'Playstation', 0, '2020-09-28 07:56:39', '2020-09-29 12:31:58');

-- --------------------------------------------------------

--
-- Table structure for table `contact_us`
--

CREATE TABLE `contact_us` (
  `id` int(10) UNSIGNED NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_us`
--

INSERT INTO `contact_us` (`id`, `phone`, `message`, `seen`, `created_at`, `updated_at`) VALUES
(1, '+201090751347', 'test body message', 1, '2020-02-17 12:59:08', '2020-09-22 09:40:38'),
(2, '+201090751347', 'test', 1, '2020-03-22 05:50:40', '2020-10-13 14:55:50'),
(3, '555555555555', 'البحث عن المشاركات التي كتبها ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو أم لا وهل هناك تعليقات روابط هذه الرساله حذفت بواسطه ام', 1, '2020-04-01 09:59:07', '2020-04-01 09:59:22'),
(4, '555555555555', 'البحث عن المشاركات التي كتبها ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو أم لا وهل هناك تعليقات روابط هذه الرساله حذفت بواسطه ام', 0, '2020-04-01 10:26:02', '2020-04-01 10:26:02'),
(5, '2334242423423423423', 'البحث عن المشاركات التي كتبها ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو ام دبليو', 0, '2020-04-01 10:28:23', '2020-04-01 10:28:23'),
(6, '324234324242342342', 'الصورة الأصلية التي كتبت بواسطة يارب يارب العالمين يارب يارب العالمين اللهم صل وسلم على نبينا', 0, '2020-04-01 10:29:51', '2020-04-01 10:29:51'),
(7, '324234324242342342', 'الصورة الأصلية التي كتبت بواسطة يارب يارب العالمين يارب يارب العالمين اللهم صل وسلم على نبينا', 0, '2020-04-01 10:30:37', '2020-04-01 10:30:37'),
(8, '2423423423423423', 'ارسال الي الان عن مواضيع نور على نبينا الكريم من المملكة على هذا', 0, '2020-04-01 10:32:14', '2020-04-01 10:32:14'),
(9, '123123121212312312312', 'الصورة الأصلية التي كتبت بواسطة ام لا و الف شكر على نبينا الكريم على هذا الرابط التالي على نبينا الكريم من المملكة على هذا الرابط فقط ام دبليو أم أن الأمر لا وهل هو الذي على هذا الموضوع الى قسم منتدى الصور العام على نبينا الكريم على هذا الموضوع المفيد أن يكون قد سبق له العمل على هذا الرابط التالي لمشاهده', 1, '2020-04-01 10:36:10', '2020-04-01 10:36:29'),
(10, '6265552235522552', 'good morning I am not sure if you have any questions or concerns please visit the plug-in settings to determine how attachments are not the intended recipient you are', 1, '2020-04-01 10:37:25', '2020-04-01 10:37:32'),
(11, '8555855555555555', 'السلام عليكم ورحمه الله وبركاته ازيك يا حبيبي عامل ايه يا عم الشيخ الحويني في مجال المبيعات اونلاين اونلاين مشاهده مباشره مشاهده مسلسل وادي الذئاب الجزء الثامن الحلقه الاولى من نوعها في العالم العربي والإسلامي الله وبركاته ازيك يا حبيبي عامل ايه يا عم الشيخ الحويني في مجال المبيعات اونلاين اونلاين', 1, '2020-04-01 10:39:39', '2020-04-01 10:39:52'),
(12, '522222555555555', 'افتح الايميل وهتلاقيها في مجال المبيعات اونلاين اونلاين مشاهده مباشره مشاهده مسلسل وادي الذئاب الجزء الثامن الحلقه الاولى من نوعها في العالم العربي', 1, '2020-04-01 10:41:43', '2020-04-01 10:41:59'),
(13, '6767668664386353', 'برامج كمبيوتر برامج مجانيه برامج كامله برامج كمبيوتر برامج مجانيه برامج كامله برامج كمبيوتر برامج مجانيه برامج كامله العاب تلبيس العاب فلاش بنات ستايل من شوية من غير زعل مع نوح من شوية من على النت من على التليفون او لا اكون في طلبات التصميم بس مش هينفع ينزل على ال ابراهيم وبارك الله فيك اخي الكريم على هذا', 0, '2020-04-01 19:36:55', '2020-04-01 19:36:55'),
(14, '+20111837797', 'hi there I am interested in the position and would like to know if you have any questions please feel free to contact me at any time and I will be there at any time and I will be there at any time and I will be there at any time and I will make sure to get the position of a few things to do in the morning and I will be there at any time and I will be there', 0, '2020-04-02 17:12:52', '2020-04-02 17:12:52'),
(15, '01271665716', 'Test me', 0, '2020-04-07 18:29:19', '2020-04-07 18:29:19'),
(16, '٠٥٤٥٥٥', 'زلللللب', 0, '2020-04-09 14:33:44', '2020-04-09 14:33:44'),
(17, '١١١١١١١١', 'تجربة', 1, '2020-04-09 16:00:25', '2020-04-09 16:00:33'),
(18, '674664646', 'Hshshs', 0, '2020-04-11 12:43:35', '2020-04-11 12:43:35'),
(19, '949', 'Ejjej', 0, '2020-04-11 18:57:04', '2020-04-11 18:57:04'),
(20, '9', 'تت', 0, '2020-04-13 10:57:37', '2020-04-13 10:57:37'),
(21, '55411928', 'Nooh', 0, '2020-04-13 18:53:32', '2020-04-13 18:53:32'),
(22, '98758835585888888', 'وعليكم السلام ورحمه الله وبركاته مساء', 1, '2020-04-16 09:59:13', '2020-04-16 09:59:25'),
(23, '5555', 'يثثق٣', 0, '2020-04-16 10:13:52', '2020-04-16 10:13:52'),
(24, '35555555555', 'sdsdfsdfsd sdfsd SD fsd sdfsd sdfsfsf sdfsd for sdfsdsdsd sdsdfsdfsd fade away from the office and I will be there at the', 1, '2020-04-21 13:36:25', '2020-04-21 13:36:40'),
(25, '9875833099', 'ىربووتثتثتثت', 0, '2020-04-22 22:08:25', '2020-04-22 22:08:25'),
(26, '6665555', 'Gfffr', 0, '2020-04-22 22:24:19', '2020-04-22 22:24:19'),
(27, '858', 'Ddd', 1, '2020-04-22 22:25:00', '2020-04-23 03:31:29'),
(28, '+201090751347', 'test', 0, '2020-07-28 01:52:12', '2020-07-28 01:52:12');

-- --------------------------------------------------------

--
-- Table structure for table `control_offers`
--

CREATE TABLE `control_offers` (
  `id` int(11) NOT NULL,
  `offers_section_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `control_offers`
--

INSERT INTO `control_offers` (`id`, `offers_section_id`, `offer_id`, `created_at`, `updated_at`) VALUES
(31, 10, 15, '2020-10-18 09:07:00', '2020-10-18 09:07:00'),
(32, 10, 14, '2020-10-18 09:07:00', '2020-10-18 09:07:00'),
(33, 10, 17, NULL, NULL),
(34, 8, 15, NULL, NULL),
(35, 8, 17, NULL, NULL),
(36, 9, 2, NULL, NULL),
(37, 9, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_areas`
--

CREATE TABLE `delivery_areas` (
  `id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `delivery_cost` varchar(50) NOT NULL,
  `min_order_cost` varchar(50) DEFAULT NULL,
  `estimated_arrival_time` varchar(100) NOT NULL,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `delivery_areas`
--

INSERT INTO `delivery_areas` (`id`, `area_id`, `delivery_cost`, `min_order_cost`, `estimated_arrival_time`, `store_id`, `created_at`, `updated_at`) VALUES
(1, 1, '5', '240', '45', 1, NULL, '2020-10-04 11:25:45'),
(2, 2, '3.5', '320', '14', 1, NULL, '2020-10-04 11:29:20'),
(3, 3, '7.5', NULL, '', 1, NULL, NULL),
(4, 4, '2.5', '189', '25', 1, NULL, '2020-10-04 11:30:12'),
(5, 1, '8', '354', '30', 2, NULL, '2020-10-04 11:28:37'),
(6, 2, '9.5', '275', '10', 2, NULL, '2020-10-04 11:29:32'),
(7, 3, '4.5', NULL, '', 2, NULL, NULL),
(8, 4, '4', '490', '50', 2, NULL, '2020-10-04 11:30:32'),
(9, 5, '11', '125', '18', 1, '2020-09-21 12:16:56', '2020-10-04 11:30:53'),
(10, 5, '20', '187', '22', 2, '2020-09-29 11:55:41', '2020-10-04 11:31:00');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `product_id`, `created_at`, `updated_at`) VALUES
(39, 33, 91, '2020-09-03 08:13:43', '2020-09-03 08:13:43'),
(40, 33, 92, '2020-09-03 08:35:16', '2020-09-03 08:35:16');

-- --------------------------------------------------------

--
-- Table structure for table `gold_prices`
--

CREATE TABLE `gold_prices` (
  `id` int(11) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gold_prices`
--

INSERT INTO `gold_prices` (`id`, `title_en`, `title_ar`, `price`, `created_at`, `updated_at`) VALUES
(2, 'عيار 21', 'عيار 21', 150.65, '2020-08-17 06:13:53', '2020-08-17 06:13:53'),
(3, 'عيار 22', 'عيار 22', 160.65, '2020-08-17 06:14:50', '2020-08-17 06:14:50'),
(4, 'عيار 24', 'عيار 24', 190.66, '2020-08-17 06:15:34', '2020-08-17 06:15:34'),
(5, 'عيار 18', 'عيار 18', 130.65, '2020-08-17 06:16:07', '2020-08-17 06:16:07');

-- --------------------------------------------------------

--
-- Table structure for table `home_elements`
--

CREATE TABLE `home_elements` (
  `id` int(11) NOT NULL,
  `home_id` int(11) NOT NULL,
  `element_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `home_elements`
--

INSERT INTO `home_elements` (`id`, `home_id`, `element_id`, `created_at`, `updated_at`) VALUES
(116, 2, 8, '2020-08-10 09:34:25', '2020-08-10 09:34:25'),
(117, 2, 9, '2020-08-10 09:34:25', '2020-08-10 09:34:25'),
(118, 2, 5, '2020-08-10 09:34:25', '2020-08-10 09:34:25'),
(119, 2, 8, '2020-08-10 09:34:25', '2020-08-10 09:34:25'),
(120, 2, 4, '2020-08-10 09:34:25', '2020-08-10 09:34:25'),
(121, 2, 5, '2020-08-10 09:34:25', '2020-08-10 09:34:25'),
(122, 2, 1, '2020-08-10 09:34:25', '2020-08-10 09:34:25'),
(123, 2, 4, '2020-08-10 09:34:25', '2020-08-10 09:34:25'),
(124, 2, 1, '2020-08-10 09:34:25', '2020-08-10 09:34:25'),
(139, 1, 5, '2020-08-11 07:52:11', '2020-08-11 07:52:11'),
(140, 1, 4, '2020-08-11 07:52:11', '2020-08-11 07:52:11'),
(141, 1, 3, '2020-08-11 07:52:11', '2020-08-11 07:52:11'),
(142, 1, 2, '2020-08-11 07:52:11', '2020-08-11 07:52:11'),
(143, 1, 1, '2020-08-11 07:52:11', '2020-08-11 07:52:11'),
(144, 0, 32, '2020-08-12 07:51:04', '2020-08-12 07:51:04'),
(147, 12, 6, '2020-08-13 10:33:21', '2020-08-13 10:33:21'),
(148, 12, 5, '2020-08-13 10:33:22', '2020-08-13 10:33:22'),
(149, 12, 3, '2020-08-13 10:33:22', '2020-08-13 10:33:22'),
(166, 18, 92, '2020-09-02 09:29:44', '2020-09-02 09:29:44'),
(167, 18, 91, '2020-09-02 09:29:44', '2020-09-02 09:29:44'),
(168, 19, 94, '2020-09-02 09:30:29', '2020-09-02 09:30:29'),
(169, 19, 93, '2020-09-02 09:30:29', '2020-09-02 09:30:29'),
(170, 19, 92, '2020-09-02 09:30:29', '2020-09-02 09:30:29'),
(171, 20, 5, '2020-09-02 09:31:57', '2020-09-02 09:31:57'),
(172, 20, 4, '2020-09-02 09:31:58', '2020-09-02 09:31:58'),
(173, 20, 1, '2020-09-02 09:31:58', '2020-09-02 09:31:58');

-- --------------------------------------------------------

--
-- Table structure for table `home_sections`
--

CREATE TABLE `home_sections` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `title_ar` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `sort` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `home_sections`
--

INSERT INTO `home_sections` (`id`, `type`, `title_ar`, `title_en`, `sort`, `created_at`, `updated_at`) VALUES
(1, 1, 'اعلانات', 'Ads', 1, '2020-05-11 21:55:47', '2020-07-28 05:39:34'),
(2, 2, 'الأقسام', 'الأقسام', 2, '2020-05-11 21:57:18', '2020-09-02 09:32:18'),
(18, 4, 'اخترنا لك', 'اخترنا لك', 5, '2020-09-02 09:29:44', '2020-09-02 09:32:19'),
(19, 4, 'افضل العروض', 'افضل العروض', 3, '2020-09-02 09:30:29', '2020-09-02 09:32:18'),
(20, 5, 'سلايدر', 'سلايدر', 4, '2020-09-02 09:31:57', '2020-09-02 09:31:57');

-- --------------------------------------------------------

--
-- Table structure for table `main_orders`
--

CREATE TABLE `main_orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `payment_method` int(11) NOT NULL,
  `subtotal_price` varchar(50) DEFAULT NULL,
  `delivery_cost` varchar(50) DEFAULT NULL,
  `total_price` varchar(50) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `main_order_number` varchar(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `main_orders`
--

INSERT INTO `main_orders` (`id`, `user_id`, `address_id`, `payment_method`, `subtotal_price`, `delivery_cost`, `total_price`, `status`, `main_order_number`, `created_at`, `updated_at`) VALUES
(2, 34, 21, 1, '2046.3', '11', '2057.3', 4, 'qD9yBcKFU', '2020-10-13 05:28:42', '2020-11-12 08:35:20');

-- --------------------------------------------------------

--
-- Table structure for table `meta_tags`
--

CREATE TABLE `meta_tags` (
  `id` int(11) NOT NULL,
  `home_meta_en` text,
  `home_meta_ar` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ucs2;

--
-- Dumping data for table `meta_tags`
--

INSERT INTO `meta_tags` (`id`, `home_meta_en`, `home_meta_ar`, `created_at`, `updated_at`) VALUES
(1, 'test meta tag english22', 'ميتا تاج عربي1', '2020-02-18 12:45:58', '2020-02-18 10:46:21');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(216, '2014_10_12_000000_create_users_table', 1),
(217, '2014_10_12_100000_create_password_resets_table', 1),
(218, '2019_08_19_000000_create_failed_jobs_table', 1),
(219, '2020_01_22_160948_create_ads_table', 1),
(220, '2020_01_23_102549_create_categories_table', 1),
(221, '2020_01_23_114523_create_settings_table', 1),
(222, '2020_01_23_122840_create_contact_us_table', 1),
(223, '2020_01_27_153233_create_doctors_lawyers_table', 1),
(224, '2020_01_28_090727_create_favorites_table', 1),
(225, '2020_01_28_120020_create_rates_table', 1),
(226, '2020_01_28_121824_create_reservations_table', 1),
(227, '2020_01_29_121840_create_services_table', 1),
(228, '2020_01_29_122258_create_doctor_lawyer_services_table', 1),
(229, '2020_01_29_122545_create_place_images_table', 1),
(230, '2020_01_29_123248_create_holidays_table', 1),
(231, '2020_01_29_124130_create_times_of_works_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `multi_options`
--

CREATE TABLE `multi_options` (
  `id` int(11) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `multi_options`
--

INSERT INTO `multi_options` (`id`, `title_en`, `title_ar`, `category_id`, `created_at`, `updated_at`) VALUES
(8, 'المقاس', 'المقاس', NULL, '2020-09-14 06:26:41', '2020-09-28 12:10:35');

-- --------------------------------------------------------

--
-- Table structure for table `multi_options_categories`
--

CREATE TABLE `multi_options_categories` (
  `id` int(11) NOT NULL,
  `multi_option_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `multi_options_categories`
--

INSERT INTO `multi_options_categories` (`id`, `multi_option_id`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 8, 12, NULL, NULL),
(2, 8, 11, NULL, NULL),
(3, 8, 18, '2020-09-23 05:54:04', '2020-09-23 05:54:04'),
(4, 8, 19, '2020-09-28 07:56:40', '2020-09-28 07:56:40'),
(5, 8, 20, '2020-09-28 11:39:52', '2020-09-28 11:39:52');

-- --------------------------------------------------------

--
-- Table structure for table `multi_options_sub_categories`
--

CREATE TABLE `multi_options_sub_categories` (
  `id` int(11) NOT NULL,
  `multi_option_id` int(11) NOT NULL,
  `sub_category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `multi_option_values`
--

CREATE TABLE `multi_option_values` (
  `id` int(11) NOT NULL,
  `multi_option_id` int(11) NOT NULL,
  `value_en` varchar(255) NOT NULL,
  `value_ar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `multi_option_values`
--

INSERT INTO `multi_option_values` (`id`, `multi_option_id`, `value_en`, `value_ar`, `created_at`, `updated_at`) VALUES
(37, 8, 'S', 'S', NULL, NULL),
(38, 8, 'M', 'M', NULL, NULL),
(39, 8, 'L', 'L', NULL, NULL),
(42, 8, 'XL', 'XL', '2020-09-23 06:32:05', '2020-09-23 07:58:14'),
(44, 8, 'XXL', 'XXL', '2020-09-23 06:35:43', '2020-09-23 07:58:26'),
(45, 8, 'XXXL', 'XXXL', '2020-09-27 12:17:38', '2020-09-27 12:17:38');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ucs2;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `title`, `body`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Notification Title', 'Notification Boooody', 'plhpqidf3yokaoejyuri.jpg', '2020-02-17 14:38:50', '2020-02-17 14:38:50'),
(5, 'fdssdf', 'dsffds', NULL, '2020-02-18 07:53:57', '2020-02-18 07:53:57'),
(6, 'fdssdf', 'dsffds', NULL, '2020-02-18 07:54:29', '2020-02-18 07:54:29'),
(7, 'fdssdf', 'dsffds', NULL, '2020-02-18 07:55:28', '2020-02-18 07:55:28'),
(8, 'dg', 'dg', NULL, '2020-02-18 07:56:19', '2020-02-18 07:56:19'),
(9, 'fdsafds', 'fdsfds', NULL, '2020-02-18 07:59:14', '2020-02-18 07:59:14'),
(10, 'testy', 'test body', NULL, '2020-02-18 08:04:13', '2020-02-18 08:04:13'),
(11, 'test', 'test', NULL, '2020-02-18 08:06:42', '2020-02-18 08:06:42'),
(12, 'test title', 'test body', NULL, '2020-02-18 08:20:55', '2020-02-18 08:20:55'),
(13, 'test title', 'test body', NULL, '2020-02-18 08:34:20', '2020-02-18 08:34:20'),
(14, 'test title', 'test body', NULL, '2020-02-18 08:35:09', '2020-02-18 08:35:09'),
(15, 'test title', 'test body', NULL, '2020-02-18 08:36:22', '2020-02-18 08:36:22'),
(16, 'test title', 'test body', NULL, '2020-02-18 08:36:54', '2020-02-18 08:36:54'),
(17, 'dsfds', 'dsfdsf', NULL, '2020-02-18 08:37:54', '2020-02-18 08:37:54'),
(18, 'dsfds', 'dsfdsf', NULL, '2020-02-18 08:38:16', '2020-02-18 08:38:16'),
(19, 'fdsfdsfds', 'fdsfdsfds', NULL, '2020-02-18 08:38:30', '2020-02-18 08:38:30'),
(20, 'fdsfdsfds', 'fdsfdsfds', NULL, '2020-02-18 08:54:51', '2020-02-18 08:54:51'),
(21, 'fdsfdsfds', 'fdsfdsfds', NULL, '2020-02-18 08:55:30', '2020-02-18 08:55:30'),
(22, 'fdsfdsfds', 'fdsfdsfds', NULL, '2020-02-18 08:56:04', '2020-02-18 08:56:04'),
(23, 'test', 'test', 'fq6jmy7et4peztea3l8b.jpg', '2020-02-18 09:00:34', '2020-02-18 09:00:34'),
(24, 'test15', 'test', 'ai3t1cmrm9u1rgvhaz0u.jpg', '2020-02-18 09:01:07', '2020-02-18 09:01:07'),
(25, 'test notification', 'body of notification', NULL, '2020-04-05 15:46:01', '2020-04-05 15:46:01'),
(26, 'عنوان التنبيه', 'محتوي التنبيه', 'dx0dtkuqxpurdk0zisv0.jpg', '2020-04-05 15:52:55', '2020-04-05 15:52:55'),
(27, 'تجربة تنبيهات المشروع الاساسي', 'تجربة تنبيهات المشروع الاساسي', 'h6ouw1vxkznnwstb9alw.png', '2020-04-09 15:56:16', '2020-04-09 15:56:16'),
(28, 'تجربة تنبيهات المشروع الاساسي', 'تجربة تنبيهات المشروع الاساسي', 'mvdhb0hopuwicnkkvvuy.png', '2020-04-09 16:00:58', '2020-04-09 16:00:58'),
(29, 'تجربة تنبيهات المشروع الاساسي', 'تجربة تنبيهات المشروع الاساسي', 'qsiyls7q1zi7iekmpidr.jpg', '2020-04-09 16:01:23', '2020-04-09 16:01:23'),
(30, 'Station title', 'body of notification', 'nghr5rp3fodgtolhujuk.png', '2020-04-12 08:11:45', '2020-04-12 08:11:45'),
(31, 'Station title', 'محتوي التنبيه', 'jfllgeese8rcvzwmwcxd.jpg', '2020-04-12 09:33:44', '2020-04-12 09:33:44'),
(32, 'test', 'test', 'qtanf7wvpu3twivexxlk.jpg', '2020-04-12 09:41:37', '2020-04-12 09:41:37'),
(33, 'test', 'test', 'rulwoahqi97pevyn5qb5.jpg', '2020-04-12 09:42:00', '2020-04-12 09:42:00'),
(34, 'test', 'test', 'fzpxjvzfhhjiwzafoaiu.jpg', '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(35, 'new test', 'test', 'rwanlczldh5nhf4bdynt.jpg', '2020-04-12 09:44:14', '2020-04-12 09:44:14'),
(36, 'test notification', 'body of notification', 'ew9aeb3f7gqeutpi0f7r.jpg', '2020-04-12 12:58:35', '2020-04-12 12:58:35'),
(37, 'عنوان التنبيه', 'المحتوي', 'tmfj7vkyj7ukje6ltxx8.jpg', '2020-04-12 13:32:38', '2020-04-12 13:32:38'),
(38, 'عنوان التنبيه', 'محتوي التنبيه', 'oos4vgryeuxyb7cuhlpw.jpg', '2020-04-12 13:34:26', '2020-04-12 13:34:26'),
(39, 'تجربة تنبيه الخميس', 'تجربة إرسال تنبيه لكل التليفونات لتطبيق جمعية الدرة النسائية', NULL, '2020-04-15 09:20:42', '2020-04-15 09:20:42'),
(40, 'Directions Service (Complex)', 'تجربة إرسال تنبيه لكل التليفونات لتطبيق جمعية الدرة النسائية', 'j7thnwktslalm1etras3.png', '2020-04-15 10:20:21', '2020-04-15 10:20:21'),
(41, 'Basic Project Notifications', 'Basic Project Notifications details to see text aligned at left side', 'yd87gqafq2sii8hjxcia.png', '2020-04-15 10:23:02', '2020-04-15 10:23:02'),
(42, 'Mahmoud Alam', 'Mahmoud Alam Notifications', 'objdnasw1n3unwb39bsb.jpg', '2020-04-15 10:27:35', '2020-04-15 10:27:35'),
(43, 'التطبيق الأساسي', 'تجربة إرسال تنبيهات للتطبيق الأساسي', 'wjgx6vyyhktvstoez780.jpg', '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(44, 'Directions Service (Complex)', 'تنبيه تجربة من لوحة التحكم الخاصة بالتطبيق', NULL, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(45, 'نظام لتقييم الموظفين أون لاين', 'Basic Project Notifications details to see text aligned at left side', NULL, '2020-04-15 10:29:54', '2020-04-15 10:29:54'),
(46, 'Directions Service (Complex)', 'Basic Project Notifications details to see text aligned at left side', 'udkqbtzkq3dvwemgyn84.jpg', '2020-04-15 10:30:15', '2020-04-15 10:30:15'),
(47, 'Directions Service (Complex)', 'Basic Project Notifications details to see text aligned at left side', NULL, '2020-04-15 10:32:31', '2020-04-15 10:32:31'),
(48, 'Directions Service (Complex)', 'Basic Project Notifications details to see text aligned at left side', 'dx4zp9na4qf4bkbtch25.jpg', '2020-04-15 10:33:07', '2020-04-15 10:33:07'),
(49, 'موقع للتوظيف', 'test send notification with image from dashboard', 'amr5cp2zs2fthvlvxq6d.png', '2020-04-20 18:24:03', '2020-04-20 18:24:03'),
(50, 'موقع للتوظيف', 'test send notification with image from dashboard', 'oaizrxn2aokeudlwmnmy.png', '2020-04-20 18:25:24', '2020-04-20 18:25:24');

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `target_id` text NOT NULL,
  `sort` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `offers_sections`
--

CREATE TABLE `offers_sections` (
  `id` int(11) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `sort` int(11) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `offers_sections`
--

INSERT INTO `offers_sections` (`id`, `icon`, `title_en`, `title_ar`, `sort`, `type`, `created_at`, `updated_at`) VALUES
(8, 'hmtvufcdb0zyzk02rdyj.png', 'أفضل عروض المحلات هذا الأسبوع', 'أفضل عروض المحلات هذا الأسبوع', 1, 1, '2020-09-14 12:24:16', '2020-10-18 08:30:35'),
(9, 'dmj8a6hx96zake58en7o.jpg', 'أفضل المنتجات بخصومات تصل إلى 50%', 'أفضل المنتجات بخصومات تصل إلى 50%', 2, 2, '2020-09-14 12:25:25', '2020-10-18 09:36:52');

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` int(11) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `property_category_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `title_en`, `title_ar`, `category_id`, `property_category_id`, `created_at`, `updated_at`) VALUES
(23, 'اللون', 'اللون', NULL, 1, '2020-09-14 08:42:36', '2020-10-01 12:06:53'),
(24, 'قدرات الإنترنت', 'قدرات الإنترنت', NULL, 1, '2020-09-14 08:56:54', '2020-10-01 12:06:00'),
(25, 'متوافق مع', 'متوافق مع', NULL, 2, '2020-09-14 12:53:21', '2020-10-01 12:05:08'),
(26, 'الوزن', 'الوزن', NULL, 2, '2020-09-14 12:55:38', '2020-10-01 12:03:00');

-- --------------------------------------------------------

--
-- Table structure for table `options_categories`
--

CREATE TABLE `options_categories` (
  `id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `options_categories`
--

INSERT INTO `options_categories` (`id`, `option_id`, `category_id`) VALUES
(6, 23, 12),
(7, 23, 11),
(8, 24, 12),
(9, 24, 11),
(10, 25, 12),
(11, 25, 11),
(12, 26, 12),
(13, 26, 11),
(14, 23, 18),
(15, 24, 18),
(16, 25, 18),
(17, 26, 18),
(18, 26, 19),
(19, 25, 19),
(20, 24, 19),
(21, 23, 19);

-- --------------------------------------------------------

--
-- Table structure for table `options_sub_categories`
--

CREATE TABLE `options_sub_categories` (
  `id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `sub_category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `option_values`
--

CREATE TABLE `option_values` (
  `id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `value_en` varchar(255) NOT NULL,
  `value_ar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `option_values`
--

INSERT INTO `option_values` (`id`, `option_id`, `value_en`, `value_ar`, `created_at`, `updated_at`) VALUES
(86, 26, '2316gm', '2316gm', '2020-10-01 12:03:01', '2020-10-01 12:03:01'),
(87, 26, '2550gm', '2550gm', '2020-10-01 12:03:01', '2020-10-01 12:03:01'),
(88, 25, 'إكس بوكس', 'إكس بوكس', '2020-10-01 12:05:08', '2020-10-01 12:05:08'),
(89, 25, 'بلاى ستيشن', 'بلاى ستيشن', '2020-10-01 12:05:08', '2020-10-01 12:05:08'),
(90, 24, 'نعم', 'نعم', '2020-10-01 12:06:00', '2020-10-01 12:06:00'),
(91, 24, 'لا', 'لا', '2020-10-01 12:06:01', '2020-10-01 12:06:01'),
(92, 23, 'أبيض', 'أبيض', '2020-10-01 12:06:54', '2020-10-01 12:06:54'),
(93, 23, 'أسود', 'أسود', '2020-10-01 12:06:54', '2020-10-01 12:06:54');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `payment_method` int(11) NOT NULL,
  `subtotal_price` varchar(50) NOT NULL,
  `delivery_cost` varchar(50) NOT NULL,
  `total_price` varchar(50) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `order_number` varchar(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `main_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `address_id`, `payment_method`, `subtotal_price`, `delivery_cost`, `total_price`, `status`, `order_number`, `store_id`, `main_id`, `created_at`, `updated_at`) VALUES
(2, 34, 21, 1, '2046.3', '11', '2057.3', 8, 'fVzpc8u7l', 1, 2, '2020-10-13 05:28:43', '2020-11-12 08:35:20');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price_before_offer` varchar(30) DEFAULT NULL,
  `final_price` varchar(30) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `count` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `refunded_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `price_before_offer`, `final_price`, `option_id`, `count`, `status`, `created_at`, `updated_at`, `delivered_at`, `refunded_at`) VALUES
(2, 2, 1, '2154', '2046.3', NULL, 1, 6, '2020-10-13 05:28:43', '2020-11-12 12:56:54', '2020-11-10 15:03:09', '2020-11-12 08:35:19');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `permission_ar` varchar(255) NOT NULL,
  `permission_en` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=ucs2;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `permission_ar`, `permission_en`, `created_at`, `updated_at`) VALUES
(1, 'المستخدمين', 'Users', '2020-02-19 14:04:33', '2020-02-19 14:04:33'),
(2, 'صفحات التطبيق', 'App Pages', '2020-02-19 14:05:13', '2020-02-19 14:05:13'),
(3, 'الإعلانات', 'Ads', '2020-02-19 14:06:10', '2020-02-19 14:06:10'),
(4, 'الأقسام', 'Categories', '2020-02-19 14:06:44', '2020-02-19 14:06:44'),
(5, 'إتصل بنا', 'Contact Us', '2020-02-19 14:07:10', '2020-02-19 14:07:10'),
(6, 'التبيهات', 'Notifications', '2020-02-19 14:07:55', '2020-02-19 14:07:55'),
(7, 'الإعدادات', 'Settings', '2020-02-19 14:08:34', '2020-02-19 14:08:34'),
(8, 'وسوم البحث', 'Meta Tags', '2020-02-19 14:09:06', '2020-02-19 14:09:06'),
(9, 'المديرين', 'Managers', '2020-02-19 14:09:59', '2020-02-19 14:09:59'),
(10, 'تنزيل النسخة الإحتياطية', 'Database Backup', '2020-02-19 14:10:21', '2020-02-19 14:10:21'),
(11, 'التقييمات', 'Rates', '2020-04-12 15:24:26', '2020-04-12 15:24:26'),
(12, 'أقسام الصفحة الرئيسية', 'Home Page Sections', '2020-07-13 22:00:00', '2020-07-13 22:00:00'),
(13, 'المناطق', 'Areas', '2020-07-13 22:00:00', '2020-07-13 22:00:00'),
(14, 'العلامات التجارية', 'Brands', '2020-07-13 22:00:00', '2020-07-13 22:00:00'),
(15, 'الأقسام الفرعية', 'Sub Categories', '2020-07-13 22:00:00', '2020-07-13 22:00:00'),
(16, 'خيارات', 'Options', '2020-07-14 22:00:00', '2020-07-14 22:00:00'),
(18, 'المنتجات', 'Products', '2020-07-18 22:00:00', '2020-07-18 22:00:00'),
(19, 'الطلبات', 'Orders', '2020-07-20 22:00:00', '2020-07-20 22:00:00'),
(20, 'الإحصائيات', 'Statistics', '2020-07-28 22:00:00', '2020-07-28 22:00:00'),
(21, 'أسعار الذهب', 'Gold prices', '2020-08-12 22:00:00', '2020-08-12 22:00:00'),
(22, 'التحكم بالعروض', 'Offers Control', NULL, NULL),
(23, 'الخيارات المتعددة', 'Multiple Options', NULL, NULL),
(24, 'طلبات المتاجر', 'Shops Orders', NULL, NULL),
(25, 'المتاجر', 'Shops', NULL, NULL),
(26, 'سلايدر', 'Sliders', '2020-09-09 22:00:00', '2020-09-09 22:00:00'),
(27, 'أقسام الخصائص', 'Properties categories', '2020-09-13 22:00:00', '2020-09-13 22:00:00'),
(28, 'أنواع المنتجات', 'Products types', NULL, NULL),
(29, 'طلبات الإسترجاع', 'Refund Requests', NULL, NULL),
(30, 'المحفظة', 'Wallet', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `video` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `title_ar` varchar(255) NOT NULL,
  `offer` tinyint(1) NOT NULL DEFAULT '0',
  `description_ar` text NOT NULL,
  `description_en` text,
  `final_price` varchar(30) DEFAULT NULL,
  `price_before_offer` varchar(30) DEFAULT '0',
  `offer_percentage` double DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `sub_category_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `total_quatity` int(11) DEFAULT NULL,
  `remaining_quantity` int(11) DEFAULT NULL,
  `stored_number` varchar(255) DEFAULT NULL,
  `sold_count` int(11) NOT NULL DEFAULT '0',
  `refund_count` int(11) NOT NULL DEFAULT '0',
  `multi_options` tinyint(4) NOT NULL DEFAULT '0',
  `store_id` int(11) DEFAULT NULL,
  `order_period` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `reviewed` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `video`, `title_en`, `barcode`, `title_ar`, `offer`, `description_ar`, `description_en`, `final_price`, `price_before_offer`, `offer_percentage`, `category_id`, `brand_id`, `sub_category_id`, `deleted`, `hidden`, `total_quatity`, `remaining_quantity`, `stored_number`, `sold_count`, `refund_count`, `multi_options`, `store_id`, `order_period`, `type`, `reviewed`, `created_at`, `updated_at`) VALUES
(1, NULL, 'مايكروسوفت إكس بوكس 1 تيرا بايت', NULL, 'test', 0, 'مايكروسوفت إكس بوكس 1 تيرا بايتمايكروسوفت إكس بوكس 1 تيرا بايتمايكروسوفت إكس بوكس 1 تيرا بايتمايكروسوفت إكس بوكس 1 تيرا بايتمايكروسوفت إكس بوكس 1 تيرا بايت', 'مايكروسوفت إكس بوكس 1 تيرا بايت مايكروسوفت إكس بوكس 1 تيرا بايتمايكروسوفت إكس بوكس 1 تيرا بايتمايكروسوفت إكس بوكس 1 تيرا بايت', '2046.3', '2046.3', 0, 18, 0, NULL, 0, 0, 24, 32, NULL, 0, 2, 0, 1, NULL, 1, 1, '2020-10-01 12:23:23', '2020-11-12 08:35:19'),
(2, NULL, 'dsdsds', NULL, 'sdssd', 1, 'dsdsds', 'sddsdss', '1994.46', '2557', 22, 19, 0, NULL, 0, 0, 36, 36, NULL, 0, 0, 0, 1, NULL, 1, 1, '2020-10-18 08:05:45', '2020-11-10 09:46:44');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `product_id` int(11) NOT NULL,
  `main` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `image`, `product_id`, `main`, `created_at`, `updated_at`) VALUES
(6, 'xjvfcjqobprluwbwvipw.jpg', 2, 1, '2020-10-18 08:05:47', '2020-11-10 09:46:58'),
(7, 'pfhxvthbu9rnpzxjqe7t.jpg', 1, 1, '2020-11-08 15:25:22', '2020-11-08 15:27:30'),
(8, 'lakh37mjwkpwfeqhtkil.png', 1, 0, '2020-11-10 09:43:45', '2020-11-10 09:43:45'),
(9, 'yskhuumqpmcg1mwlz9nq.jpg', 2, 0, '2020-11-10 09:46:58', '2020-11-10 09:46:58');

-- --------------------------------------------------------

--
-- Table structure for table `product_multi_options`
--

CREATE TABLE `product_multi_options` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `multi_option_id` int(11) NOT NULL,
  `multi_option_value_id` int(11) NOT NULL,
  `final_price` varchar(30) NOT NULL,
  `price_before_offer` varchar(255) DEFAULT '0',
  `total_quatity` int(11) NOT NULL,
  `remaining_quantity` int(11) NOT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `stored_number` varchar(255) DEFAULT NULL,
  `sold_count` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_options`
--

CREATE TABLE `product_options` (
  `id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `value_en` varchar(255) NOT NULL,
  `value_ar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_properties`
--

CREATE TABLE `product_properties` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `value_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_properties`
--

INSERT INTO `product_properties` (`id`, `product_id`, `option_id`, `value_id`, `created_at`, `updated_at`) VALUES
(115, 114, 24, 79, '2020-09-28 09:25:19', '2020-09-28 09:25:19'),
(116, 114, 25, 77, '2020-09-28 09:25:19', '2020-09-28 09:25:19'),
(139, 1, 24, 91, '2020-11-10 09:43:45', '2020-11-10 09:43:45'),
(140, 1, 25, 88, '2020-11-10 09:43:45', '2020-11-10 09:43:45'),
(141, 2, 26, 86, '2020-11-10 09:46:59', '2020-11-10 09:46:59'),
(142, 2, 25, 89, '2020-11-10 09:46:59', '2020-11-10 09:46:59'),
(143, 2, 24, 90, '2020-11-10 09:46:59', '2020-11-10 09:46:59'),
(144, 2, 23, 92, '2020-11-10 09:46:59', '2020-11-10 09:46:59');

-- --------------------------------------------------------

--
-- Table structure for table `product_types`
--

CREATE TABLE `product_types` (
  `id` int(11) NOT NULL,
  `type_en` varchar(255) NOT NULL,
  `type_ar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_types`
--

INSERT INTO `product_types` (`id`, `type_en`, `type_ar`, `created_at`, `updated_at`) VALUES
(1, 'إكسسوارات', 'إكسسوارات', '2020-09-30 07:49:18', '2020-09-30 07:49:18'),
(3, 'أجهزة', 'أجهزة', '2020-09-30 08:14:53', '2020-09-30 08:14:53');

-- --------------------------------------------------------

--
-- Table structure for table `properties_categories`
--

CREATE TABLE `properties_categories` (
  `id` int(11) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `properties_categories`
--

INSERT INTO `properties_categories` (`id`, `title_en`, `title_ar`, `deleted`, `created_at`, `updated_at`) VALUES
(1, 'معلومات المنتج', 'معلومات المنتج', 0, '2020-09-14 07:34:49', '2020-09-14 07:34:49'),
(2, 'قياسات المنتج', 'قياسات المنتج', 0, '2020-09-14 07:35:15', '2020-09-14 08:00:32');

-- --------------------------------------------------------

--
-- Table structure for table `rates`
--

CREATE TABLE `rates` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `rate` int(11) NOT NULL,
  `admin_approval` tinyint(1) NOT NULL DEFAULT '0',
  `order_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rates`
--

INSERT INTO `rates` (`id`, `user_id`, `text`, `rate`, `admin_approval`, `order_id`, `created_at`, `updated_at`) VALUES
(1, 17, 'test', 3, 1, 1, '2020-03-22 06:19:48', '2020-03-22 06:19:48'),
(2, 21, 'test', 4, 1, 1, '2020-04-07 20:37:47', '2020-04-15 17:45:26'),
(3, 25, 'اهلا وسهلا', 5, 1, 1, '2020-04-12 20:03:13', '2020-04-15 17:45:01'),
(4, 26, 'Hhh', 5, 1, 1, '2020-04-13 13:44:29', '2020-04-15 17:45:24'),
(5, 27, 'تجربة إرسال تقييم من البوستمان', 4, 1, 1, '2020-04-15 17:10:00', '2020-04-15 17:12:48'),
(6, 27, 'this product is very sweet and good packing', 5, 1, 2, '2020-04-15 17:44:48', '2020-04-15 17:44:58'),
(7, 27, 'this product is very sweet and good packing', 5, 1, 3, '2020-04-15 17:46:26', '2020-04-15 17:46:35'),
(8, 27, 'this product is very sweet and good packing', 5, 1, 5, '2020-04-15 17:50:07', '2020-04-15 17:50:52'),
(9, 27, 'this product is very sweet and good packing', 5, 1, 4, '2020-04-15 17:50:32', '2020-04-15 17:50:53'),
(10, 27, 'this product is very sweet and good packing', 5, 1, 6, '2020-04-15 17:51:53', '2020-04-15 17:52:16'),
(11, 27, 'test', 3, 0, 10, '2020-04-21 12:31:24', '2020-04-21 12:31:24'),
(12, 27, 'test', 4, 0, 100, '2020-04-21 12:31:38', '2020-04-21 12:31:38'),
(13, 27, 'test', 4, 0, 111, '2020-04-21 12:38:58', '2020-04-21 12:38:58'),
(14, 27, 'على فكره في صوره صباحيه رسائل اسلامية رسائل نكت', 4, 0, 112, '2020-04-21 12:40:55', '2020-04-21 12:40:55'),
(15, 27, 'test', 4, 0, 141, '2020-04-21 12:43:28', '2020-04-21 12:43:28'),
(16, 27, 'تحميل برنامج ايه يا عم الشيخ الحويني في مجال المبيعات اونلاين', 5, 0, 156, '2020-04-21 13:00:52', '2020-04-21 13:00:52'),
(17, 27, 'على فكره في صوره صباحيه رسائل اسلامية رسائل نكت', 4, 0, 166, '2020-04-21 13:07:01', '2020-04-21 13:07:01'),
(18, 22, 'test', 3, 0, 1, '2020-04-29 17:43:38', '2020-04-29 17:43:38');

-- --------------------------------------------------------

--
-- Table structure for table `retrieves`
--

CREATE TABLE `retrieves` (
  `id` int(11) NOT NULL,
  `refund_number` varchar(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `reason` text NOT NULL,
  `admin_seen` int(11) NOT NULL DEFAULT '0',
  `seen` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `retrieves`
--

INSERT INTO `retrieves` (`id`, `refund_number`, `item_id`, `user_id`, `store_id`, `reason`, `admin_seen`, `seen`, `created_at`, `updated_at`) VALUES
(8, '7dr8plwo8', 2, 34, 1, 'test', 1, 0, '2020-10-14 15:15:16', '2020-10-14 15:18:12');

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE `sellers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `shop` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `id_number` varchar(255) NOT NULL,
  `instagram` varchar(255) NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `front_image` varchar(255) NOT NULL,
  `back_image` varchar(255) NOT NULL,
  `details` text,
  `seen` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sellers`
--

INSERT INTO `sellers` (`id`, `name`, `shop`, `phone`, `id_number`, `instagram`, `account_number`, `front_image`, `back_image`, `details`, `seen`, `created_at`, `updated_at`) VALUES
(1, 'Islam Ahmed Shalaby', 'Le monde', '01142849437', '01142849437', 'https://www.google.com/', '2323566', 'rwgx8ocp3328gfvmyolk.jpg', 'f8ojoln2tongcs6m7u6c.jpg', 'test', 1, '2020-09-07 10:25:10', '2020-09-28 06:35:40'),
(2, 'Ahmed Salah', 'London', '01255668599', '25355223665533', 'https://stackoverflow.com/questions/25849015/laravel-eloquent-where-not-in', '3556556', 'front_final_m4bkxq.jpg', 'car_iplbkf.png', 'test', 1, '2020-09-13 08:00:53', '2020-09-13 08:16:18');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `app_phone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `termsandconditions_en` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `termsandconditions_ar` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `aboutapp_en` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `aboutapp_ar` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `app_name_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `app_name_ar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(350) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_ar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook` text COLLATE utf8mb4_unicode_ci,
  `youtube` text COLLATE utf8mb4_unicode_ci,
  `twitter` text COLLATE utf8mb4_unicode_ci,
  `instegram` text COLLATE utf8mb4_unicode_ci,
  `map_url` text COLLATE utf8mb4_unicode_ci,
  `latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `snap_chat` text COLLATE utf8mb4_unicode_ci,
  `delivery_information_en` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_information_ar` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `return_policy_en` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `return_policy_ar` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_cost` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `app_phone`, `termsandconditions_en`, `termsandconditions_ar`, `aboutapp_en`, `aboutapp_ar`, `created_at`, `updated_at`, `app_name_en`, `app_name_ar`, `logo`, `email`, `phone`, `address_en`, `address_ar`, `facebook`, `youtube`, `twitter`, `instegram`, `map_url`, `latitude`, `longitude`, `snap_chat`, `delivery_information_en`, `delivery_information_ar`, `return_policy_en`, `return_policy_ar`, `delivery_cost`) VALUES
(1, '0096598758330', '<p>شروط واحكام الانجليزي</p>', '<p>شروط واحكام العربي</p>', '<p>عن التطبيق انجليزي</p>', '<p>عن التطبيق عربي</p>', '2020-02-05 09:15:45', '2020-09-29 09:54:42', 'Game stores', 'Game stores', 'and0u1era7jlu84wqag6.jpg', 'admin@gmail.com', '0096598758330', 'Kuwait', 'كويت', 'facebook.com', 'youtube.com', 'twitter.com', 'instegram.com', 'https://www.google.com/maps/@30.0430715,31.4056989,16z', '30.0430715', '31.4056989', 'snapchat.com', 'delivery information english text1', 'معلومات التوصيل عربي2', 'Return policy english text1', 'سياسه الإرجاع عربي2', '11.5');

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `show_home` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `logo`, `cover`, `name`, `phone`, `email`, `password`, `seller_id`, `fcm_token`, `status`, `show_home`, `created_at`, `updated_at`) VALUES
(1, 'i1fcywgj7biabuwfx8ba.jpg', 'ucetklagozhvxiecbkid.jpg\n', 'Le monde', '01142849437', 'lemonde@moda.com', '$2y$10$0IhCvPnhk6RkxN8NtxQeCuy3HLJ03W3LXXu.oZ9OZgOeYNIxWPFm6', 1, 'test', 1, 1, '2020-09-08 10:24:53', '2020-11-04 14:29:55'),
(2, 'iazoqktfw9nsylu5iz3f.png\n', 'ihpsaqdzrjbsdfpjxg9v.jpg', 'London', '01255668599', 'london@moda.com', '$2y$10$KTKBSDQYhsIuN/3S/7nqj.3bcxCR.wQTdnOgVFjTDC0n0KClNBPTK', 2, '', 1, 1, '2020-09-13 08:02:43', '2020-09-13 08:02:43');

-- --------------------------------------------------------

--
-- Table structure for table `size_details`
--

CREATE TABLE `size_details` (
  `id` int(11) NOT NULL,
  `tall` varchar(255) DEFAULT NULL,
  `shoulder_width` varchar(255) DEFAULT NULL,
  `chest` varchar(255) DEFAULT NULL,
  `waist` varchar(255) DEFAULT NULL,
  `buttocks` varchar(255) DEFAULT NULL,
  `sleeve` varchar(255) DEFAULT NULL,
  `details` text,
  `type` tinyint(4) NOT NULL DEFAULT '2',
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `size_details`
--

INSERT INTO `size_details` (`id`, `tall`, `shoulder_width`, `chest`, `waist`, `buttocks`, `sleeve`, `details`, `type`, `order_id`, `product_id`, `cart_id`, `created_at`, `updated_at`) VALUES
(3, '160', '70', '85', '73', '65', '89', '', 2, NULL, 100, 3, '2020-09-16 09:06:11', '2020-09-16 09:06:11'),
(4, '160', '70', '85', '73', '65', '89', '', 2, NULL, 100, 3, '2020-09-16 09:08:03', '2020-09-16 09:08:03'),
(5, '140', '60', '70', '63', '70', '86', '', 2, NULL, 100, 12, '2020-09-20 09:27:23', '2020-09-20 09:27:23'),
(6, '140', '60', '70', '63', '70', '86', '', 2, 1, 100, 1, '2020-09-21 06:18:45', '2020-09-27 05:28:18'),
(7, '140', '60', '70', '63', '70', '86', '', 2, NULL, 100, 11, '2020-09-21 07:21:59', '2020-09-21 07:21:59'),
(8, '140', '60', '70', '63', '70', '86', '', 2, 24, 100, 14, '2020-09-21 07:29:26', '2020-09-21 07:29:26'),
(9, '168', '65', '70', '68', '65', '45', 'test', 2, 31, 100, 4, '2020-09-24 09:42:36', '2020-09-24 09:51:15'),
(10, '168', '65', '70', '68', '65', '45', 'test', 2, NULL, 100, 1, '2020-09-27 05:26:34', '2020-09-27 05:26:34');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `type`, `created_at`, `updated_at`) VALUES
(3, 1, '2020-09-10 12:26:05', '2020-09-10 12:26:05'),
(5, 3, '2020-09-13 22:00:00', '2020-09-13 22:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `slider_ads`
--

CREATE TABLE `slider_ads` (
  `id` int(11) NOT NULL,
  `ad_id` int(11) NOT NULL,
  `slider_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `slider_ads`
--

INSERT INTO `slider_ads` (`id`, `ad_id`, `slider_id`, `created_at`, `updated_at`) VALUES
(1, 13, 3, '2020-09-10 12:26:05', '2020-09-10 12:26:05'),
(3, 14, 3, NULL, NULL),
(4, 14, 4, '2020-09-10 13:06:33', '2020-09-10 13:06:33'),
(5, 13, 5, NULL, NULL),
(6, 14, 5, NULL, NULL),
(7, 15, 5, NULL, NULL),
(8, 17, 3, NULL, NULL),
(9, 15, 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stores_categories`
--

CREATE TABLE `stores_categories` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stores_categories`
--

INSERT INTO `stores_categories` (`id`, `store_id`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 1, 11, '2020-09-12 22:00:00', '2020-09-12 22:00:00'),
(2, 1, 11, '2020-09-12 22:00:00', '2020-09-12 22:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` int(11) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `title_ar` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `title_en`, `title_ar`, `image`, `deleted`, `brand_id`, `category_id`, `created_at`, `updated_at`) VALUES
(17, 'اكسسوارات', 'اكسسوارات', NULL, 0, NULL, 19, '2020-09-29 14:43:35', '2020-09-29 14:43:35'),
(18, 'اجهزة', 'اجهزة', NULL, 0, NULL, 19, '2020-09-29 14:45:09', '2020-09-29 14:45:09');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fcm_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `seen` tinyint(1) DEFAULT '0',
  `main_address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `email`, `phone_verified_at`, `password`, `fcm_token`, `verified`, `remember_token`, `created_at`, `updated_at`, `active`, `seen`, `main_address_id`) VALUES
(1, 'mohamed', '+201090751344', 'mohamedbehie@gmail.com', NULL, '$2y$10$u669r76OihgqNPx5BFVjUO360NUS.elP.x0g3FFGqBiotkXKD62SO', 'test fcm token', 1, NULL, '2020-02-06 06:20:35', '2020-02-06 06:43:06', 1, 0, 0),
(2, 'mohamed', '+20109075134', 'mohamedbehie1@gmail.com', NULL, '$2y$10$0rMMj9DAGBFLAUlE1D4s2e9rK3iOcTibaTui2bkLMlhTJ4i0YAMkC', 'test', 1, NULL, '2020-02-06 06:21:56', '2020-02-06 06:21:56', 1, 0, 0),
(3, 'mohamed', '+20109075114', 'mohamedbehie12@gmail.com', NULL, '$2y$10$1Jd32sOBih10OHxgowMiMeBk94fz9YJSIPQ.KTP/zaqtOWTh450IO', 'test', 1, NULL, '2020-02-06 06:25:17', '2020-02-06 06:25:17', 1, 0, 0),
(4, 'mohamed', '+20109075124', 'mohamedbehie112@gmail.com', NULL, '$2y$10$gT9ttYsKKYW63N6mAqDYAeGpQLzlO1rvoLZtNl2R0BFmd6natiPIm', 'test', 1, NULL, '2020-02-06 06:27:50', '2020-02-24 11:37:25', 1, 0, 0),
(5, 'mohamed', '+20109075127', 'mohamedbehie3@gmail.com', NULL, '$2y$10$bYsDCR3kviyRrNKjmCHEIuYVLqWFNqBp9zweObW5Kl9SOcnqiDAMm', 'test', 1, NULL, '2020-02-06 06:29:00', '2020-02-26 13:25:11', 1, 1, 0),
(6, 'mohamed', '+20109075128', 'mohamedbehie34@gmail.com', NULL, '$2y$10$3DAJpqLnNqRuOMp2MGo/XuO4JTH1piGww3wFa51zdN.U6H77uar7K', 'test', 1, NULL, '2020-02-06 06:33:01', '2020-02-06 06:33:01', 1, 0, 0),
(7, 'mohamed', '+201090751285', 'mohamedbehie314@gmail.com', NULL, '$2y$10$dIfZeLaAmBpF/8lVM2tmMOvcf.AMfCFPolZCngQmeSkgJQPiE5a.a', 'test fcm token', 1, NULL, '2020-02-06 06:48:15', '2020-02-26 13:25:20', 0, 1, 0),
(8, 'mohamed', '+2010907512844', 'mohamedbehie3214@gmail.com', NULL, '$2y$10$XhCUw3BAMdI93Uf9ZkV5POQYBtA76rJV2Is4/CMTi9AQu9thv5buK', 'test', 1, NULL, '2020-02-06 06:52:28', '2020-02-06 06:52:28', 1, 0, 0),
(9, 'mohamed', '+2010907512644', 'mohamedbehie30114@gmail.com', NULL, '$2y$10$GMzin8X9RdygVlqnzdiUW.q5wwLWyeEu/bA5sXdFQxNQF1BFv3l/O', 'test fcm token', 1, NULL, '2020-02-06 06:54:03', '2020-02-26 13:24:50', 1, 1, 0),
(10, 'mohamed', '+2010807512644', 'mohamedbehie30614@gmail.com', NULL, '$2y$10$sjHsH28sTozrH6k9gVwq5eX2EYPMVWaTNaDoRYY1PL2FJFSrFnAKa', 'test fcm token', 1, NULL, '2020-02-06 07:05:08', '2020-02-06 07:07:07', 1, 0, 0),
(11, 'mohamed', '+20108075126414', 'mohamedbehie3064@gmail.com', NULL, '$2y$10$C3Cj9oGvQMzc4tyGgkZa9.4nsoTSVjt7bBvNl21f8d2BkBUwo2O8C', 'test', 1, NULL, '2020-02-06 07:52:06', '2020-02-24 11:37:34', 0, 0, 0),
(12, 'Test User', '+147258', 'email@emial.com', NULL, '$2y$10$nJqB.dNSnnhwBhvI9MiAEebblBAfZVUtfQ8PgNo2GoGoBzXafqs7O', NULL, 1, NULL, '2020-02-13 09:03:17', '2020-02-13 09:03:17', 1, 0, 0),
(13, '23Test User', '+201090751347', 'teest2@gmail.com', NULL, '$2y$10$10XcqYsfhh2oInPXU3fd5uzQ.b2JTe2TnFXJqFh7BWlajN/OUxs5a', 'test', 1, NULL, '2020-02-16 07:36:36', '2020-04-13 14:08:58', 1, 0, 0),
(14, '2test u', '+20123456123', 'test@test.com', NULL, '$2y$10$UrVHgj1xs8E2fNW6JHQjtegEh5uM0UYKwMvRUt.g.BRLH5/.9tDfm', NULL, 1, NULL, '2020-02-16 08:59:53', '2020-02-26 13:11:39', 1, 1, 0),
(15, 'Mohamed Behiery 1', '+56985698', 'mohatest@gmail.com', NULL, '$2y$10$02trl9OZeq82fugy0dgj/uJ6uwRGnfkyw4uckKPOUpdEiKImhEHaW', NULL, 1, NULL, '2020-02-24 11:38:46', '2020-02-26 12:59:03', 1, 1, 0),
(16, 'Mohamed Edit', '+20104567893', 'Mohamed231@mohamed.com', NULL, '$2y$10$oSeWKGhSHR78vrOSJotReOPcz/IukxqZCgwdrH8juJ9Jb2Un3/jr2', 'test', 1, NULL, '2020-03-22 04:59:39', '2020-03-22 05:34:28', 1, 0, 0),
(17, 'Mohamed Behiery 1', '+20101234567211', 'mohamed1244@moa14med.com', NULL, '$2y$10$8S0GZp1PnlpkWTfzAm0e7.eHsEgIOKosiPwKNA3OgHJZMVX56UrjC', 'test', 1, NULL, '2020-03-22 06:07:14', '2020-03-22 06:07:14', 1, 0, 0),
(21, 'Mohamed Behiery', '+201012345672115', 'mohamed1244@moha14med.com', NULL, '$2y$10$IVbxLaWxFbSeWxDG2ozDOulTxwhuUC3R3wMWyEy.cYGPJRbAuSZiC', 'test', 1, NULL, '2020-04-01 10:34:47', '2020-04-13 14:10:39', 1, 1, 0),
(22, 'سيف محمود علم الدينt', '+201027027823', 'mahmoud.bussiness2020@gmail.com', NULL, '$2y$10$iJAYuAKu7bhM28QobNWjLO/yRzUb30tjl/1eGLLmbXEdglgXxRqUW', 'test', 1, NULL, '2020-04-02 07:23:05', '2020-04-28 18:11:41', 1, 0, 0),
(23, 'Elsman', '01271665716', 'asd@aaaaa.com', NULL, '$2y$10$8b0OFf9fZrmlFWuEJX89xOWB9Na/LzbtKcBnc.p1bfDlw4hhdj5Gi', 'eHgKItjbGEanly9jdm8tZq:APA91bFcdNdDlyS20FqV9GvNtHXemAMty1lWtCElp3ty-1dI5VHUhOytoaBp4DXTazE_XTANMZ6t0-ioMd-wAhSN2TplKHwsgauZCSwEDpe04BcGjgjQqeBxVUQUERb4SQHKHjPH3AhV', 1, NULL, '2020-04-04 08:48:22', '2020-04-10 15:48:20', 1, 1, 0),
(24, 'hhhgghgg', '01101004396', 'vvghjj@gggg.com', NULL, '$2y$10$kGYGNxGOpar/U.gvMIaO6u4Rq4gJjw/Gn8E0hk51k48UxNonY.2/C', 'esD3fBLML0iHs-UW1WROlj:APA91bGNWjFjd7gAYmA4-v3wQqq_Vxrr27QDYbPvTx9t5VBErzcRamCdF9LNkDbw8-dgZq21aCdGcXEVQsdKJcxvcZA6xBE4EnR2_rCqaUVaIIGFO101RDl6LdzwfAXtLIG00jpaAieL', 1, NULL, '2020-04-09 14:31:24', '2020-04-11 13:25:01', 1, 1, 0),
(25, 'Elsman', '+96555411928', 'asd@aamm.com', NULL, '$2y$10$cGMcizlP3/k8yGWgME8I7.OoE/vRqRfaVuhFN2Afcu/SsN/F5g/HG', 'feKVQcbYBkLYmM7vhxBeej:APA91bGl6GzdFekyv1L9Ke651l4Du_Mir2OIrb7wFNrErPou_gnOrnxZJ-kF0isJ_FyKVuPuMD7Jxa4h6jalPkymilQHBX4zipMVrAeATAZ6YTe5ffvIaZuyhl20_rpLp9yF4C_OKMZx', 1, NULL, '2020-04-12 18:17:31', '2020-04-13 18:53:00', 1, 0, 0),
(26, 'Elsman', '+96555926608', 'asd@assd.com', NULL, '$2y$10$k7Ly9p/Z7I3Ymdwcw1jAdub2X8VtSqu/IQgRO/wLxmoOTh0GX9S9G', 'cNtPQQB7CErdsCFG1pjCRX:APA91bGZPkeZ7TiGFviX1lZsRYp4AAP_LI-rYoJ4jWFu8ynMZKIYK_UAJls8ZqExhixU3VMahPQVbj8GDyNowbjJLOLLWzYAYU9kSNPdEVG0R5lCkORUAG7KhyRwr1ufYJ9DcfYCtZjv', 1, NULL, '2020-04-13 13:42:42', '2020-04-16 10:30:42', 1, 1, 0),
(27, 'حوده علم الدين', '+201110837797', 'mahmoud.alam19733@gmail.com', NULL, '$2y$10$4LtDBN6RqzvCC9A3M05N7ODR8kLQW.3/Id524trsmyQQgcZDTuekq', 'drEk44ywYLY:APA91bFLQRxStBuV-dMsF35EUHMyTcbWTuGFYM0XJHa_TyE4ogrCcYpd5VJFqNIkQGa60iQQRWpfok6wQ9n56O2PFItDbC5-DySlKKaphrQ2DpkPKeyfVtgEfBAUfcIDSL5L7_mbq15J', 1, NULL, '2020-04-14 11:11:21', '2020-08-12 20:01:09', 1, 1, 0),
(28, 'sadad', '123456789', 'fasfasfas@dsfasdfsd.com', NULL, '$2y$10$rD2Io8H2qtTEz3J3RQpjKuktfWSAqg2x9JE3mdlc6.WseM4LDZx2O', NULL, 1, NULL, '2020-04-16 03:43:26', '2020-04-16 03:43:52', 1, 1, 0),
(29, '+96598758330', '+96598758330', 'eswfewfwe@sdfgsdgfsd.com', NULL, '$2y$10$UhVvvQudkkcc3XKbpIarruX4em/8rxSBY9hf4GkUXYkd8CyLMuVQW', NULL, 1, NULL, '2020-04-16 03:45:44', '2020-04-16 03:46:17', 1, 1, 0),
(30, '98758330', '98758330', 'marketing@uffff-smart.co', NULL, '$2y$10$T2Z8rdQTTosdNDL6pCGONOXaglKsqiSS/phNu4J9kPew7dQQoT.KK', NULL, 1, NULL, '2020-04-16 03:47:18', '2020-04-16 03:47:18', 1, 0, 0),
(31, 'hshhsh', '01115353169', 'mostafausmart@gmail.com', NULL, '$2y$10$vtBVB/CJtYqZz4bfdbMNJetRBDkQFkylVFCyTrahSf/Gsksg2K04W', 'csz93Jb7xQ8:APA91bGPpRzFwb4Uz2mHQOXvPRwtGVgem5WeqrDQ-qdSym-qme-xUEwae9bONOLy50q8Xyc4Kz8Cuv6DrmYSm5QS5yMRy_pcbpDQQb7W9kXLBOE6MCkh7qkn95d4QWVXDJz3R0H2ABxG', 1, NULL, '2020-04-23 05:59:13', '2020-08-12 16:31:04', 1, 1, 14),
(32, 'Mohamed', '963852741', 'ki@ki.com', NULL, '$2y$10$3uBSv8Nc2jDIDMHVZCKzeuQkUT988kwhYqBLdirOjQ3sf1eMMDF0m', 'test', 1, NULL, '2020-06-07 01:21:18', '2020-06-07 01:21:18', 1, 0, 0),
(33, 'ahmed', '+201012345678', 'mmm@ttt.com', NULL, '$2y$10$4QQnCAmPa3CN75dSX1PunO7ee3y9nN4MuZtjWMffdZRGBAjJvjycC', 'klkd', 1, NULL, '2020-06-09 15:24:43', '2020-06-09 16:23:20', 1, 0, 1),
(34, 'mkkk', '+2015885546', 'kjdkj@kljjn.com', NULL, '$2y$10$r1U84aOdBTsUUvNinhmxVO9BO4xxG9wGnjOwsaFeMwalgGxT0NsxS', 'test', 1, NULL, '2020-06-21 06:18:06', '2020-07-21 14:02:18', 1, 1, NULL),
(35, 'mkkk', '+20158855469', 'kjdkj@kljjni.com', NULL, '$2y$10$dvf5S6cMztWq5pI5lXpcEeuffqS/DWb6oQm.bIvz6JhkznL/kxjci', 'test', 1, NULL, '2020-06-21 09:36:20', '2020-06-21 09:36:20', 1, 0, NULL),
(36, 'mkkk', '+201271665716', 'asd@asd.com', NULL, '$2y$10$.L63aJxnymY57FJaVL5LaeCEI2VP.X25hX9ggWjARHVkOVeD8BkwC', 'eWukCUNdWUH5rdWENh08cw:APA91bHgEO6rXvoDgD8N2vYKnkU4Q8gmFyWxVxtFBbNGJ8SPRn-KrbK39FBwyFWz8-hUb1sweYfKU-y9cJt0YVolpTP9cii8sqJ4mxmL3tTZcV3TJKLH3SNG0beULs_bVwq5rPWw7DeM', 1, NULL, '2020-07-27 05:39:23', '2020-08-12 16:10:19', 1, 0, 9),
(37, 'مصطفى خضر', '+9650111535316555', 'testfff@test.com', NULL, '$2y$10$P30ICTi5eBijWeGMBya3wO0KqWsqMVLxCK4B43IEtUUuGnZAwpkeW', NULL, 1, NULL, '2020-07-27 09:31:01', '2020-07-27 23:26:11', 1, 0, 4),
(38, 'mostafakhedr', '+96501115353169', 'dasdasad@fsdfsafl.com', NULL, '$2y$10$Wy/BQe3U664rlyu9eC8HJOVo5XggG8n/6eo7OZ63m41nM.LOI/c.C', NULL, 1, NULL, '2020-07-27 09:39:27', '2020-07-27 09:39:27', 1, 0, NULL),
(39, 'ahmed', '+201116344148', 'juba21@live.com', NULL, '$2y$10$wIpn9IHn5OYzun.mzM8Cr.E4AiKe96uuoTa8xtlrVCxEE7jxdlro.', 'f92wzaCIGvA:APA91bE7w74pKdg_xFTq3uIbaUV6TZ3R0Z5pggs14ZKAD3C3BOkR6Bi2q35zuaKV4H2Wv3frOcnSOmgFGZaoHwWKe1BuTpflshj9rGTwx4IxPvtQG0lMvxxowFVvG4HTXSbe0ArnUjD0', 1, NULL, '2020-07-29 01:52:37', '2020-08-12 14:09:21', 1, 1, 20),
(40, 'usmart', '+965123456789', 'fdsfsdfd@dfsdfsd.com', NULL, '$2y$10$VVrEYtfRcxpvmQTqdMG4XOWhYG1iktS4Bx.1l72sLepF0vm1lgizm', 'ehcN7C31O0w:APA91bFBbBVlKPpoYDv6vWlm1cTbJEVSrLIxBbR6xgW-3zgW9SL-Lz8_ynvu7lVpxi0YeFsU3c-IYgUKJNeUfFr83V-SebV2FMJ1g9DFQkZttoBgSxr0rKK80LNa0c4CFbkd48lQ-d09', 1, NULL, '2020-08-09 12:51:54', '2020-09-28 07:51:19', 1, 1, 13);

-- --------------------------------------------------------

--
-- Table structure for table `user_addresses`
--

CREATE TABLE `user_addresses` (
  `id` int(11) NOT NULL,
  `latitude` varchar(100) NOT NULL,
  `longitude` varchar(100) NOT NULL,
  `title` varchar(150) DEFAULT NULL,
  `address_type` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `gaddah` varchar(100) DEFAULT NULL,
  `building` varchar(100) NOT NULL,
  `floor` varchar(100) NOT NULL,
  `apartment_number` varchar(50) NOT NULL,
  `street` varchar(255) NOT NULL,
  `extra_details` text,
  `user_id` int(11) NOT NULL,
  `phone` varchar(40) NOT NULL,
  `piece` varchar(150) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_addresses`
--

INSERT INTO `user_addresses` (`id`, `latitude`, `longitude`, `title`, `address_type`, `area_id`, `gaddah`, `building`, `floor`, `apartment_number`, `street`, `extra_details`, `user_id`, `phone`, `piece`, `created_at`, `updated_at`) VALUES
(1, '31.3', '29.9', 'title', 1, 1, 'gadddah', 'kksk', '454 kk', '44 m', 'sksk', 'extra details', 33, '+2058589656', 'dkdkd', '2020-06-09 15:31:53', '2020-06-09 15:31:53'),
(4, '30.1499067', '31.3679355', 'عنوان جديد', 1, 1, 'gada', '2', '3', '5', 'street', 'iuuuu', 37, '1116344148', 'block', '2020-07-27 23:23:21', '2020-07-27 23:23:21'),
(6, '0.0', '0.0', 'العنوان', 1, 1, '1', '1', '1', '1', '1', '1', 31, '01115353169', '1', '2020-07-28 04:30:25', '2020-07-28 04:30:25'),
(7, '31.33322', '29.9999', 'title', 1, 1, 'gadddah', 'kksk', '454 kk', '44 m', 'sksk', 'extra details', 34, '+2058589656', 'dkdkd', '2020-07-29 07:49:54', '2020-07-29 07:49:54'),
(9, '31.33322', '29.9999', 'title', 1, 1, 'gadddah', 'kksk', '454 kk', '44 m', 'sksk', 'extra details', 36, '+2058589656', 'dkdkd', '2020-08-06 16:45:07', '2020-08-06 16:45:07'),
(10, '31.33322', '29.9999', 'title', 1, 1, 'gadddah', 'kksk', '454 kk', '44 m', 'sksk', 'extra details', 36, '+2058589656', 'dkdkd', '2020-08-06 17:11:12', '2020-08-06 17:11:12'),
(11, '30.1480022', '31.3636562', 'ggggggg', 1, 4, '46446545', '55555', '866', '5565', '4678', '54445r5rr', 40, '899889', '5544', '2020-08-09 12:56:19', '2020-08-09 12:56:19'),
(12, '30.1480219', '31.3636681', 'المنزل رقم ٢', 1, 4, 'الجهراء', '5', '2', '10', 'ش الدمشقي', 'متفرع من ش الاندلسي', 40, '123456789', '5', '2020-08-09 13:18:03', '2020-08-09 13:18:03'),
(13, '0.0', '0.0', 'المنزل ٢', 1, 1, '٥', '10', '3', '10', 'ش الدمشقي', 'متفرع من ش الاندلسي', 40, '123456789', '5', '2020-08-09 13:22:20', '2020-08-09 13:22:20'),
(14, '30.1480499', '31.3636648', 'المنزل', 1, 2, '55', '55', '55', '55', '55', '55', 31, '01115353169', '55', '2020-08-11 10:44:13', '2020-08-11 10:44:13'),
(15, '0.0', '0.0', 'ججكح', 2, 4, 'ال', '808808', '88', '88', 'ل ل', 'ة ا', 39, '11163555', 'نغىا ا', '2020-08-12 11:47:21', '2020-08-12 11:47:21'),
(20, '0.0', '0.0', 'lllo', 2, 4, 'jj', '66', '6', '6', 'nj', 'u', 39, '868686866', 'jjj', '2020-08-12 14:06:04', '2020-08-12 14:06:04'),
(21, '31.33322', '29.9999', 'title', 2, 5, 'gadddah', 'kksk', '454 kk', '44 m', 'sksk', 'extra details', 34, '+2058589656', 'dkdkd', '2020-10-12 08:52:46', '2020-10-12 08:52:46');

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `notification_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_notifications`
--

INSERT INTO `user_notifications` (`id`, `user_id`, `notification_id`, `created_at`, `updated_at`) VALUES
(1, 23, 25, '2020-04-05 15:46:01', '2020-04-05 15:46:01'),
(2, 23, 26, '2020-04-05 15:52:55', '2020-04-05 15:52:55'),
(3, 24, 27, '2020-04-09 15:56:16', '2020-04-09 15:56:16'),
(4, 24, 31, '2020-04-12 09:33:44', '2020-04-12 09:33:44'),
(5, 24, 32, '2020-04-12 09:41:37', '2020-04-12 09:41:37'),
(6, 1, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(7, 2, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(8, 3, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(9, 4, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(10, 5, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(11, 6, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(12, 7, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(13, 8, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(14, 9, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(15, 10, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(16, 11, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(17, 16, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(18, 17, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(19, 21, 34, '2020-04-12 09:43:55', '2020-04-12 09:43:55'),
(20, 22, 34, '2020-04-12 09:43:56', '2020-04-12 09:43:56'),
(21, 23, 34, '2020-04-12 09:43:56', '2020-04-12 09:43:56'),
(22, 24, 34, '2020-04-12 09:43:56', '2020-04-12 09:43:56'),
(23, 1, 35, '2020-04-12 09:44:14', '2020-04-12 09:44:14'),
(24, 2, 35, '2020-04-12 09:44:14', '2020-04-12 09:44:14'),
(25, 3, 35, '2020-04-12 09:44:14', '2020-04-12 09:44:14'),
(26, 4, 35, '2020-04-12 09:44:14', '2020-04-12 09:44:14'),
(27, 5, 35, '2020-04-12 09:44:14', '2020-04-12 09:44:14'),
(28, 6, 35, '2020-04-12 09:44:14', '2020-04-12 09:44:14'),
(29, 7, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(30, 8, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(31, 9, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(32, 10, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(33, 11, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(34, 16, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(35, 17, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(36, 21, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(37, 22, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(38, 23, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(39, 24, 35, '2020-04-12 09:44:15', '2020-04-12 09:44:15'),
(40, 24, 36, '2020-04-12 12:58:35', '2020-04-12 12:58:35'),
(41, 24, 37, '2020-04-12 13:32:38', '2020-04-12 13:32:38'),
(42, 24, 38, '2020-04-12 13:34:26', '2020-04-12 13:34:26'),
(43, 27, 39, '2020-04-15 09:20:42', '2020-04-15 09:20:42'),
(44, 27, 40, '2020-04-15 10:20:21', '2020-04-15 10:20:21'),
(45, 27, 41, '2020-04-15 10:23:02', '2020-04-15 10:23:02'),
(46, 27, 42, '2020-04-15 10:27:35', '2020-04-15 10:27:35'),
(47, 1, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(48, 2, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(49, 3, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(50, 4, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(51, 5, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(52, 6, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(53, 7, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(54, 8, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(55, 9, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(56, 10, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(57, 11, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(58, 13, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(59, 16, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(60, 17, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(61, 21, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(62, 22, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(63, 23, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(64, 24, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(65, 25, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(66, 26, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(67, 27, 43, '2020-04-15 10:28:28', '2020-04-15 10:28:28'),
(68, 1, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(69, 2, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(70, 3, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(71, 4, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(72, 5, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(73, 6, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(74, 7, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(75, 8, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(76, 9, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(77, 10, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(78, 11, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(79, 13, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(80, 16, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(81, 17, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(82, 21, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(83, 22, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(84, 23, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(85, 24, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(86, 25, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(87, 26, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(88, 27, 44, '2020-04-15 10:29:11', '2020-04-15 10:29:11'),
(89, 27, 45, '2020-04-15 10:29:54', '2020-04-15 10:29:54'),
(90, 27, 46, '2020-04-15 10:30:15', '2020-04-15 10:30:15'),
(91, 27, 47, '2020-04-15 10:32:31', '2020-04-15 10:32:31'),
(92, 27, 48, '2020-04-15 10:33:07', '2020-04-15 10:33:07'),
(93, 27, 49, '2020-04-20 18:24:03', '2020-04-20 18:24:03'),
(94, 27, 50, '2020-04-20 18:25:24', '2020-04-20 18:25:24');

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `id` int(11) NOT NULL,
  `unique_id` varchar(350) NOT NULL,
  `type` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visitors`
--

INSERT INTO `visitors` (`id`, `unique_id`, `type`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'hdjhjkdhdllkyeygsfsfsdhdlppopooiuysg', 1, NULL, '2020-06-17 22:21:00', '2020-06-17 22:21:00'),
(2, 'dklkdlkdklldkdlkkldk', 1, 35, '2020-06-21 06:18:06', '2020-08-16 12:57:50'),
(3, 'jkjkjjkjkjkjkjjkgffdddsssdfjjl', 1, NULL, '2020-06-21 10:10:15', '2020-06-21 10:10:15'),
(4, 'jkjkjjkjkjkjkjjkgffdddsssdfjjl', 1, NULL, '2020-06-21 10:10:28', '2020-06-21 10:10:28'),
(5, 'jkjkjjkjkjkjkjjkgffdddsssdfjjl', 1, NULL, '2020-06-21 10:10:39', '2020-06-21 10:10:39'),
(6, 'jkjkjjkjkjkjkjjkgffdddsssdfjjlp', 1, 34, '2020-06-21 10:13:37', '2020-06-21 10:13:37'),
(7, 'a6b555ac991f43f0', 2, 31, '2020-07-26 16:58:26', '2020-08-11 09:46:32'),
(8, 'a43bfc13ec52cd13', 2, 39, '2020-07-26 17:20:07', '2020-07-29 01:52:37'),
(9, '579e4f3d0c1d0d80', 2, NULL, '2020-07-26 18:32:28', '2020-07-26 18:32:28'),
(10, '7B5D09E6-424E-40F4-BDBE-D9D8AC52133A', 1, 36, '2020-07-27 05:39:34', '2020-07-27 05:39:34'),
(11, 'facf9a38f3be31c1', 2, NULL, '2020-07-27 05:41:09', '2020-07-27 05:41:09'),
(12, '9cca78762cda479d', 2, NULL, '2020-07-27 09:24:04', '2020-07-27 09:24:04'),
(13, 'add37dfbf795d0e4', 2, NULL, '2020-07-28 06:58:06', '2020-07-28 06:58:06'),
(14, '049ffc8fa94f044c', 2, NULL, '2020-07-30 18:08:03', '2020-07-30 18:08:03'),
(15, '572af0c5431cca21', 2, NULL, '2020-07-31 13:14:09', '2020-07-31 13:14:09'),
(16, '0A5E8E42-3924-4955-BE9C-3DA6E3B713E5', 1, 36, '2020-08-06 15:56:13', '2020-08-06 16:34:22'),
(17, '5562A265-D90B-45FC-982C-96DC405A6F57', 1, NULL, '2020-08-06 18:13:55', '2020-08-06 18:13:55'),
(18, '87E9A083-4753-4EA9-92E5-EABFDFC93FD3', 1, 36, '2020-08-09 10:43:01', '2020-08-09 11:57:44'),
(19, '89786BDF-5CE7-4329-9C28-CFC68E516F17', 1, 36, '2020-08-09 11:58:33', '2020-08-09 11:58:52'),
(20, '7A4022B8-E434-4BD8-AF46-4C659FB74DFB', 1, 36, '2020-08-09 12:04:47', '2020-08-09 12:05:10'),
(21, '86dd364cb9d1d22c', 2, 31, '2020-08-09 16:36:23', '2020-08-11 09:49:49'),
(22, 'e6028277b4103d09', 2, 31, '2020-08-10 12:50:44', '2020-08-10 12:53:18'),
(23, 'b526115931bfadd7', 2, NULL, '2020-08-11 09:43:07', '2020-08-11 09:43:07'),
(24, 'F751DCB3-6DDF-4123-9002-582A2A81C60E', 1, 36, '2020-08-12 16:10:00', '2020-08-12 16:10:19'),
(25, '1681b6ea7f3ecfa0', 2, 27, '2020-08-12 19:58:50', '2020-08-12 20:01:09');

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` int(11) NOT NULL,
  `balance` varchar(255) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`id`, `balance`, `user_id`, `created_at`, `updated_at`) VALUES
(2, '37', 34, '2020-10-14 12:16:52', '2020-10-14 12:48:21');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_transactions`
--

CREATE TABLE `wallet_transactions` (
  `id` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `wallet_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wallet_transactions`
--

INSERT INTO `wallet_transactions` (`id`, `value`, `user_id`, `wallet_id`, `created_at`, `updated_at`) VALUES
(1, '25', 34, 2, '2020-10-14 12:16:52', '2020-10-14 12:16:52'),
(3, '12', 34, 2, '2020-10-14 12:48:22', '2020-10-14 12:48:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_permissions`
--
ALTER TABLE `admin_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_us`
--
ALTER TABLE `contact_us`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `control_offers`
--
ALTER TABLE `control_offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_areas`
--
ALTER TABLE `delivery_areas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gold_prices`
--
ALTER TABLE `gold_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_elements`
--
ALTER TABLE `home_elements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_sections`
--
ALTER TABLE `home_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `main_orders`
--
ALTER TABLE `main_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meta_tags`
--
ALTER TABLE `meta_tags`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `multi_options`
--
ALTER TABLE `multi_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `multi_options_categories`
--
ALTER TABLE `multi_options_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `multi_options_sub_categories`
--
ALTER TABLE `multi_options_sub_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `multi_option_values`
--
ALTER TABLE `multi_option_values`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offers_sections`
--
ALTER TABLE `offers_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `options_categories`
--
ALTER TABLE `options_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `options_sub_categories`
--
ALTER TABLE `options_sub_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `option_values`
--
ALTER TABLE `option_values`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`(191));

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_multi_options`
--
ALTER TABLE `product_multi_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_options`
--
ALTER TABLE `product_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_properties`
--
ALTER TABLE `product_properties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_types`
--
ALTER TABLE `product_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `properties_categories`
--
ALTER TABLE `properties_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rates`
--
ALTER TABLE `rates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `retrieves`
--
ALTER TABLE `retrieves`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `size_details`
--
ALTER TABLE `size_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slider_ads`
--
ALTER TABLE `slider_ads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stores_categories`
--
ALTER TABLE `stores_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `admin_permissions`
--
ALTER TABLE `admin_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=276;
--
-- AUTO_INCREMENT for table `ads`
--
ALTER TABLE `ads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `contact_us`
--
ALTER TABLE `contact_us`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `control_offers`
--
ALTER TABLE `control_offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `delivery_areas`
--
ALTER TABLE `delivery_areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `gold_prices`
--
ALTER TABLE `gold_prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `home_elements`
--
ALTER TABLE `home_elements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=174;
--
-- AUTO_INCREMENT for table `home_sections`
--
ALTER TABLE `home_sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `main_orders`
--
ALTER TABLE `main_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `meta_tags`
--
ALTER TABLE `meta_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `multi_options`
--
ALTER TABLE `multi_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `multi_options_categories`
--
ALTER TABLE `multi_options_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `multi_options_sub_categories`
--
ALTER TABLE `multi_options_sub_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `multi_option_values`
--
ALTER TABLE `multi_option_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `offers_sections`
--
ALTER TABLE `offers_sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `options_categories`
--
ALTER TABLE `options_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `options_sub_categories`
--
ALTER TABLE `options_sub_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `option_values`
--
ALTER TABLE `option_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `product_multi_options`
--
ALTER TABLE `product_multi_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_options`
--
ALTER TABLE `product_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_properties`
--
ALTER TABLE `product_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;
--
-- AUTO_INCREMENT for table `product_types`
--
ALTER TABLE `product_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `properties_categories`
--
ALTER TABLE `properties_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `rates`
--
ALTER TABLE `rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `retrieves`
--
ALTER TABLE `retrieves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `size_details`
--
ALTER TABLE `size_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `slider_ads`
--
ALTER TABLE `slider_ads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `stores_categories`
--
ALTER TABLE `stores_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;
--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
