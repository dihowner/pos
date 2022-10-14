-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 28, 2022 at 11:44 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 8.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `valuesales`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `fullname`, `username`, `password`, `email`, `mobile`, `date_created`) VALUES
(1, 'Oluwatayo Adeyemi', 'dihowner', '$2y$10$WKXug/S.rDWf.Xn2efnjROgQtbol9L0GMGmJGLGU.8/I3XvozmUNy', 'oluwatayoadeyemi@yahoo.com', '09033024846', '2022-07-13 13:41:11'),
(3, 'Valuemax Communication', 'valuemax', '$2y$10$GpgbdJYRJ9PurjQHe7vjUOe31pc740QNypqiQurrQRiy5zNA16Fti', 'valuemax_2022@gmail.com', '07032060088', '2022-07-17 19:57:46');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(255) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `category_name`, `description`, `date_created`) VALUES
(1, 'Earbud', 'This is a test', '2022-07-14 11:05:45'),
(3, 'Computers', 'Keyboard, wifi, wirless mouse', '2022-07-14 12:12:42'),
(5, 'Antivirus', 'Get secured', '2022-07-14 22:12:15');

-- --------------------------------------------------------

--
-- Table structure for table `checkout`
--

CREATE TABLE `checkout` (
  `id` bigint(20) NOT NULL,
  `admin_id` bigint(20) NOT NULL,
  `sales_reference` bigint(20) NOT NULL,
  `type` enum('deliver','cancel') NOT NULL DEFAULT 'deliver',
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `checkout`
--

INSERT INTO `checkout` (`id`, `admin_id`, `sales_reference`, `type`, `date`) VALUES
(1, 1, 7819560358, 'deliver', '2022-07-22 04:42:22'),
(2, 1, 2934087638, 'deliver', '2022-07-22 22:26:50'),
(3, 1, 2934087638, 'deliver', '2022-07-22 22:32:08'),
(4, 1, 2934087638, 'deliver', '2022-07-22 22:39:35'),
(5, 1, 2934087638, 'deliver', '2022-07-22 22:40:10'),
(6, 1, 2934087638, 'deliver', '2022-07-22 22:41:44'),
(7, 1, 2934087638, 'cancel', '2022-07-23 06:40:50'),
(8, 1, 2934087638, 'cancel', '2022-07-23 06:57:21'),
(9, 1, 2934087638, 'cancel', '2022-07-23 06:59:35'),
(10, 1, 2934087638, 'deliver', '2022-07-23 07:01:36'),
(11, 1, 4266774464, 'deliver', '2022-07-23 16:21:23'),
(12, 1, 8270228637, 'deliver', '2022-07-23 18:25:04');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(255) NOT NULL,
  `coupon_code` varchar(25) NOT NULL,
  `amount` varchar(255) NOT NULL,
  `coupon_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 is inactive',
  `date_expired` datetime NOT NULL DEFAULT current_timestamp(),
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `coupon_code`, `amount`, `coupon_status`, `date_expired`, `date_created`) VALUES
(1, 'DY892716', '2000', 1, '2022-07-19 11:51:02', '2022-07-18 00:51:02'),
(3, 'HG29002', '2000', 0, '2022-08-15 00:00:00', '2022-07-27 03:57:23'),
(4, 'HG2902', '2500', 0, '2022-08-15 00:00:00', '2022-07-27 03:59:13');

-- --------------------------------------------------------

--
-- Table structure for table `daily_update`
--

CREATE TABLE `daily_update` (
  `id` bigint(20) NOT NULL,
  `stock_unique_id` varchar(25) NOT NULL,
  `opening_stock` int(11) NOT NULL,
  `closing_stock` int(11) DEFAULT NULL,
  `stock_difference` int(11) DEFAULT NULL,
  `pending` int(11) NOT NULL DEFAULT 0,
  `sales_amount` float(10,2) DEFAULT NULL,
  `sales_discount` float(10,2) DEFAULT NULL,
  `profit` float(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `daily_update`
--

INSERT INTO `daily_update` (`id`, `stock_unique_id`, `opening_stock`, `closing_stock`, `stock_difference`, `pending`, `sales_amount`, `sales_discount`, `profit`) VALUES
(1, '000843', 10, 8, 1, 1, 7000.00, 0.00, 7000.00),
(2, '000842', 9, 9, 0, 0, 0.00, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `title`, `slug`, `date_created`) VALUES
(1, 'Login', 'login', '2022-07-13 05:50:23'),
(2, 'Dashboard', 'dashboard', '2022-07-13 05:50:23'),
(3, 'Categories', 'category', '2022-07-13 05:50:23'),
(4, 'Create Stock', 'addStock', '2022-07-13 05:50:23'),
(5, 'Available Stock', 'availableStock', '2022-07-14 23:55:02'),
(6, 'Update Stock Quantity', 'updateStockQty', '2022-07-14 23:55:02'),
(7, 'Stock Search', 'stockSearch', '2022-07-14 23:55:02'),
(8, 'Out Of Stock', 'unavailableStock', '2022-07-14 23:55:02'),
(9, 'Stock Quantity Update History', 'quantityUpdateHistory', '2022-07-16 13:00:37'),
(10, 'Create Admin', 'createAdmin', '2022-07-16 13:00:37'),
(11, 'Our Admins', 'adminList', '2022-07-16 13:00:37'),
(12, 'Set Cost Price', 'setCostPrice', '2022-07-16 13:00:37'),
(13, 'Sell To Buyer', 'makePurchase', '2022-07-16 13:00:37'),
(14, 'All Purchase History', 'purchaseHistory', '2022-07-16 13:00:37'),
(15, 'All Cashier History', 'allCashierHistory', '2022-07-16 13:00:37'),
(16, 'Invoice Receipt', 'generateInvoice', '2022-07-16 13:00:37'),
(17, 'Sales Checkout', 'salesCheckout', '2022-07-20 14:37:16'),
(18, 'Payment Receipt', 'paymentReceipt', '2022-07-20 14:37:16'),
(19, 'Cashier Sales Point', 'cashierSalesPoint', '2022-07-20 14:37:16'),
(20, 'Checkout History', 'checkoutHistory', '2022-07-16 13:00:37'),
(21, 'My Purchase History', 'myPurchaseHistory', '2022-07-16 13:00:37'),
(22, 'My Cashier History', 'myCashierHistory', '2022-07-16 13:00:37'),
(23, 'Stock Update', 'stockUpdate', '2022-07-23 14:36:27'),
(24, 'Stock Update Archive History', 'stockUpdateArchiveHistory', '2022-07-23 14:36:27'),
(25, 'Coupon Management', 'coupons', '2022-07-13 05:50:23'),
(26, 'System Settings', 'system-settings', '2022-07-13 05:50:23');

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `id` bigint(20) NOT NULL,
  `name` varchar(75) NOT NULL,
  `use_case` set('fundWallet','makePurchase','payLoan') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`id`, `name`, `use_case`, `created_at`, `created_by`) VALUES
(1, 'Point', 'makePurchase', '2022-01-17 09:55:34', NULL),
(2, 'Debit Card (POS)', 'fundWallet,makePurchase,payLoan', '2022-01-17 09:55:34', NULL),
(3, 'Bank Transfer', 'fundWallet,makePurchase,payLoan', '2022-01-17 09:55:34', NULL),
(4, 'Cash', 'fundWallet,makePurchase,payLoan', '2022-01-17 09:55:34', NULL),
(5, 'Loan', 'fundWallet', '2022-01-17 09:55:34', NULL),
(6, 'Wallet', 'makePurchase', '2022-01-17 09:55:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) NOT NULL,
  `reference` varchar(25) NOT NULL,
  `waiter_id` varchar(15) NOT NULL,
  `cashier_id` bigint(20) DEFAULT NULL,
  `total_discount` float(10,2) NOT NULL DEFAULT 0.00,
  `grand_total` float(10,2) NOT NULL,
  `payment_method` int(11) NOT NULL,
  `payment_status` enum('0','1','2','3','4') NOT NULL,
  `delivery_status` enum('0','1','2','3','4') NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `reference`, `waiter_id`, `cashier_id`, `total_discount`, `grand_total`, `payment_method`, `payment_status`, `delivery_status`, `date`) VALUES
(2, '4266774464', '1', 1, 0.00, 103250.00, 4, '1', '1', '2022-07-23 16:20:59'),
(3, '4992582011', '1', NULL, 0.00, 7000.00, 4, '0', '0', '2022-07-23 16:26:20'),
(4, '8270228637', '1', 1, 0.00, 7000.00, 4, '1', '1', '2022-07-23 18:24:00');

-- --------------------------------------------------------

--
-- Table structure for table `sales_item`
--

CREATE TABLE `sales_item` (
  `id` bigint(20) NOT NULL,
  `sales_reference` varchar(25) NOT NULL,
  `stock_unique_id` varchar(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` float(10,2) NOT NULL,
  `discount` float(10,2) NOT NULL DEFAULT 0.00,
  `sub_total` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sales_item`
--

INSERT INTO `sales_item` (`id`, `sales_reference`, `stock_unique_id`, `quantity`, `unit_price`, `discount`, `sub_total`) VALUES
(3, '4266774464', '000843', 2, 3500.00, 0.00, 7000.00),
(4, '4266774464', '000842', 7, 13750.00, 0.00, 96250.00),
(5, '4992582011', '000843', 2, 3500.00, 0.00, 7000.00),
(6, '8270228637', '000843', 2, 3500.00, 0.00, 7000.00);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` varchar(255) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `date_updated`) VALUES
(1, 'site_title', 'Value Sales', '2022-07-27 17:36:49'),
(2, 'office_address_1', 'White House, South Campus', '2022-07-27 17:36:49'),
(3, 'office_address_2', 'The Polytechnic, Ibadan, Sango, Ibadan, Nigeria', '2022-07-27 17:36:49'),
(4, 'site_email', 'sales@tixia.com', '2022-07-27 17:36:49'),
(5, 'office_phone', '09033024846,09066865915', '2022-07-23 15:16:41'),
(6, 'invoice_info', 'You are expected to tender this receipt with the cashier to process your payment', '2022-07-27 17:36:49'),
(7, 'receipt_info_1', 'Goods sold in good condition can not be returned. No refund of money after payment. ', '2022-07-23 15:16:41'),
(8, 'receipt_info_2', 'Thanks for your patronage', '2022-07-23 15:16:41'),
(9, 'default_user_password', 'peaksystem123', '2022-07-27 17:36:49'),
(10, 'stock_status', 'closed', '2022-07-23 18:25:44'),
(11, 'stock_last_opened', '2022-07-23 18:22:01', '2022-07-23 18:22:01'),
(12, 'stock_last_closed', '2022-07-23 18:25:44', '2022-07-23 18:25:44'),
(13, 'stock_opened_by', '1', '2022-07-23 18:22:01'),
(14, 'stock_closed_by', '1', '2022-07-23 18:25:44');

-- --------------------------------------------------------

--
-- Table structure for table `stock_in`
--

CREATE TABLE `stock_in` (
  `id` bigint(20) NOT NULL,
  `stock_name` varchar(50) NOT NULL,
  `stock_unique_id` varchar(50) DEFAULT NULL,
  `stock_category_id` smallint(6) NOT NULL DEFAULT 0,
  `stock_costprice` float(10,2) NOT NULL DEFAULT 0.00,
  `stock_price` float(10,2) NOT NULL DEFAULT 0.00,
  `stock_qty` int(11) NOT NULL DEFAULT 0,
  `stock_description` longtext DEFAULT NULL,
  `memo` longtext NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stock_in`
--

INSERT INTO `stock_in` (`id`, `stock_name`, `stock_unique_id`, `stock_category_id`, `stock_costprice`, `stock_price`, `stock_qty`, `stock_description`, `memo`, `date_created`, `date_updated`) VALUES
(860, 'Tecno H3 hipods', '000842', 1, 12200.00, 13750.00, 9, 'Tecno H3 hipods', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-04 17:53:57', '2022-07-23 16:19:08'),
(861, 'Oraimo powercube 3pro Ocw U940', '000843', 5, 3200.00, 3500.00, 8, 'Oraimo powercube 3pro Ocw U940', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-04 17:56:09', '2022-07-23 16:18:53'),
(862, 'Single wired PC Gamepad', '000844', 3, 0.00, 0.00, 0, 'Single wired PC Gamepad', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:21:50', NULL),
(863, 'Single wireless PC Gamepad', '000845', 3, 0.00, 0.00, 0, 'Single wireless PC Gamepad', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:24:08', NULL),
(864, '3388 professional tripod stand with remote', '000846', 3, 0.00, 0.00, 0, '3388 professional tripod stand with remote', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:26:18', NULL),
(865, 'Logitech M171 wireless mouse', '000847', 1, 0.00, 0.00, 0, 'Logitech M171 wireless mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:27:06', NULL),
(866, 'Logitech M185 wireless mouse', '000848', 5, 0.00, 0.00, 0, 'Logitech M185 wireless mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:27:44', NULL),
(867, 'Havit Wireless Gamepad ', '000849', 3, 0.00, 0.00, 0, 'Havit Wireless Gamepad ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:28:31', NULL),
(868, 'Logitech M186 wireless mouse', '000850', 5, 0.00, 0.00, 0, 'Logitech M186 wireless mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:29:04', NULL),
(869, 'PC  camera Standing webcam', '000851', 1, 0.00, 0.00, 0, 'PC  camera Standing webcam', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:29:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stock_ins`
--

CREATE TABLE `stock_ins` (
  `id` bigint(20) NOT NULL,
  `stock_name` varchar(50) NOT NULL,
  `stock_unique_id` varchar(50) DEFAULT NULL,
  `stock_category_id` smallint(6) NOT NULL DEFAULT 0,
  `stock_costprice` float(10,2) NOT NULL DEFAULT 0.00,
  `stock_price` float(10,2) NOT NULL DEFAULT 0.00,
  `stock_qty` int(11) NOT NULL DEFAULT 0,
  `stock_description` longtext DEFAULT NULL,
  `memo` longtext NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stock_ins`
--

INSERT INTO `stock_ins` (`id`, `stock_name`, `stock_unique_id`, `stock_category_id`, `stock_costprice`, `stock_price`, `stock_qty`, `stock_description`, `memo`, `date_created`, `date_updated`) VALUES
(1, 'Gaming Mouse MS1022', '000049', 1, 3000.00, 0.00, 1, 'HAVIT NIGERIA', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-21 18:16:58', NULL),
(14, 'Laptop Cooling Fan 2051', '000051', 1, 4500.00, 0.00, 3, 'Cooling Fan', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:19:27', NULL),
(15, 'Power bank 10,000 MaH', '000050', 1, 4000.00, 0.00, 2, 'Fast Charging power bank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:21:49', NULL),
(16, 'Earbud TW935', '000052', 5, 4000.00, 0.00, 0, 'Bluetooth Earbud', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:23:02', NULL),
(18, '4-Port charger H18', '000053', 5, 1700.00, 0.00, 3, 'Multiple mobile charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:26:12', NULL),
(19, '3-Port Charger UC2026', '000054', 1, 1800.00, 2200.00, 3, 'Multiple Mobile Charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:29:45', NULL),
(20, 'USB Speaker 482', '000055', 1, 3500.00, 0.00, 0, 'Computer speaker', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:31:58', NULL),
(21, 'Headset H139D', '000056', 1, 3000.00, 0.00, 0, 'System headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:33:50', NULL),
(22, 'Tripod With Light', '000057', 3, 9500.00, 0.00, 4, 'Mobile tripod', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:35:03', NULL),
(23, 'Earbud TW938', '000058', 1, 8000.00, 0.00, 1, 'Mobile audio', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:36:01', NULL),
(24, 'USB Speakers 427', '000059', 1, 3500.00, 0.00, 0, 'System audio', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:37:22', NULL),
(25, 'USB Speakers 473', '000060', 5, 2000.00, 0.00, 5, 'System audio', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:39:10', NULL),
(26, 'Earphone E58', '000061', 1, 1200.00, 0.00, 1, 'Earphone e58', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:50:20', NULL),
(27, 'Wireless Mouse 989', '000062', 1, 1800.00, 0.00, 0, 'Wireless mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:53:05', NULL),
(28, 'Wireless Gamepad G89', '000063', 1, 4500.00, 0.00, 0, 'gamepad accessories', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:54:12', NULL),
(29, 'Car Charger H236', '000064', 5, 800.00, 0.00, 2, 'Car chargers', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:55:13', NULL),
(30, 'Micro Charger CB527', '000065', 1, 1100.00, 0.00, 3, 'Phone charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:57:19', NULL),
(31, 'Speaker SF5626', '000066', 1, 32000.00, 0.00, 1, 'Big speakers', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:58:37', NULL),
(32, 'Speaker SF7700BT', '000067', 1, 23000.00, 0.00, 1, 'Audio speaker', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 13:59:59', NULL),
(33, 'BT Speaker SH 002', '000068', 1, 4500.00, 0.00, 0, 'Audio speakers', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:01:12', NULL),
(34, 'BT Speaker 841BT', '000069', 1, 8000.00, 0.00, 1, 'Audio speakers', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:02:21', NULL),
(35, 'BT Neck Bandd E516', '000070', 1, 4200.00, 0.00, 5, 'mobile neckband', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:06:36', NULL),
(36, 'Trolly Speaker SF105 BT', '000071', 5, 45000.00, 0.00, 1, 'Audio Speaker', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:09:20', NULL),
(37, 'Micro USB Cable', '000072', 1, 600.00, 0.00, 10, 'USB cable for mobile', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:10:33', NULL),
(38, 'Iphone Data Cable LC01', '000017', 1, 950.00, 0.00, 13, 'Iphone Data Cable LC01 (Transparent)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:18:00', NULL),
(40, 'Micro Data cable MC-01', '000018', 1, 820.00, 0.00, 13, 'Micro Data cable MC-01 (Transparent)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:28:07', NULL),
(41, 'Type C Data Cable TC-01', '000019', 5, 880.00, 0.00, 10, 'Type C Data Cable TC-01 (Transparent)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:29:13', NULL),
(42, 'Data Cable CLC-02', '000020', 1, 400.00, 0.00, 18, 'Data Cable CLC-02 (Transparent)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:30:18', NULL),
(43, 'Data Cable CMC-02', '000021', 5, 350.00, 0.00, 21, 'Data Cable CMC-02 (Transparent)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:31:17', NULL),
(44, 'Data Cable CTC-02', '000022', 5, 370.00, 0.00, 13, 'Data Cable CTC-02 (Transparent)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:33:40', NULL),
(45, 'Extension Socket 2USB K01', '000023', 3, 1800.00, 0.00, 10, 'Extension Socket 2USB K01', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:40:44', NULL),
(46, 'Extension Socket 4USB T07', '000024', 3, 2350.00, 0.00, 1, 'Extension Socket 4USB T07', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:45:50', NULL),
(47, 'Extension Socket 3USB T13', '000025', 3, 2250.00, 0.00, 4, 'Extension Socket 3USB T13', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:46:56', NULL),
(48, 'Extension Socket 3USB T56', '000026', 3, 2800.00, 0.00, 9, 'Extension Socket 3USB T56', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:48:10', NULL),
(49, 'USB Mouse MS871', '000034', 1, 800.00, 0.00, 20, 'USB Mouse MS871', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 14:49:31', NULL),
(50, 'USB Mouse MS572', '000035', 1, 720.00, 0.00, 1, 'Havit USB Mouse MS572', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:10:06', NULL),
(51, 'Gaming Mouse 1008', '000036', 1, 2700.00, 0.00, 2, 'Gaming Mouse 1008', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:11:15', NULL),
(52, 'Gaming Mouse MS749', '000037', 1, 2600.00, 0.00, 2, 'Gaming Mouse MS749', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:12:35', NULL),
(53, 'Gaming Mouse MS1025', '000038', 1, 1400.00, 0.00, 7, 'Gaming Mouse MS1025', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:13:17', NULL),
(54, 'Iphone Cable H66', '000039', 1, 600.00, 0.00, 5, 'Iphone Cable H66', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:14:33', NULL),
(55, 'USB Speaker 202', '000040', 1, 3500.00, 0.00, 1, 'USB Speaker 202', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:16:29', NULL),
(56, 'Headset 2105D', '000041', 1, 1600.00, 0.00, 0, 'Headset 2105D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:17:37', NULL),
(57, 'Gaming Headset 2008D', '000042', 1, 9500.00, 0.00, 1, 'Gaming Headset 2008D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:18:37', NULL),
(58, 'USB Keyboard', '000043', 1, 1600.00, 0.00, 9, 'USB Keyboard', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:19:51', NULL),
(59, 'Headset 763', '000044', 5, 3500.00, 0.00, 2, 'Headset 763', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:20:33', NULL),
(60, 'USB Speaker 210 mini', '000045', 1, 1700.00, 0.00, 4, 'USB Speaker 210 mini', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:21:40', NULL),
(61, 'Gaming Mouse MS1003', '000046', 1, 1600.00, 0.00, 1, 'Gaming Mouse MS1003', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:22:41', NULL),
(62, 'Sport Charger 241-US', '000047', 1, 2500.00, 0.00, 3, 'Sport Charger 241-US', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:24:04', NULL),
(63, 'Earphone E303P', '000048', 1, 1100.00, 0.00, 5, 'Earphone E303P', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:24:59', NULL),
(64, 'Earbuds', '000027', 5, 2600.00, 0.00, 4, 'Tecno Earbuds', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:26:10', NULL),
(65, 'USB Cable Type B TCD M11', '000028', 5, 510.00, 0.00, 193, 'USB Cable Type B TCD M11', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:27:32', NULL),
(66, 'Memory Card 8GB', '000029', 1, 2000.00, 0.00, 18, 'Memory Card 8GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:28:34', NULL),
(67, 'Memory Card 16GB', '000030', 1, 2400.00, 0.00, 16, 'Memory Card 16GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:29:23', NULL),
(68, 'Powerbank 20,000MaH', '000031', 1, 7500.00, 0.00, 16, 'Powerbank 20,000MaH', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:30:12', NULL),
(69, 'Travel Charger', '000032', 1, 1550.00, 0.00, 83, 'Travel Charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:30:50', NULL),
(70, 'Headset', '000033', 1, 14700.00, 0.00, 2, 'Tecno Headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:31:39', NULL),
(71, 'Power Bank 6,000MaH', '000001', 1, 2480.00, 0.00, 11, 'Power Bank 6,000MaH', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:32:52', NULL),
(72, 'Power Bank 20,000MaH', '000002', 1, 7100.00, 0.00, 6, 'Power Bank 20,000MaH', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:33:30', NULL),
(73, 'Power Bank 10,000MaH', '000004', 1, 3980.00, 0.00, 1, 'Power Bank 10,000MaH', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:35:53', NULL),
(74, 'Power Bank 16,000MaH', '000005', 1, 5270.00, 0.00, 5, 'Power Bank 16,000MaH', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:36:56', NULL),
(75, 'OTG Flash Drive 16GB', '000006', 3, 3700.00, 0.00, 9, 'OTG Flash Drive 16GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:46:25', NULL),
(76, 'Memory Card 8GB', '000007', 5, 1350.00, 0.00, 13, 'Memory Card 8GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:48:09', NULL),
(77, 'Memory Card 16GB', '000008', 1, 1650.00, 0.00, 9, 'Memory Card 16GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:48:44', NULL),
(78, 'Memory Card 32GB', '000009', 1, 1850.00, 0.00, 19, 'Memory Card 32GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:49:29', NULL),
(79, 'Memory Card 64GB', '000010', 1, 3000.00, 0.00, 8, 'Memory Card 64GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:50:40', NULL),
(80, 'Earphone', '000011', 1, 720.00, 0.00, 18, 'Transparent Earphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:51:46', NULL),
(81, 'Wireless Speaker Green', '000012', 5, 4900.00, 0.00, 4, 'Wireless Speaker Green', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:52:51', NULL),
(82, 'Wireless Speaker Black', '000013', 5, 6400.00, 0.00, 3, 'Wireless Speaker Black', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:53:27', NULL),
(83, 'Bluetooth Headphone', '000014', 1, 5790.00, 0.00, 2, 'Bluetooth Headphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:55:00', NULL),
(84, 'Charger 2USB', '000015', 1, 1400.00, 0.00, 20, 'Charger 2USB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:56:25', NULL),
(85, 'Charger ', '000016', 1, 750.00, 0.00, 8, 'Transparent charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 15:57:29', NULL),
(86, 'Power bank 10,000 MaH fast charging', '000003', 1, 5000.00, 0.00, 12, 'Power bank 10,000 MaH fast charging', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-22 16:06:00', NULL),
(89, 'Handsfree E37', '000073', 1, 1600.00, 0.00, 40, 'Handsfree E37', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:34:33', NULL),
(90, 'Speaker 02S', '000074', 1, 4500.00, 0.00, 4, 'Speaker 02S', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:35:12', NULL),
(91, 'Speaker 52D', '000075', 5, 10900.00, 0.00, 2, 'Speaker 52D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:35:47', NULL),
(92, 'Hand Fan N01', '000076', 3, 3900.00, 0.00, 1, 'Hand Fan N01', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:36:47', NULL),
(93, 'Smart Watch OSW-11', '000077', 1, 13000.00, 0.00, 2, 'Smart Watch OSW-11', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:38:03', NULL),
(94, 'Headset H89D', '000078', 1, 12000.00, 0.00, 9, 'Headset H89D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:38:48', NULL),
(95, 'Sport Buds E95D', '000079', 1, 11100.00, 0.00, 4, 'Sport Buds E95D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:39:51', NULL),
(96, 'EarPods (White) E94D', '000080', 1, 11300.00, 0.00, 3, 'EarPods (White) E94D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:43:03', NULL),
(97, 'Micro USB Cable MS6', '000081', 1, 880.00, 0.00, 57, 'Micro USB Cable MS6', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:52:11', NULL),
(98, 'Car Charger 21D', '000082', 3, 1600.00, 0.00, 3, 'Car Charger 21D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 17:53:06', NULL),
(99, 'Powerbank (20,000MaH) P204DQ', '000083', 1, 9200.00, 0.00, 9, 'Powerbank (20,000MaH) P204DQ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 18:06:41', NULL),
(100, 'Charger U81F', '000084', 1, 3580.00, 0.00, 15, 'Charger U81F', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 18:07:33', NULL),
(101, 'Speaker 91D', '000085', 1, 15300.00, 0.00, 2, 'Speaker 91D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 18:08:09', NULL),
(102, 'Type C Cable C22', '000086', 1, 580.00, 0.00, 1, 'Type C Cable C22', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 18:09:08', NULL),
(103, 'Battery 5C', '000087', 1, 1150.00, 0.00, 13, 'Battery 5C', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 18:09:42', NULL),
(104, 'Bluetooth Earpiece E75D', '000088', 1, 9600.00, 0.00, 14, 'Bluetooth Earpiece E75D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 18:10:56', NULL),
(105, 'Micro USB Cable M53', '000089', 1, 450.00, 0.00, 376, 'Micro USB Cable M53', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 18:11:47', NULL),
(106, 'Micro USB Cable M22', '000090', 1, 450.00, 0.00, 321, 'Micro USB Cable M22', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-23 18:12:25', NULL),
(107, 'Ear phone Black E104D', '000091', 1, 14400.00, 0.00, 9, 'Ear phone Black E104D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:29:13', NULL),
(108, 'Iphone Cable L22', '000092', 1, 650.00, 0.00, 40, 'Iphone Cable L22', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:31:25', NULL),
(109, 'Iphone Cable L53', '000093', 1, 770.00, 0.00, 46, 'Iphone Cable L53', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:32:32', NULL),
(110, 'Earpiece Black E94D', '000094', 1, 11300.00, 0.00, 3, 'Earpiece Black E94D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:34:25', NULL),
(111, 'Type C Cable C53', '000095', 1, 750.00, 0.00, 34, 'Type C Cable C53', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:35:22', NULL),
(112, 'Cable 3 in 1 X92', '000096', 1, 1550.00, 0.00, 56, 'Cable 3 in 1 X92', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:37:07', NULL),
(113, 'Earbuds 2 E92D', '000097', 1, 11800.00, 0.00, 9, 'Earbuds 2 E92D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:38:28', NULL),
(114, 'Charger U36S', '000098', 1, 1200.00, 0.00, 152, 'Charger U36S', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:39:52', NULL),
(115, 'Bluetooth Earpiece Black E74D', '000099', 1, 12500.00, 0.00, 0, 'Bluetooth Earpiece Black E74D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:41:03', NULL),
(116, 'Charger U63D', '000100', 1, 2100.00, 0.00, 123, 'Charger U63D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:48:06', NULL),
(117, 'Car Charger 21DML', '000101', 3, 1900.00, 0.00, 29, 'Car Charger 21DML', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:49:04', NULL),
(118, 'Fitband Tempo OSW-16', '000102', 1, 16700.00, 0.00, 6, 'Fitband Tempo OSW-16', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:50:02', NULL),
(119, 'Charger U93S', '000103', 1, 3250.00, 0.00, 24, 'Charger U93S', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:50:45', NULL),
(120, 'Powerbank 10,000MaH P113D', '000104', 1, 4800.00, 0.00, 11, 'Powerbank 10,000MaH P113D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:51:36', NULL),
(121, 'Charger U65S+L53', '000105', 5, 1950.00, 0.00, 54, 'Charger U65S+L53', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:52:28', NULL),
(122, 'Charger U65S+C53', '000106', 1, 2800.00, 0.00, 49, 'Charger U65S+C53', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:53:19', NULL),
(123, 'Earpiece E345', '000107', 1, 2800.00, 0.00, 37, 'Earpiece E345', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:54:09', NULL),
(124, 'Earpiece E10', '000108', 1, 780.00, 0.00, 143, 'Earpiece E10', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:54:51', NULL),
(125, 'Powerbank 27,000MaH', '000109', 1, 12500.00, 0.00, 15, 'Powerbank 27,000MaH', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:55:28', NULL),
(126, 'Powerbank 20,000MaH P204D', '000110', 1, 7800.00, 0.00, 1, 'Powerbank 20,000MaH P204D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:57:12', NULL),
(127, 'Powerbank 20,000MaH P205D', '000111', 1, 8400.00, 0.00, 7, 'Powerbank 20,000MaH P205D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:57:55', NULL),
(128, 'Powerbank 10,000MaH P110D', '000112', 1, 5400.00, 0.00, 3, 'Powerbank 10,000MaH P110D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:58:48', NULL),
(129, 'Powerbank 10,000MaH P112D', '000113', 5, 5670.00, 0.00, 19, 'Powerbank 10,000MaH P112D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 09:59:26', NULL),
(130, 'Fitband Tempo OSW-20', '000114', 1, 19500.00, 0.00, 6, 'Fitband Tempo OSW-20', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 10:00:29', NULL),
(131, 'Charger 60ZR', '000115', 1, 1750.00, 0.00, 137, 'Charger 60ZR', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2021-12-24 10:01:21', NULL),
(133, 'Laptop charger 18.5V Big Pin', '000155', 5, 2000.00, 0.00, 7, 'Big mouth charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 09:43:06', NULL),
(134, 'Mouse Pad with Wrist Rest', '000123', 5, 900.00, 0.00, 10, 'Mouse Pad with Wrist Rest', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 15:50:51', NULL),
(135, 'Mouse Pad (Microsoft)', '000124', 1, 600.00, 0.00, 5, 'Mouse Pad (Microsoft)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 15:52:35', NULL),
(136, 'Google Chrome Cast', '000148', 3, 21000.00, 0.00, 2, 'Google Chrome Cast', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 15:53:47', NULL),
(137, 'Google Chrome Cast with Google TV-4k', '000149', 3, 38000.00, 0.00, 1, 'Google Chrome Cast with Google TV-4k', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 15:54:46', NULL),
(138, 'USB to HDMI Display Adapter', '000150', 3, 8500.00, 0.00, 3, 'USB to HDMI Display Adapter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 15:58:57', NULL),
(139, 'USB to LAN Ethernet Converter Adapter 3.0', '000128', 3, 3500.00, 0.00, 2, 'USB to LAN Ethernet Converter Adapter 3.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:01:50', NULL),
(140, 'F&K Tech. Laptop Lock', '000129', 3, 1700.00, 0.00, 1, 'F&K Tech. Laptop Lock', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:02:56', NULL),
(141, 'PC USB Bluetooth Adapter 4.0', '000127', 3, 1000.00, 0.00, 6, 'PC USB Bluetooth Adapter 4.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:04:25', NULL),
(142, 'PC USB Bluetooth Adapter 2.0', '000151', 3, 500.00, 0.00, 4, 'PC USB Bluetooth Adapter 2.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:05:22', NULL),
(143, 'USB Sound Card Adapter Double', '000130', 3, 700.00, 0.00, 5, 'USB Sound Card Adapter Double', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:06:52', NULL),
(144, 'USB Sound Card Adapter Single', '000132', 3, 500.00, 0.00, 10, 'USB Sound Card Adapter Single', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:07:48', NULL),
(145, 'HDMI to Mini HDMI Cable', '000126', 3, 1100.00, 0.00, 2, 'HDMI to Mini HDMI Cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:09:32', NULL),
(146, 'SSK Card Reader', '000121', 3, 3000.00, 0.00, 3, 'SSK Card Reader', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:10:28', NULL),
(147, 'Printer USB Cable 1.5m', '000125', 3, 600.00, 0.00, 18, 'Printer USB Cable 1.5m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:11:46', NULL),
(148, 'USB Hard Drive Cable 3.0', '000153', 3, 700.00, 0.00, 4, 'USB Hard Drive Cable 3.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:13:20', NULL),
(149, 'Olax Mini Router MF6875', '000212', 3, 19000.00, 0.00, 4, 'Olax Mini Router MF6875', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:23:26', NULL),
(150, 'USB External Hard Drive Cable 2.0', '000154', 1, 650.00, 0.00, 1, 'USB External Hard Drive Cable 2.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:42:12', NULL),
(151, 'Travelling Socket Adaptor', '000122', 1, 1000.00, 0.00, 4, 'Travelling Socket Adaptor', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:44:47', NULL),
(152, 'USB to Type C Converter', '000152', 5, 1200.00, 0.00, 5, 'USB to Type C Converter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:46:28', NULL),
(153, 'HDMI Coupler (Female to Female)', '000171', 5, 450.00, 0.00, 3, 'HDMI Coupler (Female to Female)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:48:18', NULL),
(154, 'QLT Wireless Mouse WM12', '000144', 1, 1400.00, 0.00, 10, 'QLT Wireless Mouse WM12', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:50:03', NULL),
(155, 'QLT Wireless Mouse WM13', '000145', 1, 1400.00, 0.00, 7, 'QLT Wireless Mouse WM13', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:55:36', NULL),
(156, 'QLT Wired Mouse M05', '000141', 5, 800.00, 0.00, 20, 'QLT Wired Mouse M05', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:56:43', NULL),
(157, 'QLT Wired Mouse M04', '000142', 1, 800.00, 0.00, 23, 'QLT Wired Mouse M04', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:57:15', NULL),
(158, 'QLT Wired Gaming Mouse M06', '000143', 5, 1000.00, 0.00, 19, 'QLT Wired Gaming Mouse M06', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:58:20', NULL),
(159, 'QLT Optical Mouse M01', '000146', 1, 600.00, 0.00, 19, 'QLT Optical Mouse M01', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 16:59:13', NULL),
(160, 'APC Laptop Surge', '000172', 1, 11500.00, 0.00, 1, 'APC Laptop Surge', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 17:00:56', NULL),
(161, '4 Ports USB Hub 3.0 Speed', '000117', 1, 3500.00, 0.00, 5, '4 Ports USB Hub 3.0 Speed', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 17:02:40', NULL),
(162, '8 Ports USB Hub 2.0 Speed', '000116', 1, 1900.00, 0.00, 3, '8 Ports USB Hub 2.0 Speed', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 17:09:12', NULL),
(163, 'LDINO 8 USB Charger', '000131', 1, 5300.00, 0.00, 1, 'LDINO 8 USB Charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 17:16:13', NULL),
(164, 'LDINO Type C 2 in 1 Fast Charger A2405Q', '000120', 1, 3400.00, 0.00, 0, 'LDINO Type C 2 in 1 Fast Charger A2405Q', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 17:18:13', NULL),
(165, 'LDINO Android 2 in 1 Fast Charger A2405Q', '000119', 1, 3300.00, 0.00, 2, 'LDINO Android 2 in 1 Fast Charger A2405Q', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 17:20:19', NULL),
(166, 'LDINO 4-Port USB Charge (Type C cable) A4405', '000133', 5, 3200.00, 0.00, 2, 'LDINO 4-Port USB Charge (Type C cable) A4405', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 17:31:55', NULL),
(167, 'LDINO 6-USB 3-Sockets', '000118', 5, 5000.00, 0.00, 2, 'LDINO 6-USB 3-Sockets', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 17:33:12', NULL),
(168, 'LDINO Quick Charge 65W A2620C', '000134', 1, 5500.00, 0.00, 0, 'LDINO Quick Charge 65W A2620C', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-11 17:35:24', NULL),
(169, 'LDNIO 2 in 1 Fast Charger A2405Q (iPhone)', '000170', 1, 3500.00, 0.00, 2, 'LDNIO 2 in 1 Fast Charger A2405Q (iPhone)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 08:58:34', NULL),
(170, 'LDNIO 5-USB Sockets SC10610', '000174', 1, 9500.00, 0.00, 2, 'LDNIO 5-USB Sockets SC10610', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:00:14', NULL),
(171, 'LDNIO 2 in 1 Car Charger 3.4A', '000135', 3, 1800.00, 0.00, 2, 'LDNIO 2 in 1 Car Charger 3.4A', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:03:13', NULL),
(172, 'LDNIO 4-USB Socket Extension', '000179', 1, 6800.00, 0.00, 1, 'LDNIO 4-USB Socket Extension', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:04:56', NULL),
(173, 'LDNIO LC9 3 in 1 Fast Cable', '000138', 1, 1800.00, 0.00, 3, 'LDNIO LC9 3 in 1 Fast Cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:07:04', NULL),
(174, 'Mini Wireless Keyboard with Mouse', '000139', 1, 4500.00, 0.00, 2, 'Mini Wireless Keyboard with Mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:09:43', NULL),
(175, 'QLT Mini Wired Keyboard', '000140', 1, 1700.00, 0.00, 1, 'QLT Mini Wired Keyboard', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:11:24', NULL),
(176, '4-Port HDMI Splitter', '000165', 1, 7000.00, 0.00, 2, '4-Port HDMI Splitter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:12:57', NULL),
(177, 'Car Phone Holder Dashboard', '000136', 5, 1100.00, 0.00, 1, 'Car Phone Holder Dashboard', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:14:08', NULL),
(178, 'Air Vent Car Phone Holder', '000137', 3, 1100.00, 0.00, 2, 'Air Vent Car Phone Holder', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:14:55', NULL),
(179, 'HP Laptop Charger 19.5V ', '000157', 1, 2400.00, 0.00, 5, 'HP Laptop Charger 19.5V ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:16:36', NULL),
(180, 'HP Laptop Charger 18.5V Small Pin', '000156', 5, 2000.00, 0.00, 18, 'HP Laptop Charger 18.5V Small Pin', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:18:32', NULL),
(181, 'Laptop Power Cable with Fuse', '000178', 5, 500.00, 0.00, 62, 'Laptop Power Cable with Fuse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:20:01', NULL),
(182, 'HDMI to HDMI Cable 1.5m', '000180', 1, 500.00, 0.00, 11, 'HDMI to HDMI Cable 1.5m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:23:02', NULL),
(183, 'HDMI to HDMI Cable 3m', '000181', 1, 1000.00, 0.00, 8, 'HDMI to HDMI Cable 3m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:28:24', NULL),
(184, 'HDMI to HDMI Cable 5m', '000182', 1, 1400.00, 0.00, 3, 'HDMI to HDMI Cable 5m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:29:38', NULL),
(185, 'HDMI to HDMI Cable 10m', '000183', 1, 3300.00, 0.00, 1, 'HDMI to HDMI Cable 10m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:30:10', NULL),
(186, 'Flexible Keyboard', '000173', 1, 1800.00, 0.00, 7, 'Flexible Keyboard', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:31:41', NULL),
(187, 'VGA to VGA Cable 1.5m', '000175', 1, 600.00, 0.00, 3, 'VGA to VGA Cable 1.5m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:34:12', NULL),
(188, 'VGA to VGA Cable 15m', '000176', 1, 3200.00, 0.00, 1, 'VGA to VGA Cable 15m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:37:06', NULL),
(189, 'Type C Hub 7 in 1 Dock Station', '000246', 1, 13500.00, 0.00, 5, 'Type C Hub 7 in 1 Dock Station', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 09:50:20', NULL),
(190, 'VGA Splitter 4-port', '000177', 1, 3700.00, 0.00, 1, 'VGA Splitter 4-port', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 10:51:47', NULL),
(191, 'HDMI to VGA Cable 1.5m', '000245', 1, 1100.00, 0.00, 1, 'HDMI to VGA Cable 1.5m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 10:52:59', NULL),
(192, 'Car Inverter 150W', '000244', 1, 4300.00, 0.00, 2, 'Car Inverter 150W', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 10:53:53', NULL),
(193, 'QLT Powerbank 10000MaH', '000230', 1, 5300.00, 0.00, 1, 'QLT Powerbank 10000MaH', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 10:55:13', NULL),
(194, 'QLT Powerbank 30000MaH', '000229', 1, 10500.00, 0.00, 1, 'QLT Powerbank 30000MaH', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 10:56:09', NULL),
(195, 'HDMI Video Capture White pack', '000232', 1, 7500.00, 0.00, 4, 'HDMI Video Capture White pack', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 10:57:50', NULL),
(196, 'USB Video Capture Card', '000231', 1, 7500.00, 0.00, 2, 'USB Video Capture Card', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 10:58:37', NULL),
(197, 'Ultra Touch Drive 1TB', '000163', 3, 25500.00, 0.00, 2, 'Ultra Touch Drive 1TB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:10:18', NULL),
(198, 'One Touch Drive 2TB Ext.', '000233', 3, 35000.00, 0.00, 1, 'One Touch Drive 2TB Ext.', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:12:17', NULL),
(199, 'One Touch Drive 4TB Ext.', '000234', 5, 53000.00, 0.00, 1, 'One Touch Drive 4TB Ext.', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:13:22', NULL),
(200, 'One Touch Drive 5TB Ext.', '000235', 3, 58000.00, 0.00, 1, 'One Touch Drive 5TB Ext.', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:14:54', NULL),
(201, 'Store Jet Hard Drive 1TB Ext', '000236', 3, 28000.00, 0.00, 2, 'Store Jet Hard Drive 1TB Ext', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:16:53', NULL),
(202, 'My Passport Hard Drive 1TB', '000237', 3, 25000.00, 0.00, 1, 'My Passport Hard Drive 1TB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:18:41', NULL),
(203, 'My Passport Hard Drive 2TB', '000238', 5, 33500.00, 0.00, 1, 'My Passport Hard Drive 2TB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:20:30', NULL),
(204, 'Digirich Sleek Flash Drive 2GB', '000239', 3, 1500.00, 0.00, 5, 'Digirich Sleek Flash Drive 2GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:21:43', NULL),
(205, 'Digirich Sleek Flash Drive 4GB', '000240', 3, 1550.00, 0.00, 8, 'Digirich Sleek Flash Drive 4GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:22:21', NULL),
(206, 'Digirich Sleek Flash Drive 8GB', '000241', 3, 1550.00, 0.00, 6, 'Digirich Sleek Flash Drive 8GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:23:12', NULL),
(207, 'Cruzer Blade Flash Drive 8GB', '000242', 3, 1750.00, 0.00, 5, 'Cruzer Blade Flash Drive 8GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:25:00', NULL),
(208, 'Cruzer Blade Flash Drive 16GB', '000243', 3, 1850.00, 0.00, 15, 'Cruzer Blade Flash Drive 16GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:33:23', NULL),
(209, 'Cruzer Glide Flash Drive 16GB', '000188', 3, 2400.00, 0.00, 0, 'Cruzer Glide Flash Drive 16GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:34:28', NULL),
(210, 'Cruzer Blade Flash Drive 32GB', '000189', 3, 2100.00, 0.00, 6, 'Cruzer Blade Flash Drive 32GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:35:42', NULL),
(211, 'Cruzer Glide Flash Drive 32GB', '000190', 3, 2700.00, 0.00, 3, 'Cruzer Glide Flash Drive 32GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:37:07', NULL),
(212, 'Cruzer Blade Flash Drive 64GB', '000191', 3, 3300.00, 0.00, 4, 'Cruzer Blade Flash Drive 64GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:38:02', NULL),
(213, 'Cruzer Glide Flash Drive 64GB', '000192', 3, 3700.00, 0.00, 1, 'Cruzer Glide Flash Drive 64GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:39:03', NULL),
(214, 'Laptop Hard Drive 1TB Internal', '000187', 3, 18000.00, 0.00, 3, 'Laptop Hard Drive 1TB Internal', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:41:11', NULL),
(215, 'Laptop Hard Drive 500GB Internal', '000186', 5, 10000.00, 0.00, 2, 'Laptop Hard Drive 500GB Internal', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:43:10', NULL),
(216, 'Laptop Hard Drive 1TB Internal', '000184', 3, 22500.00, 0.00, 2, 'Laptop Hard Drive 1TB Internal', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:44:20', NULL),
(217, 'Laptop Hard Drive 4TB Internal', '000185', 3, 55000.00, 0.00, 1, 'Laptop Hard Drive 4TB Internal', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:45:14', NULL),
(218, 'Cruzer Glide Flash Drive 128GB', '000193', 3, 6500.00, 0.00, 1, 'Cruzer Glide Flash Drive 128GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:48:00', NULL),
(219, 'ZTE 4G Universal Router MF283U', '000200', 3, 32000.00, 0.00, 1, 'ZTE 4G Universal Router MF283U', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:50:58', NULL),
(220, 'Olax 4G Universal Router AX5 PRO', '000199', 3, 32000.00, 0.00, 1, 'Olax 4G Universal Router AX5 PRO', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:51:56', NULL),
(221, '4G LTE SIM card Router AC750', '000201', 3, 41000.00, 0.00, 1, '4G LTE SIM card Router AC750', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:55:27', NULL),
(222, '4G Mobile Wifi M7200', '000202', 3, 24000.00, 0.00, 2, '4G Mobile Wifi M7200', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:56:52', NULL),
(223, 'Telenet 4G Mobile Wifi Router MF960', '000210', 3, 13500.00, 0.00, 2, 'Telenet 4G Mobile Wifi Router MF960', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:59:07', NULL),
(224, 'Telenet 4G Mobile Wifi Router MF960V', '000211', 3, 14500.00, 0.00, 1, 'Telenet 4G Mobile Wifi Router MF960V', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 11:59:58', NULL),
(225, '4G LTE Universal Mobile Wifi M7350', '000203', 3, 35000.00, 0.00, 1, '4G LTE Universal Mobile Wifi M7350', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 12:05:22', NULL),
(226, 'HSDPA USB Universal Modem', '000206', 5, 3200.00, 0.00, 5, 'HSDPA USB Universal Modem', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 12:06:53', NULL),
(227, 'USB Wireless Adapter TL-WN725N 150MBPS', '000204', 3, 3100.00, 0.00, 1, 'USB Wireless Adapter TL-WN725N 150MBPS', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 12:38:23', NULL),
(228, 'WIFI Range Extender TL-WA850RE', '000205', 3, 11500.00, 0.00, 3, 'WIFI Range Extender TL-WA850RE', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 12:39:15', NULL),
(229, 'Micro SD Memory Card 128GB', '000195', 1, 6300.00, 0.00, 1, 'Micro SD Memory Card 128GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 12:40:40', NULL),
(230, 'Micro SD Memory Card 256GB', '000196', 1, 15000.00, 0.00, 1, 'Micro SD Memory Card 256GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 12:41:34', NULL),
(231, 'Micro SD Memory Card 400GB', '000197', 1, 25500.00, 0.00, 1, 'Micro SD Memory Card 400GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 12:42:55', NULL),
(232, 'Micro SD Memory Card 512GB', '000198', 1, 35000.00, 0.00, 1, 'Micro SD Memory Card 512GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 12:55:19', NULL),
(233, 'Nano Android OTG Adapter', '000228', 3, 500.00, 0.00, 12, 'Nano Android OTG Adapter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 13:02:34', NULL),
(234, '2 in 1 Car Fast Charger', '000227', 3, 3200.00, 0.00, 2, '2 in 1 Car Fast Charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 13:04:30', NULL),
(235, '3 in 1 Car Fast Charger', '000226', 3, 2400.00, 0.00, 2, '3 in 1 Car Fast Charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 13:05:03', NULL),
(236, 'Zealot H15 Nectone', '000207', 1, 4400.00, 0.00, 1, 'Zealot H15 Nectone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 13:31:46', NULL),
(237, 'Gaming Necktone GM-A3', '000208', 1, 2400.00, 0.00, 1, 'Gaming Necktone GM-A3', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:16:53', NULL),
(238, 'Yoobao 503 Necktone', '000209', 1, 6000.00, 0.00, 1, 'Yoobao 503 Necktone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:18:22', NULL),
(239, 'Bluedio Bluetooth Earbuds', '000214', 1, 6500.00, 0.00, 1, 'Bluedio Bluetooth Earbuds', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:19:40', NULL),
(240, 'Jabra F600 Bluetooth Headset', '000213', 1, 4200.00, 0.00, 0, 'Jabra F600 Bluetooth Headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:21:14', NULL),
(241, 'S109 Bluetooth Headphone', '000215', 1, 3400.00, 0.00, 0, 'S109 Bluetooth Headphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:22:27', NULL),
(242, 'K-39 Bluetooth Earpiece', '000217', 5, 4200.00, 0.00, 1, 'K-39 Bluetooth Earpiece', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:24:52', NULL),
(243, 'Gelidi X10 Nectone', '000216', 1, 6500.00, 0.00, 3, 'Gelidi X10 Nectone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:32:23', NULL),
(244, 'AKG Earpiece', '000219', 1, 400.00, 0.00, 9, 'AKG Earpiece', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:33:22', NULL),
(245, 'Iphone Earphone', '000221', 5, 800.00, 0.00, 4, 'Iphone Earphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:34:33', NULL),
(246, 'Crossfire Double SIM GSM Wireless Phone', '000218', 3, 10500.00, 0.00, 2, 'Crossfire Double SIM GSM Wireless Phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:37:40', NULL),
(247, 'Lion Electric Blower & Vacuum Cleaner', '000220', 3, 5000.00, 0.00, 2, 'Lion Electric Blower & Vacuum Cleaner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:39:35', NULL),
(248, 'Xbox 360 Wireless Gamepad', '000167', 3, 8500.00, 0.00, 2, 'Xbox 360 Wireless Gamepad', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:42:02', NULL),
(249, 'PS 4 Gamepad', '000166', 3, 8500.00, 0.00, 3, 'PS 4 Gamepad', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:43:57', NULL),
(250, 'Double Wired PC Pad ', '000169', 3, 2500.00, 0.00, 2, 'Double Wired PC Pad ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:47:00', NULL),
(251, '2.0 Yellow HDD Enclosure', '000225', 5, 1400.00, 0.00, 0, '2.0 Yellow HDD Enclosure', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:50:54', NULL),
(252, 'USB-C To USB adapter LC140', '000223', 3, 1200.00, 0.00, 0, 'USB-C To USB adapter LC140', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:53:07', NULL),
(253, 'M4 Anycast Plus', '000222', 1, 4000.00, 0.00, 3, 'M4 Anycast Plus', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:55:25', NULL),
(254, 'Card Reader 2.0', '000224', 1, 350.00, 0.00, 6, 'Card Reader 2.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 14:57:33', NULL),
(255, 'Cruzer Blade Flash Drive 128GB', '000194', 1, 5800.00, 0.00, 2, 'Cruzer Blade Flash Drive 128GB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 15:01:03', NULL),
(256, 'PS 2 Wired Pad', '000168', 3, 1800.00, 0.00, 6, 'PS 2 Wired Pad', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 15:02:36', NULL),
(257, 'Y2 Ring Light', '000161', 3, 12000.00, 0.00, 1, 'Y2 Ring Light', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 15:04:13', NULL),
(258, 'G2 Ring Light', '000162', 3, 14000.00, 0.00, 1, 'G2 Ring Light', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 15:05:01', NULL),
(259, 'Wireless Mouse M190', '000147', 1, 6500.00, 0.00, 0, 'Wireless Mouse M190', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 15:11:39', NULL),
(260, 'Battery for 4G Wifi', '000164', 1, 3500.00, 0.00, 2, 'Battery for 4G Wifi', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 15:13:35', NULL),
(261, 'Tireless UPS Battery', '000158', 1, 5700.00, 0.00, 2, 'Tireless UPS Battery', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 15:14:51', NULL),
(262, 'Sun Speaker LP-V23', '000159', 1, 4300.00, 0.00, 1, 'Sun Speaker LP-V23', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 15:15:50', NULL),
(263, 'Portable Speaker LP V9', '000160', 1, 3700.00, 0.00, 0, 'Portable Speaker LP V9', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-12 15:16:55', NULL),
(269, 'Itel 2163', '000247', 3, 4700.00, 0.00, 0, 'Itel 2163 Phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:51:50', NULL),
(270, 'Itel 2160', '000248', 3, 5100.00, 0.00, 0, 'Itel 2160 phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:52:42', NULL),
(271, 'Itel 2173', '000249', 3, 5400.00, 0.00, 0, 'Itel 2173 phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:53:28', NULL),
(272, 'A30 21D', '000275', 3, 150.00, 0.00, 5, 'A30 21D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:56:08', NULL),
(273, 'Tecno T201', '000250', 3, 5650.00, 0.00, 0, 'Tecno T201 phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:56:42', NULL),
(274, 'LC8 21D', '000276', 3, 150.00, 0.00, 5, 'LC8 21D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:57:29', NULL),
(275, 'Tecno T301', '000251', 3, 5750.00, 0.00, 2, 'Tecno T301 phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:57:46', NULL),
(276, 'Hot8 21D', '000277', 3, 150.00, 0.00, 0, 'Hot8 21D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:58:45', NULL),
(277, 'Tecno T101', '000252', 3, 5750.00, 0.00, 2, 'Tecno T101 phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:59:16', NULL);
INSERT INTO `stock_ins` (`id`, `stock_name`, `stock_unique_id`, `stock_category_id`, `stock_costprice`, `stock_price`, `stock_qty`, `stock_description`, `memo`, `date_created`, `date_updated`) VALUES
(278, 'KB7 21D', '000278', 3, 150.00, 0.00, 5, 'KB7 21D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 17:59:38', NULL),
(279, 'X626 21D', '000279', 3, 150.00, 0.00, 3, 'X626 21D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:00:38', NULL),
(280, 'Tecno T454', '000253', 5, 8550.00, 0.00, 1, 'Tecno T454 phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:00:41', NULL),
(281, 'Tecno T475', '000254', 5, 10650.00, 0.00, 2, 'Tecno T475 phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:01:18', NULL),
(282, 'Pop2 21D', '000280', 3, 150.00, 0.00, 4, 'Pop2 21D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:01:31', NULL),
(283, 'Tecno T529', '000255', 3, 11100.00, 0.00, 2, 'Tecno T529 Phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:02:24', NULL),
(284, 'Hot 10 21D', '000281', 3, 150.00, 0.00, 4, 'Hot 10 21D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:02:36', NULL),
(285, 'Hot 9 21D', '000282', 3, 150.00, 0.00, 3, 'Hot 9 21D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:03:55', NULL),
(286, 'Hot 9 play Glass', '000283', 3, 200.00, 0.00, 4, 'Hot 9 play Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:05:22', NULL),
(287, 'iPhone X Glass  Privacy black', '000256', 3, 500.00, 0.00, 4, 'iPhone X Glass Privacy black', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:05:57', NULL),
(288, 'Note 7 Glass', '000284', 3, 150.00, 0.00, 4, 'Note 7 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:06:21', NULL),
(289, 'X572 Glass', '000285', 3, 100.00, 0.00, 4, 'X572 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:07:57', NULL),
(290, 'Ipad glass', '000286', 3, 450.00, 0.00, 2, 'Ipad glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:08:57', NULL),
(291, 'iPhone IPXR Glass  Privacy black', '000257', 3, 500.00, 0.00, 3, 'iPhone IPXR Glass  Privacy black', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:09:33', NULL),
(292, 'P904 Glass', '000287', 3, 450.00, 0.00, 2, 'P904 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:09:50', NULL),
(293, 'IPad 5 Glass', '000288', 3, 450.00, 0.00, 2, 'IPad 5 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:11:02', NULL),
(294, 'iPhone 11pro Max Glass  Privacy', '000258', 3, 500.00, 0.00, 3, 'iPhone 11pro Max Glass  Privacy', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:11:06', NULL),
(295, '10D  Glass', '000289', 3, 450.00, 0.00, 1, '10D  Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:11:49', NULL),
(296, 'T590 Glass', '000290', 3, 450.00, 0.00, 2, 'T590 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:12:36', NULL),
(297, 'T295 Glass', '000291', 3, 450.00, 0.00, 1, 'T295 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:13:43', NULL),
(298, 'T285 Glass', '000292', 5, 450.00, 0.00, 4, 'T285 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:14:47', NULL),
(299, 'Tab 7F Glass', '000293', 3, 450.00, 0.00, 2, 'Tab 7F Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:15:54', NULL),
(300, 'T230 Glass', '000294', 3, 450.00, 0.00, 2, 'T230 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:16:57', NULL),
(301, 'iPhone 12pro Max Glass  Privacy', '000259', 3, 500.00, 0.00, 5, 'iPhone 12pro Max Glass  Privacy', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:17:26', NULL),
(302, 'IPad mini ', '000295', 3, 450.00, 0.00, 2, 'IPad  mini ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:18:14', NULL),
(303, 'Tab 7D Glass', '000297', 3, 450.00, 0.00, 2, 'Tab 7D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:19:21', NULL),
(304, 'iPhone 12 Glass  Privacy', '000260', 3, 500.00, 0.00, 5, 'iPhone 12 Glass  Privacy', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:19:24', NULL),
(305, 'iPhone 13 Pro Glass  Privacy', '000261', 3, 1000.00, 0.00, 5, 'iPhone 13 Pro Glass  Privacy', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:20:16', NULL),
(306, 'iPhone 13 Pro Max Glass  Privacy', '000262', 3, 1000.00, 0.00, 5, 'iPhone 13 Pro Max Glass  Privacy', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:21:09', NULL),
(307, 'T560 Glass', '000298', 3, 450.00, 0.00, 2, 'T560 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:21:37', NULL),
(308, 'iPhone 5D Glass', '000263', 3, 400.00, 0.00, 5, 'iPhone 5D Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:22:08', NULL),
(309, 'T585 Glass', '000299', 3, 450.00, 0.00, 2, 'T585 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:22:31', NULL),
(310, 'iPhone 7 Glass', '000264', 3, 400.00, 0.00, 4, 'iPhone 7 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:22:56', NULL),
(311, 'Ipad 3 Glass', '000300', 3, 450.00, 0.00, 2, 'Ipad 3 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:23:17', NULL),
(312, 'iPhone 11 Pro Glass', '000265', 3, 400.00, 0.00, 5, 'iPhone 11 Pro Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:23:45', NULL),
(313, 'T510 Glass', '000301', 3, 450.00, 0.00, 2, 'T510 Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:24:11', NULL),
(314, ' A7 Glass', '000302', 3, 800.00, 0.00, 2, ' A7   Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:25:19', NULL),
(315, 'iPhone 12 Pro Max (21D) Glass', '000266', 3, 150.00, 0.00, 5, 'iPhone 12 Pro Max (21D) Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:26:32', NULL),
(316, 'iPhone 6 (21D) Glass', '000267', 3, 150.00, 0.00, 5, 'iPhone 6 (21D) Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:28:11', NULL),
(317, 'iPhone X (21D) Glass', '000268', 3, 150.00, 0.00, 5, 'iPhone X (21D) Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:29:37', NULL),
(318, 'X606 (21D) Glass', '000269', 3, 150.00, 0.00, 5, 'X606 (21D) Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:30:43', NULL),
(319, 'A56 (21D) Glass', '000270', 3, 150.00, 0.00, 5, 'A56 (21D) Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:31:51', NULL),
(320, 'Camon 16 (21D) Glass', '000271', 3, 150.00, 0.00, 5, 'Camon 16 (21D) Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:32:34', NULL),
(321, 'LC6 (21D) Glass', '000272', 3, 150.00, 0.00, 4, 'LC6 (21D) Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:33:12', NULL),
(322, 'Camon 17 pro (21D) Glass', '000273', 3, 150.00, 0.00, 5, 'Camon 17 pro (21D) Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:34:10', NULL),
(323, 'A56 (21D) Glass', '000274', 5, 150.00, 0.00, 4, 'A56 (21D) Glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-13 18:35:21', NULL),
(324, 'odogwu iphone charger', '000303', 1, 3000.00, 0.00, 0, 'odogwu iphone charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-20 14:25:49', NULL),
(325, 'Odogwu Type C charger', '000304', 1, 3000.00, 0.00, 1, 'Odogwu Type C charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-20 14:29:26', NULL),
(326, 'Panda USB charger ', '000305', 1, 2200.00, 0.00, 5, 'Panda USB charger ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-20 14:30:28', NULL),
(327, 'Bluetooth Earpiece chupez', '000306', 5, 3000.00, 0.00, 1, 'Bluetooth Earpiece chupez', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-20 14:32:38', NULL),
(328, 'Antivirus 64gb memory card', '000307', 1, 2580.00, 0.00, 5, 'Antiviris 64gb memory card', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-01-20 14:34:00', NULL),
(329, 'Fil earpiece R13', '000376', 1, 600.00, 0.00, 2, 'Fil earpiece R13', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 11:32:47', NULL),
(330, 'Fil Mj 3i Earpiece', '000377', 1, 550.00, 0.00, 2, 'Fil Mj 3i Earpiece', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 11:35:07', NULL),
(331, 'Fil socket 814KUW', '000378', 1, 8500.00, 0.00, 1, 'Fil socket 814KUW', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 11:38:10', NULL),
(332, 'FiL 3 in 1 ICON 2 charger', '000379', 1, 800.00, 0.00, 10, 'FiL 3 in 1 ICON 2 charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 11:40:42', NULL),
(333, 'Fil 2usb ICON 1 charger', '000380', 5, 650.00, 0.00, 10, 'Fil 2usb ICON 1 charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 11:43:22', NULL),
(334, 'Mini Speaker L8', '000382', 1, 2500.00, 0.00, 1, 'Mini Speaker L8', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 11:52:22', NULL),
(335, 'Mini Speaker L8mini', '000383', 1, 2300.00, 0.00, 1, 'Mini Speaker L8mini', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 11:53:58', NULL),
(336, 'Speaker V6pro', '000384', 1, 3600.00, 0.00, 2, 'Speaker V6pro', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 11:55:41', NULL),
(337, 'SPeaker V6', '000385', 1, 3500.00, 0.00, 1, 'SPeaker V6', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 11:58:15', NULL),
(338, 'Speaker S812', '000386', 1, 4700.00, 0.00, 1, 'Speaker S812', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:00:19', NULL),
(339, 'Speaker Lpv6', '000387', 1, 5000.00, 0.00, 1, 'Speaker Lpv6', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:02:41', NULL),
(340, 'Speaker S09', '000388', 1, 3200.00, 0.00, 0, 'Speaker S09', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:04:33', NULL),
(341, 'Mini Speaker 887', '000389', 1, 1500.00, 0.00, 2, 'Mini Speaker 887', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:06:03', NULL),
(342, 'Samsung Level U', '000390', 1, 3000.00, 0.00, 3, 'Samsung Level U', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:08:55', NULL),
(343, 'Samsung Level Upro', '000391', 5, 3500.00, 0.00, 1, 'Samsung Level Upro', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:09:54', NULL),
(344, 'Sony headset 740bt', '000392', 1, 5500.00, 0.00, 0, 'Sony headset 740bt', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:11:14', NULL),
(345, 'Uflex headphone', '000393', 1, 6500.00, 0.00, 0, 'Uflex headphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:13:36', NULL),
(346, 'Cyz- E100 wirwless bluetooth', '000394', 5, 3000.00, 0.00, 0, 'Cyz- E100 wirwless bluetooth', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:15:01', NULL),
(347, 'Tp link 8 ports switch ', '000322', 1, 5000.00, 0.00, 5, 'Tp link 8 ports switch ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:18:36', NULL),
(348, 'Tp link SF1016D 16ports desktop switch', '000323', 1, 13500.00, 0.00, 1, 'Tp link SF1016D 16ports desktop switch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:19:50', NULL),
(349, 'desktop charger seven color', '000324', 1, 230.00, 0.00, 33, 'desktop charger seven color', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:21:26', NULL),
(350, 'Flat mouse Hp', '000325', 1, 1000.00, 0.00, 2, 'Flat mouse Hp', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:23:34', NULL),
(351, 'Hp 5GHZ Mouse', '000326', 1, 1200.00, 0.00, 0, 'Hp 5GHZ Mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:27:48', NULL),
(352, 'USB C 87w Power adapter', '000327', 1, 16500.00, 0.00, 5, 'USB C 87w Power adapter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:39:42', NULL),
(353, 'USB C 60w power adapter brushmouth', '000328', 5, 16000.00, 0.00, 2, 'USB C 60w power adapter brushmouth', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:42:51', NULL),
(354, 'USB C 30w power adapter', '00329', 1, 0.00, 0.00, 0, 'USB C 30w power adapter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:43:53', NULL),
(355, 'Speaker battery', '000330', 1, 700.00, 0.00, 18, 'Speaker battery', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:47:31', NULL),
(356, 'WL 908mv headphone', '000331', 1, 2700.00, 0.00, 0, 'WL 908mv headphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:54:27', NULL),
(357, 'Infinix 6A charger', '000332', 1, 1050.00, 0.00, 8, 'Infinix 6A charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:56:50', NULL),
(358, 'Shplus Socket 9A 2usb smart socket charger', '000333', 1, 1300.00, 0.00, 5, 'Shplus Socket 9A 2usb smart socket charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:58:17', NULL),
(359, 'Shplus 4usb charger', '000334', 1, 1300.00, 0.00, 5, 'Shplus 4usb charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 12:59:21', NULL),
(360, 'Iphone 12promax charger', '000335', 1, 3600.00, 0.00, 2, 'Iphone 12promax charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:04:05', NULL),
(361, '12w 20w usb power adapter', '000336', 5, 1350.00, 0.00, 2, '12w 20w usb power adapter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:05:00', NULL),
(362, '12pro max head', '000337', 1, 2900.00, 0.00, 1, '12pro max head', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:08:19', NULL),
(363, '12pro max head 2pin', '000338', 1, 1800.00, 0.00, 5, '12pro max head 2pin', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:08:45', NULL),
(364, 'Shplus 2+1 charger', '000339', 5, 1300.00, 0.00, 0, 'Shplus 2+1 charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:10:09', NULL),
(365, 'Samsung s10+ cable', '000340', 1, 350.00, 0.00, 4, 'Samsung s10+ cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:10:52', NULL),
(366, 'Iphone 5 cable 2.0', '000341', 5, 280.00, 0.00, 19, 'Iphone 5 cable 2.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:22:35', NULL),
(367, 'Iphone 5 cable 3.0', '000342', 1, 350.00, 0.00, 17, 'Iphone 5 cable 3.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:23:24', NULL),
(368, 'Shplus 20000mah S16 PB', '000343', 1, 6000.00, 0.00, 2, 'Shplus 20000mah S16 PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:24:44', NULL),
(369, 'Shplus 20000mah S18 PB', '000344', 5, 7500.00, 0.00, 2, 'Shplus 20000mah S18 PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:26:05', NULL),
(370, 'Shplus 30000mah S31 PB', '000345', 1, 8000.00, 0.00, 0, 'Shplus 30000mah S31 PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:27:09', NULL),
(371, 'Shplus 30000mah PB', '000346', 1, 8500.00, 0.00, 2, 'Shplus 30000mah PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:28:19', NULL),
(372, 'Shplus 2USB charger', '000348', 1, 1000.00, 0.00, 2, 'Shplus 2USB charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:30:06', NULL),
(373, 'Shplus 9A speed charger', '000349', 1, 1600.00, 0.00, 5, 'Shplus 9A speed charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:32:05', NULL),
(374, 'Shplus 4usb fast charger', '000350', 1, 1400.00, 0.00, 1, 'Shplus 4usb fast charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:41:19', NULL),
(375, 'Iphone cable 1.5m', '000351', 1, 250.00, 0.00, 10, 'Iphone cable 1.5m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:45:20', NULL),
(376, 'Type C cable 1.5m', '000352', 5, 250.00, 0.00, 5, 'Type C cable 1.5m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:46:43', NULL),
(377, 'Iphone cable 2.0m', '000353', 5, 350.00, 0.00, 4, 'Iphone cable 2.0m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:48:32', NULL),
(378, 'Type C  cable 2.0m', '000354', 5, 350.00, 0.00, 8, 'Type C  cable 2.0m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:49:20', NULL),
(379, 'Type B Micro usb cable 2.0m', '000355', 5, 230.00, 0.00, 1, 'Type B Micro usb cable 2.0m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:49:56', NULL),
(380, 'Iphone 7 earpiece', '000356', 1, 4700.00, 0.00, 2, 'Iphone 7 earpiece', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:51:10', NULL),
(381, 'Digital persona fingerprint', '000452', 1, 13000.00, 0.00, 0, 'Digital persona fingerprint', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:52:13', NULL),
(382, 'HDMI cable grade 2', '000347', 1, 500.00, 0.00, 6, 'HDMI cable grade 2', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:53:46', NULL),
(383, 'HDD case 3.0', '00453', 3, 0.00, 0.00, 0, 'HDD case 3.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:55:29', NULL),
(384, 'CD by 50(empty)', '000454', 1, 20.00, 0.00, 86, 'CD by 50(empty)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:57:05', NULL),
(385, 'DVD by 50 (empty)', '000455', 1, 20.00, 0.00, 100, 'DVD by 50 (empty)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 13:58:40', NULL),
(386, 'Hp mouse wireless', '000456', 5, 1200.00, 0.00, 1, 'Hp mouse wireless', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:04:10', NULL),
(387, 'Mercury Ups 650KVA', '000457', 3, 13500.00, 0.00, 0, 'Mercury Ups 650KVA', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:05:29', NULL),
(388, 'Bluegate UPs 653KVA', '000458', 3, 14500.00, 0.00, 1, 'Bluegate UPs 653KVA', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:06:05', NULL),
(389, 'HP printer 2710', '000459', 3, 29000.00, 0.00, 1, 'HP printer 2710', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:07:09', NULL),
(390, 'Canon Printer 3140', '000460', 3, 30000.00, 0.00, 1, 'Canon Printer 3140', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:09:28', NULL),
(391, 'Refill ink black', '000461', 3, 700.00, 0.00, 5, 'Refill ink black', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:10:45', NULL),
(392, 'Refill ink colour', '000462', 5, 900.00, 0.00, 5, 'Refill ink colour', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:11:30', NULL),
(393, 'Laminating machine', '000463', 1, 23000.00, 0.00, 1, 'Laminating machine', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:12:34', NULL),
(394, 'Laminating film', '000464', 1, 3200.00, 0.00, 1, 'Laminating film', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:13:21', NULL),
(395, 'HDMI TO VGA', '000465', 1, 1500.00, 0.00, 2, 'HDMI TO VGA', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:14:39', NULL),
(396, 'USB printer cable 3m', '000466', 5, 700.00, 0.00, 7, 'USB printer cable 3m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:15:24', NULL),
(397, 'Xprinter big one', '000467', 3, 25000.00, 0.00, 2, 'Xprinter big one', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:16:27', NULL),
(398, 'Iphone 4 cable', '000357', 1, 350.00, 0.00, 5, 'Iphone 4 cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:16:55', NULL),
(399, 'New age 2port(S11pro) charger', '000358', 1, 1700.00, 0.00, 13, 'New age 2port(S11pro) charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:18:05', NULL),
(400, 'New age 1port (Sp1) charger', '000359', 1, 1700.00, 0.00, 15, 'New age 1port (Sp1) charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:18:54', NULL),
(401, 'New age c200 car charger', '000360', 3, 1000.00, 0.00, 5, 'New age c200 car charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:20:18', NULL),
(402, 'New age type C cable', '000361', 1, 400.00, 0.00, 3, 'New age type C cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:20:54', NULL),
(403, 'New age Iphone cable', '000362', 5, 400.00, 0.00, 2, 'New age Iphone cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:21:19', NULL),
(404, 'New age micro cable(micro usb)', '000363', 1, 300.00, 0.00, 10, 'New age micro cable(micro usb)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:22:44', NULL),
(405, 'New age data cable(micro usb)', '000364', 1, 200.00, 0.00, 3, 'New age data cable(micro usb)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:23:10', NULL),
(406, 'New age 15000mah PB', '000365', 1, 4700.00, 0.00, 2, 'New age 15000mah PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:25:03', NULL),
(407, 'New age 22500mah PB', '000366', 5, 9200.00, 0.00, 5, 'New age 22500mah PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:25:51', NULL),
(408, 'New age 33000mah (Fc 30) PB', '000367', 5, 15000.00, 0.00, 5, 'New age 33000mah (Fc 30) PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:26:21', NULL),
(409, 'New age 33000mah(L30) PB', '000368', 1, 18000.00, 0.00, 4, 'New age 33000mah(L30) PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:27:14', NULL),
(410, 'FIL 12000mah (m111+) PB', '000369', 1, 4700.00, 0.00, 1, 'FIL 12000mah (m111+) PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:27:53', NULL),
(411, 'FIL 20000mah (HB81D) PB', '000370', 5, 7200.00, 0.00, 1, 'FIL 20000mah (HB81D) PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:28:43', NULL),
(412, 'FIL 20000mah (HB111D) PB', '000371', 1, 7400.00, 0.00, 0, 'FIL 20000mah (HB111D) PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:29:27', NULL),
(413, 'FIL 10000mah (m115) PB', '000372', 5, 4300.00, 0.00, 2, 'FIL 10000mah (m115) PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:30:10', NULL),
(414, 'FIL 6000mah (m110) PB', '000373', 1, 3400.00, 0.00, 2, 'FIL 6000mah (m110) PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:30:57', NULL),
(415, 'FIL 12000mah (m109+) PB ', '000374', 1, 4700.00, 0.00, 1, 'FIL 12000mah (m109+) PB ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:31:53', NULL),
(416, 'FIL Thunder 30000mah PB', '000375', 1, 12000.00, 0.00, 1, 'FIL Thunder 30000mah PB', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:32:49', NULL),
(417, 'Headset VN 01', '000396', 1, 2500.00, 0.00, 1, 'Headset VN 01', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:38:32', NULL),
(418, 'Samsung sport headset ZON 17', '000397', 1, 2500.00, 0.00, 1, 'Samsung sport headset ZON 17', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:38:55', NULL),
(419, 'Headset VK 89', '000395', 1, 3000.00, 0.00, 1, 'Headset VK 89', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:39:04', NULL),
(420, 'Neckband bluetooth earphone ZON 14', '000398', 1, 2500.00, 0.00, 1, 'Neckband bluetooth earphone ZON 14', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:40:19', NULL),
(421, 'Realmi bluetooth ZON 05', '000400', 5, 2500.00, 0.00, 0, 'Realmi bluetooth ZON 05', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:40:57', NULL),
(422, 'Jbl bluetooth ZON 04', '000401', 1, 2500.00, 0.00, 0, 'Jbl bluetooth ZON 04', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:41:48', NULL),
(423, 'Jbl bluetooth headset E650', '000402', 1, 4500.00, 0.00, 0, 'Jbl bluetooth headset E650', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:42:37', NULL),
(424, 'Car fm player 12.24w', '000403', 3, 1500.00, 0.00, 2, 'Car fm player 12.24w', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:43:18', NULL),
(425, 'Bluetooth car charger', '000404', 3, 850.00, 0.00, 0, 'Bluetooth car charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:43:44', NULL),
(426, 'Iphone 11 pouch', '000406', 3, 1400.00, 0.00, 0, 'Iphone 11 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:44:35', NULL),
(427, 'Samsung Note 10+ pouch', '000405', 3, 600.00, 0.00, 0, 'Samsung Note 10+ pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:47:46', NULL),
(428, 'Iphone XSmax pouch', '000408', 3, 1400.00, 0.00, 2, 'Iphone XSmax pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 14:55:13', NULL),
(429, 'Oppo A93 pouch', '000409', 3, 480.00, 0.00, 1, 'Oppo A93 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:14:45', NULL),
(430, 'Oppo A53 pouch', '000410', 3, 480.00, 0.00, 2, 'Oppo A53 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:15:11', NULL),
(431, 'Tecno Pop4air pouch', '000411', 3, 480.00, 0.00, 5, 'Tecno Pop4air pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:16:31', NULL),
(432, 'Tecno Camon16prime pouch', '000412', 3, 480.00, 0.00, 2, 'Tecno Camon16prime pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:17:07', NULL),
(433, 'Samsung s7 edge pouch', '000413', 5, 600.00, 0.00, 2, 'Samsung s7 edge pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:18:51', NULL),
(434, 'SAmsung J7 prime pouch', '000414', 3, 480.00, 0.00, 2, 'SAmsung J7 prime pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:19:00', NULL),
(435, 'Samsung S10 pouch', '000416', 3, 600.00, 0.00, 1, 'Samsung S10 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:20:20', NULL),
(436, 'Tecno Spark 5 pouch', '000415', 3, 480.00, 0.00, 3, 'Tecno Spark 5 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:20:29', NULL),
(437, 'Samsung S10+ pouch', '000417', 3, 480.00, 0.00, 1, 'Samsung S10+ pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:21:41', NULL),
(438, 'Tecno TE8 pouch', '000418', 5, 480.00, 0.00, 1, 'Tecno TE8 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:22:22', NULL),
(439, 'Tecno TE8i pouch', '000419', 3, 480.00, 0.00, 1, 'Tecno TE8i pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:23:32', NULL),
(440, 'Tecno Saprk 7p pouch', '000420', 3, 480.00, 0.00, 3, 'Tecno Saprk 7p pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:23:36', NULL),
(441, 'Samsung A72 pouch', '000421', 3, 600.00, 0.00, 1, 'Samsung A72 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:24:43', NULL),
(442, 'Samsung NOTE 10pouch', '000422', 3, 600.00, 0.00, 2, 'Samsung NOTE 10pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:25:46', NULL),
(443, 'Iphone XR hunter pouch', '000423', 3, 1400.00, 0.00, 1, 'Iphone XR hunter pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:25:52', NULL),
(444, 'Iphone 7 pouch', '000424', 3, 600.00, 0.00, 1, 'Iphone 7 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:26:18', NULL),
(445, 'Iphone 12promax pouch', '000425', 3, 1400.00, 0.00, 2, 'Iphone 12promax pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:27:22', NULL),
(446, 'Iphone 11promax pouch', '000426', 3, 1400.00, 0.00, 4, 'Iphone 11promax pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:27:28', NULL),
(447, 'Oppo A54 pouch', '000427', 3, 480.00, 0.00, 2, 'Oppo A54 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:28:14', NULL),
(448, 'Oppo Reno 5F pouch', '000428', 3, 480.00, 0.00, 0, 'Oppo Reno 5F pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:29:19', NULL),
(449, 'Iphone 7plus pouch', '000429', 3, 1400.00, 0.00, 2, 'Iphone 7plus pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:30:07', NULL),
(450, 'Iphone 6s pouch', '000430', 3, 1400.00, 0.00, 2, 'Iphone 6s pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:30:33', NULL),
(451, 'Oppo Reno 5 pouch', '000431', 3, 480.00, 0.00, 2, 'Oppo Reno 5 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:31:09', NULL),
(452, 'SAmsung A21s pouch', '000432', 3, 480.00, 0.00, 2, 'SAmsung A21s pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:31:47', NULL),
(453, 'Iphone 6 pouch', '000433', 3, 600.00, 0.00, 1, 'Iphone 6 pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:32:47', NULL),
(454, 'Redmi 9T pouch', '000434', 3, 480.00, 0.00, 2, 'Redmi 9T pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:32:53', NULL),
(455, 'Iphone 7 pouch leather', '000435', 3, 600.00, 0.00, 1, 'Iphone 7 pouch leather', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:52:59', NULL),
(456, 'Tecno Pop4pro pouch', '000436', 3, 480.00, 0.00, 1, 'Tecno Pop4pro pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:54:11', NULL),
(457, 'Iphone XR LV pouch', '000437', 3, 600.00, 0.00, 1, 'Iphone XR LV pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:54:48', NULL),
(458, '44A Toner ', '000439', 3, 8000.00, 0.00, 2, '44A Toner ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:56:22', NULL),
(459, '79A Toner', '000438', 3, 7000.00, 0.00, 1, '79A Toner toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:56:49', NULL),
(460, '17A Toner', '000440', 3, 8000.00, 0.00, 1, '17A   Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:57:39', NULL),
(461, '30A Toner', '000441', 3, 8000.00, 0.00, 1, '30A  Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 15:57:46', NULL),
(462, 'Ink 123 Black Hp', '000442', 1, 6000.00, 0.00, 3, 'Ink 123 Black Hp', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:00:16', NULL),
(463, 'Ink 652 black ', '000444', 1, 7200.00, 0.00, 4, 'Ink 652 black ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:02:47', NULL),
(464, 'Ink 123 color Hp', '000443', 1, 7200.00, 0.00, 4, 'Ink 123 color Hp', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:02:51', NULL),
(465, 'Ink 652 color', '000445', 1, 6500.00, 0.00, 4, 'Ink 652 color', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:05:11', NULL),
(466, 'Ink 650 black', '000446', 1, 6000.00, 0.00, 3, 'Ink 650 black', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:05:20', NULL),
(467, 'ink 650 color', '000447', 1, 6500.00, 0.00, 4, 'ink 650 color', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:07:30', NULL),
(468, 'Ink 305 black', '000448', 1, 5500.00, 0.00, 2, 'Ink 305 black', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:08:14', NULL),
(469, 'Ink 305 color', '000449', 1, 5500.00, 0.00, 3, 'Ink 305 color', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:08:41', NULL),
(470, 'Mini display port to HDMI', '000450', 1, 2000.00, 0.00, 1, 'Mini display port to HDMI', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:09:39', NULL),
(471, 'Havit Webcam', '000451', 1, 6000.00, 0.00, 0, 'Havit Webcam', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:10:14', NULL),
(472, 'Transparent wireless headset BE01-black', '000308', 1, 1690.00, 0.00, 4, 'Transparent wireless headset BE01', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:11:38', NULL),
(473, 'Transparent earphone CEP03-black', '000309', 5, 350.00, 0.00, 13, 'Transparent earphone CEP03-black', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:12:55', NULL),
(474, 'Transparent 2gb memory card', '000310', 1, 1030.00, 0.00, 8, 'Transparent 2gb memory card', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:13:40', NULL),
(475, 'Transparent BH01 powerful bass', '000311', 1, 3850.00, 0.00, 1, 'Transparent BH01 powerful bass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:14:06', NULL),
(476, 'Zealot headset 047', '000312', 1, 5000.00, 0.00, 1, 'Zealot headset 047', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:15:36', NULL),
(477, 'Zealot B19 bluetooth', '000313', 1, 5900.00, 0.00, 2, 'Zealot B19 bluetooth', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:16:59', NULL),
(478, 'Zealot headphone B570 best bu', '000314', 1, 4800.00, 0.00, 3, 'Zealot headphone B570 best bu', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:17:26', NULL),
(479, 'Q7 business clip bluetooth headset', '000315', 1, 5500.00, 0.00, 1, 'Q7 business clip bluetooth headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:18:49', NULL),
(480, 'Art K50 clip ON bluetooth', '000316', 5, 4500.00, 0.00, 1, 'Art K50 clip ON bluetooth', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:19:13', NULL),
(481, 'L07 selfie stick with ring light', '000317', 3, 6500.00, 0.00, 3, 'L07 selfie stick with ring light', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:20:22', NULL),
(482, 'USB Tv Stick', '000318', 3, 5700.00, 0.00, 1, 'USB Tv Stick', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:20:58', NULL),
(483, 'LG External dvd writer N360', '000319', 5, 13000.00, 0.00, 2, 'LG External dvd writer N360', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:22:00', NULL),
(484, 'Zealot B36NC bluetooth headset', '000320', 1, 10200.00, 0.00, 2, 'Zealot B36NC bluetooth headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:23:10', NULL),
(485, 'Dlink 1024AD 24ports desktop switch', '000321', 1, 26000.00, 0.00, 1, 'Dlink 1024AD 24ports desktop switch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:29:52', NULL),
(486, 'Internal keyboard Hp 15', '000506', 5, 4000.00, 0.00, 1, 'Internal keyboard Hp 15', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:30:36', NULL),
(487, 'Internal keyboard Dell 5010', '000507', 5, 4000.00, 0.00, 1, 'Internal keyboard Dell 5010', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:31:13', NULL),
(488, 'Internal keyboard Dell 1525', '000508', 5, 4000.00, 0.00, 1, 'Internal keyboard Dell 1525', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:31:51', NULL),
(489, 'Internal keyboard Toshiba C850', '000509', 3, 4000.00, 0.00, 1, 'Internal keyboard Toshiba C850', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:33:10', NULL),
(490, 'Internal keyboard Toshiba C660', '000510', 3, 4000.00, 0.00, 1, 'Internal keyboard Toshiba C660', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:33:20', NULL),
(491, 'Desktop cable', '000520', 5, 400.00, 0.00, 16, 'Desktop cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:36:37', NULL),
(492, '05A  Toner', '000521', 3, 5000.00, 0.00, 1, '05A  Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:36:47', NULL),
(493, '53A  Toner', '000522', 5, 5000.00, 0.00, 1, '53A  Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:37:40', NULL),
(494, '12A  Toner', '000523', 5, 4500.00, 0.00, 1, '12A  Toner000523', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:38:42', NULL),
(495, '85A  Toner', '000524', 3, 4500.00, 0.00, 1, '85A  Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:39:18', NULL),
(496, '83A   Toner', '000526', 3, 4500.00, 0.00, 1, '83A   Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:40:49', NULL),
(497, '26A  Toner', '000527', 3, 10000.00, 0.00, 1, '26A  Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:41:22', NULL),
(498, 'DVD writer (External)', '000528', 1, 14000.00, 0.00, 1, 'DVD writer (External)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:41:50', NULL),
(499, 'Networking Tools ', '000529', 5, 1400.00, 0.00, 1, 'Networking Tools ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:43:56', NULL),
(500, 'Microsoft Webcam HD 3000', '000530', 1, 17000.00, 0.00, 2, 'Microsoft Webcam HD 3000', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:45:11', NULL),
(501, 'Hp DvD RAM', '000531', 1, 12500.00, 0.00, 1, 'Hp DvD RAM', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:45:43', NULL),
(502, 'X printer small one ', '000468', 3, 9000.00, 0.00, 2, 'X printer small one ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:59:34', NULL),
(503, 'Refill Toner ', '000469', 3, 1300.00, 0.00, 5, 'Refill Toner ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 16:59:37', NULL),
(504, 'HD Webcam ', '000470', 5, 3000.00, 0.00, 0, 'HD Webcam ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:02:00', NULL),
(505, 'C D   Case', '000532', 3, 12.00, 0.00, 87, 'C D   Case', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:02:25', NULL),
(506, 'HD Webcam stand', '000471', 5, 3000.00, 0.00, 1, 'HD Webcam stand', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:02:38', NULL),
(507, 'Hp Cq62 battery for laptop', '000472', 5, 5700.00, 0.00, 2, 'Hp Cq62 battery for laptop', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:04:59', NULL),
(508, 'Hp DV4 laptop battery', '000473', 3, 5700.00, 0.00, 3, 'Hp DV4 laptop battery', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:12:46', NULL),
(509, 'Hp Laptop battery 6535', '000474', 3, 5700.00, 0.00, 2, 'Hp Laptop battery 6535', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:13:30', NULL),
(510, 'Hp Laptop Battery 8460', '000475', 3, 5700.00, 0.00, 4, 'Hp Laptop Battery 8460', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:14:31', NULL),
(511, 'HP Laptop battery DV2000', '000476', 3, 5700.00, 0.00, 3, 'HP Laptop battery DV2000', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:15:04', NULL),
(512, 'HP Laptop battery 6735', '000477', 3, 5700.00, 0.00, 3, 'HP Laptop battery 6735', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:15:53', NULL),
(513, 'HP laptop battery 4515', '000478', 3, 5700.00, 0.00, 3, 'HP laptop battery 4515', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:16:54', NULL),
(514, 'HP laptop battery 620', '000479', 3, 5700.00, 0.00, 3, 'HP laptop battery 620', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:17:09', NULL),
(515, 'HP laptop battery 4530', '000480', 3, 5700.00, 0.00, 3, 'HP laptop battery 4530', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:18:05', NULL),
(516, 'Hp Laptop battery 0A04', '000481', 5, 6000.00, 0.00, 3, 'Hp Laptop battery 0A04', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:19:37', NULL),
(517, 'HP Laptop battery HS04', '000482', 3, 6000.00, 0.00, 2, 'HP Laptop battery HS04', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:20:47', NULL),
(518, 'HP laptop battery JC04', '000483', 3, 6500.00, 0.00, 3, 'HP laptop battery JC04', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:21:17', NULL),
(519, 'HP laptop battery 640-G1', '000484', 3, 6000.00, 0.00, 1, 'HP laptop battery 640-G1', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:21:56', NULL),
(520, 'Dell Laptop battery 5010', '000485', 5, 5700.00, 0.00, 2, 'Dell Laptop battery 5010', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:23:01', NULL),
(521, 'Dell Laptop battery 1525', '000486', 3, 5700.00, 0.00, 3, 'Dell Laptop battery 1525', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:23:58', NULL),
(523, 'Dell Laptop battery E5400', '000488', 5, 5700.00, 0.00, 3, 'Dell Laptop battery E5400', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:25:10', NULL),
(524, 'Dell Laptop battery 3521', '000490', 3, 0.00, 0.00, 3, 'Dell Laptop battery 3521', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:27:15', NULL),
(525, 'Dell laptop battery V131', '000491', 3, 0.00, 0.00, 3, 'Dell laptop battery V131', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:27:22', NULL),
(526, 'Dell Laptop battery E6400', '000489', 3, 5700.00, 0.00, 3, 'Dell Laptop battery E6400', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:27:30', NULL),
(527, 'Dell Laptop battery E6420', '000492', 3, 9000.00, 0.00, 3, 'Dell Laptop battery E6420', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:28:27', NULL),
(528, 'Dell laptop battery E6320', '000493', 3, 0.00, 0.00, 3, 'Dell laptop battery E6320', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:29:29', NULL),
(529, 'Acer laptop battery 4741', '000494', 3, 5700.00, 0.00, 2, 'Acer laptop battery 4741', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:29:38', NULL),
(530, 'Acer laptop battery 4710', '000495', 3, 0.00, 0.00, 3, 'Acer laptop battery 4710', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:30:46', NULL),
(531, 'Acer laptop battery 756', '000496', 3, 0.00, 0.00, 3, 'Acer laptop battery 756', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:30:56', NULL),
(532, 'Acer laptop battery D255', '000497', 3, 0.00, 0.00, 3, 'Acer laptop battery D255', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:31:30', NULL),
(533, 'Toshiba laptop battery 3534', '000499', 3, 5700.00, 0.00, 3, 'Toshiba laptop battery 3534', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:32:32', NULL),
(534, 'Toshiba laptop battery 3817', '000498', 3, 5700.00, 0.00, 3, 'Toshiba laptop battery 3817', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:33:08', NULL),
(535, 'Toshiba laptop battery 5024', '000500', 3, 5700.00, 0.00, 3, 'Toshiba laptop battery 5024', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:34:07', NULL),
(536, 'Bluegate UPS 1.2KVA', '000501', 3, 31000.00, 0.00, 1, 'Bluegate UPS 1.2KVA', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:34:46', NULL),
(537, 'Internal keyboard Acer 4741', '000502', 3, 4000.00, 0.00, 1, 'Internal keyboard Acer 4741', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:35:28', NULL),
(538, 'Internal keyboard HP 250g4', '000504', 3, 4000.00, 0.00, 1, 'Internal keyboard HP 250g4', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:38:43', NULL),
(539, 'Internal keyboard Hp630', '000505', 3, 3500.00, 0.00, 1, 'Internal keyboard Hp630', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:39:07', NULL);
INSERT INTO `stock_ins` (`id`, `stock_name`, `stock_unique_id`, `stock_category_id`, `stock_costprice`, `stock_price`, `stock_qty`, `stock_description`, `memo`, `date_created`, `date_updated`) VALUES
(540, 'Tiger uninterrupted power supply TDC 1100', '000533', 5, 13000.00, 0.00, 3, 'Tiger uninterrupted power supply TDC 1100', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:40:45', NULL),
(541, 'Cat 6 cable ', '000534', 5, 17000.00, 0.00, 1, 'Cat 6 cable ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-14 17:41:53', NULL),
(542, 'Dell Laptop battery D620', '000487', 5, 5700.00, 0.00, 3, 'Dell Laptop battery D620', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-15 09:07:46', NULL),
(543, 'USB C 30W power adapter', '000329', 1, 14000.00, 0.00, 5, 'USB C 30W power adapter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-15 10:25:47', NULL),
(544, 'FIL Impact 7 charger ', '000381', 1, 500.00, 0.00, 84, 'FIL Impact 7 charger ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-15 10:44:25', NULL),
(545, 'JBL Bluetooth ZON 10', '000399', 5, 2500.00, 0.00, 1, 'JBL Bluetooth ZON 10', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-15 11:27:30', NULL),
(546, 'Infinix hot 10lite pouch', '000407', 3, 480.00, 0.00, 3, 'Infinix hot 10lite pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-15 11:40:53', NULL),
(547, '36A   Toner', '000525', 3, 4500.00, 0.00, 1, '36A   Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-15 12:48:29', NULL),
(548, 'HDD  Case 3.0', '000453', 1, 2700.00, 0.00, 7, 'HDD  Case 3.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-15 13:25:20', NULL),
(549, 'Itelli mobile phone charger', '000535', 5, 230.00, 0.00, 84, 'Itelli mobile phone charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-21 15:12:15', NULL),
(550, 'Iphone 11 privacy screen guard', '000536', 5, 500.00, 0.00, 2, 'Iphone 11 privacy screen guard', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-23 10:15:09', NULL),
(551, 'Iphone 13 pouch silicon', '000537', 5, 1100.00, 0.00, 2, 'Iphone 13 pouch silicon', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-24 16:29:20', NULL),
(552, 'Iphone 13pro pouch cartoon', '000538', 3, 500.00, 0.00, 2, 'Iphone 13pro pouch cartoon', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-24 16:31:45', NULL),
(553, 'Iphone 13promax cartoon pouch', '000539', 3, 500.00, 0.00, 2, 'Iphone 13promax cartoon pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-24 16:33:16', NULL),
(554, 'Iphone 11pro cartoon pouch', '000540', 5, 500.00, 0.00, 2, 'Iphone 11pro cartoon pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-24 16:35:37', NULL),
(555, 'Oraimo smart watch osw-20', '000541', 1, 19500.00, 0.00, 8, 'Oraimo smart watch osw-20', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-24 16:37:08', NULL),
(556, 'Oraimo speaker Obs-72D', '000542', 1, 33000.00, 0.00, 2, 'Oraimo speaker Obs-72D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-24 16:41:54', NULL),
(557, 'Iphone 13promax glass 5D', '000543', 3, 900.00, 0.00, 5, 'Iphone 13promax glass 5D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-24 16:43:29', NULL),
(558, 'Iphone 13pro glass 5D', '000544', 3, 900.00, 0.00, 5, 'Iphone 13pro glass 5D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-24 16:45:22', NULL),
(559, 'Iphone XR 5D glass', '000545', 3, 400.00, 0.00, 1, 'Iphone XR 5D glass', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-24 16:46:49', NULL),
(560, 'FIL f2plus portable elctric fan', '000546', 3, 4500.00, 0.00, 2, 'FIL f2plus portable elctric fan', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-28 12:38:42', NULL),
(561, 'Thermal printer', '000547', 3, 13500.00, 0.00, 1, 'Thermal printer', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-28 12:40:37', NULL),
(562, 'Fil socket s006', '000548', 5, 4500.00, 0.00, 0, 'Fil socket s006', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-02-28 12:56:42', NULL),
(564, 'Hp laptop charger 19.5v big pin', '000555', 1, 2100.00, 0.00, 4, 'Hp laptop charger 19.5v big pin', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:17:57', NULL),
(565, 'Toshiba laptop charger', '000549', 1, 1600.00, 0.00, 5, 'Toshiba laptop charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:21:10', NULL),
(566, 'Acer laptop charger', '000550', 1, 1600.00, 0.00, 2, 'Acer laptop charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:28:46', NULL),
(567, 'Dell laptop charger', '000551', 5, 2300.00, 0.00, 3, 'Dell laptop charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:29:16', NULL),
(568, 'Hp flash drive 2gb', '000552', 3, 800.00, 0.00, 1, 'Hp flash drive 2gb', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:29:45', NULL),
(569, 'Digirich sleek usb flash drive 16gb', '000553', 5, 1600.00, 0.00, 3, 'Digirich sleek usb flash drive 16gb', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:31:51', NULL),
(570, 'Labsonic headset small', '000556', 1, 2000.00, 0.00, 3, 'Labsonic headset small', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:35:25', NULL),
(571, 'Egghead headset G-1312', '000557', 1, 2500.00, 0.00, 1, 'Egghead headset G-1312', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:50:35', NULL),
(572, 'Egghead headset G-964', '000558', 1, 7000.00, 0.00, 1, 'Egghead headset G-964', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:52:50', NULL),
(573, 'Acoustics 6012 headset', '000559', 1, 4000.00, 0.00, 1, 'Acoustics 6012 headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:54:11', NULL),
(574, 'Software windows 11 (64bit)', '000560', 3, 450.00, 0.00, 1, 'Software windows 11 (64bit)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:56:27', NULL),
(575, 'Gkm520 wireless keyboard and mouse', '000554', 1, 4500.00, 0.00, 2, 'Gkm520 wireless keyboard and mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:56:30', NULL),
(576, 'Software windows 8(32/64bit)', '000561', 3, 150.00, 0.00, 1, 'Software windows 8 (32/64bit)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:58:20', NULL),
(577, 'Software windows 10 (64bits)', '000562', 3, 150.00, 0.00, 0, 'Software windows 10 (64bits)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 11:59:38', NULL),
(578, 'Software windows 8.1 (32/64bit)', '000563', 3, 150.00, 0.00, 0, 'Software windows 8.1 (32/64bit)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:01:05', NULL),
(579, 'Software windows 7', '000564', 3, 150.00, 0.00, 0, 'Software windows 7', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:09:01', NULL),
(580, 'Software Ease Us (data recovery)', '000565', 3, 150.00, 0.00, 1, 'Software Ease Us (data recovery)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:11:36', NULL),
(582, 'Software recover it', '00056', 3, 0.00, 0.00, 0, 'Software recover it', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:13:58', NULL),
(583, 'Software driverpack 16 ', '000568', 3, 450.00, 0.00, 1, 'Software driverpack 16 ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:14:30', NULL),
(584, 'Software Autodesk Autocad  2018', '000569', 3, 150.00, 0.00, 1, 'Software Autodesk Autocad  2018', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:16:28', NULL),
(585, 'Software Autodesk Autocad 2017', '000570', 3, 150.00, 0.00, 1, 'Software Autodesk Autocad 2017', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:17:16', NULL),
(586, 'Software Autodesk Autocad 2013(32bit)', '000571', 3, 150.00, 0.00, 1, 'Software Autodesk Autocad 2013(32bit)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:18:31', NULL),
(587, 'Software Autocad 2010(64bit)', '000572', 3, 150.00, 0.00, 1, 'Software Autocad 2010(64bit)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:18:40', NULL),
(588, 'Software Autodesk revit 2016', '000573', 3, 150.00, 0.00, 0, 'Software Autodesk revit 2016', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:22:56', NULL),
(589, 'Software Autodesk maya 2022', '000574', 3, 150.00, 0.00, 1, 'Software Autodesk maya 2022', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:29:31', NULL),
(590, 'Software Autodesk 3Ds max 2017', '000575', 3, 150.00, 0.00, 0, 'Software Autodesk 3Ds max 2017', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:30:44', NULL),
(591, 'Software Autodesk 3Ds max 2018', '000576', 5, 150.00, 0.00, 1, 'Software Autodesk 3Ds max 2018', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:31:53', NULL),
(592, 'Software wirecast live streaming 2021', '000578', 3, 150.00, 0.00, 1, 'Software wirecast live streaming 2021', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:33:27', NULL),
(593, 'Software Obs Sudio full crack', '000579', 3, 150.00, 0.00, 1, 'Software Obs Sudio full crack', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:34:01', NULL),
(594, 'Software Pc study bible version 5', '000580', 3, 150.00, 0.00, 0, 'Software Pc study bible version 5', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:35:21', NULL),
(595, 'Software ilumina live the bible', '000581', 3, 150.00, 0.00, 1, 'Software ilumina live the bible', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:36:04', NULL),
(596, 'Software Power bible CD', '000582', 3, 150.00, 0.00, 1, 'Software Power bible CD', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:36:48', NULL),
(597, 'SOftware Hiren`s boot CD( reboot)', '000583', 3, 150.00, 0.00, 1, 'SOftware Hiren`s boot CD( reboot)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:37:44', NULL),
(598, 'Software Intuit quick books point of sale', '000584', 3, 150.00, 0.00, 1, 'Software Intuit quick books point of sale', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:38:55', NULL),
(599, 'Software Mega 45 with drivers', '000585', 3, 150.00, 0.00, 1, 'Software Mega 45 with drivers', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:41:17', NULL),
(600, 'Software Mega 30 professional', '000586', 3, 150.00, 0.00, 1, 'Software Mega 30 professional', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:41:50', NULL),
(601, 'Software Omega 14+', '000587', 3, 150.00, 0.00, 1, 'Software Omega 14+', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:42:21', NULL),
(602, 'SOftware Mega 40 professional', '000588', 3, 150.00, 0.00, 1, 'SOftware Mega 40 professional', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:43:33', NULL),
(603, 'Software Dgfoto Art', '000608', 3, 150.00, 0.00, 1, 'Software Dgfoto Art', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:46:36', NULL),
(604, 'Software COreldraw with crack 2020', '000609', 5, 150.00, 0.00, 0, 'Software COreldraw with crack 2020', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:47:18', NULL),
(605, 'Software COreldraw with crack 2019', '000610', 3, 150.00, 0.00, 1, 'Software COreldraw with crack 2019', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:49:47', NULL),
(606, 'Software COreldraw with crack 2018', '000611', 5, 150.00, 0.00, 1, 'Software COreldraw with crack 2018', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:50:41', NULL),
(607, 'Software COreldraw with crack 2021', '000612', 3, 150.00, 0.00, 0, 'Software COreldraw with crack 2021', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:52:48', NULL),
(608, 'Software COreldraw X9', '000613', 3, 150.00, 0.00, 1, 'Software COreldraw X9', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:53:46', NULL),
(609, 'Software COreldraw with crack X7', '000614', 3, 150.00, 0.00, 1, 'Software COreldraw with crack X7', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:55:09', NULL),
(610, 'Software COreldraw with crack X6', '000616', 3, 150.00, 0.00, 1, 'Software COreldraw with crack X6', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:56:28', NULL),
(611, 'Software COreldraw with crack X8', '000615', 3, 150.00, 0.00, 1, 'Software COreldraw with crack X8', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:56:31', NULL),
(612, 'Software COreldraw with crack X4', '000617', 3, 150.00, 0.00, 1, 'Software COreldraw with crack X4', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 12:59:10', NULL),
(613, 'Software Corel videostudio X10 (video creator)', '000618', 3, 150.00, 0.00, 1, 'Software Corel video X10 (video creator)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:01:05', NULL),
(614, 'Software Media suite 14(video creator)', '000619', 3, 150.00, 0.00, 1, 'Software Media suite 14(video creator)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:02:18', NULL),
(615, 'Software Moho pro 13(video ceator)', '000620', 3, 150.00, 0.00, 1, 'Software Moho pro 13(video ceator)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:03:29', NULL),
(616, 'Software Pinnacle studio (video creator)', '000621', 3, 300.00, 0.00, 1, 'Software Pinnacle studio (video creator)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:05:06', NULL),
(617, 'Software Filmora version 10 (video creator)', '000622', 3, 150.00, 0.00, 1, 'Software Filmora version 10 (video creator)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:08:34', NULL),
(618, 'Software microsoft office 2016', '000623', 5, 150.00, 0.00, 0, 'Software microsoft office 2016', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:08:42', NULL),
(619, 'Software microsoft office 2010', '000624', 3, 150.00, 0.00, 0, 'Software microsoft office 2010', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:10:14', NULL),
(620, 'Software microsoft office 2013', '000625', 3, 150.00, 0.00, 1, 'Software microsoft office 2013', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:15:39', NULL),
(621, 'Software microsoft office 2019', '000626', 3, 150.00, 0.00, 0, 'Software microsoft office 2019', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:17:38', NULL),
(622, 'Software microsoft office 2021', '000589', 3, 150.00, 0.00, 0, 'Software microsoft office 2021', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:18:32', NULL),
(623, 'Software Adobe master collection 2022', '000590', 3, 750.00, 0.00, 1, 'Software Adobe master collection 2022', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:21:36', NULL),
(624, 'Software Adobe collection 2021', '000591', 5, 750.00, 0.00, 0, 'Software Adobe collection 2021', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:27:08', NULL),
(625, 'Software Visual studio 2019', '000592', 3, 750.00, 0.00, 1, 'Software Visual studio 2019', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:28:41', NULL),
(626, 'Software R2020a with crack matlab', '000593', 3, 750.00, 0.00, 1, 'Software R2020a with crack matlab', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:30:10', NULL),
(627, 'Software Java 8', '000594', 3, 150.00, 0.00, 1, 'Software Java 8', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:31:37', NULL),
(628, 'Software Snappy driver installer', '000595', 3, 750.00, 0.00, 1, 'Software Snappy driver installer', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:32:32', NULL),
(629, 'Software deep excavation snailplus 2012', '000596', 3, 150.00, 0.00, 1, 'Software deep excavation snailplus 2012', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:33:57', NULL),
(630, 'Software Lumion 10pro with crack', '000597', 3, 600.00, 0.00, 1, 'Software Lumion 10pro with crack', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:35:40', NULL),
(631, 'Software Autodesk revit 2021 with crack', '000598', 3, 750.00, 0.00, 0, 'Software Autodesk revit 2021 with crack', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:36:58', NULL),
(632, 'Software Autodesk Autocad 2022', '000599', 3, 150.00, 0.00, 0, 'Software Autodesk Autocad 2022', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:37:31', NULL),
(633, 'Software Autodesk Autocad 2021', '000600', 3, 150.00, 0.00, 1, 'Software Autodesk Autocad 2021', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:41:21', NULL),
(634, 'Software Autodesk Navisworks 2021', '000601', 3, 150.00, 0.00, 1, 'Software Autodesk Navisworks 2021', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:42:45', NULL),
(635, 'Software Geotechnical software', '000603', 3, 150.00, 0.00, 1, 'Software Geotechnical software', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:46:56', NULL),
(636, 'Software Adobe captivate live streaming ', '000604', 3, 150.00, 0.00, 1, 'Software Adobe captivate live streaming ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:47:46', NULL),
(637, 'Software LUmion 6.0', '000605', 3, 300.00, 0.00, 1, 'Software LUmion 6.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:48:44', NULL),
(638, 'Software Vmix video mixing software v24', '000606', 3, 150.00, 0.00, 1, 'Software Vmix video mixing software v24', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:49:57', NULL),
(639, 'Software Autodesk Autocad plant 3D 2022', '000607', 3, 150.00, 0.00, 1, 'Software Autodesk Autocad plant 3D 2022', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:51:18', NULL),
(640, 'Software Statistics with stata version 12', '000627', 3, 150.00, 0.00, 1, 'Software Statistics with stata version 12', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:52:24', NULL),
(641, 'Software Pro accounting 2017 sage 50', '000628', 3, 150.00, 0.00, 1, 'Software Pro accounting 2017 sage 50', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:53:49', NULL),
(642, 'Software Ibm spss statistics 23', '000629', 3, 150.00, 0.00, 0, 'Software Ibm spss statistics 23', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:55:25', NULL),
(643, 'Software Ibm spss statistics 26', '000630', 3, 150.00, 0.00, 0, 'Software Ibm spss statistics 26', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-01 13:57:16', NULL),
(644, 'Software recover it', '000567', 3, 150.00, 0.00, 1, 'Software recover it', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-02 09:03:10', NULL),
(645, 'Software Autodesk Navisworks 2021', '000602', 5, 150.00, 0.00, 1, 'Software Autodesk Navisworks 2021', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-02 09:26:01', NULL),
(646, 'Software ArcGis (data recovery)', '000566', 3, 150.00, 0.00, 0, 'Software ArcGis (data recovery)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-02 11:44:00', NULL),
(647, 'Tecno T352', '000631', 3, 7000.00, 0.00, 1, 'Tecno T352', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-17 13:22:28', NULL),
(648, 'Tecno T313', '000632', 3, 6600.00, 0.00, 3, 'Tecno T313', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-17 13:23:56', NULL),
(649, 'Transaparent 2A charger KIT NC03', '000633', 1, 1120.00, 0.00, 14, 'Transaparent 2A charger KIT NC03', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-28 14:17:42', NULL),
(650, 'Transparent Fast charger KIT FC02', '000634', 1, 2150.00, 0.00, 5, 'Transparent Fast charger KIT FC02', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-28 14:19:19', NULL),
(651, 'TRansaparent 32gb multifunction otg flashdrive', '000635', 3, 4000.00, 0.00, 9, 'TRansaparent 32gb multifunction otg flashdrive', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-28 14:20:14', NULL),
(652, 'TRansaparent 64gb multifunction otg flashdrive', '000636', 3, 5000.00, 0.00, 1, 'Transaparent 64gb multifunction otg flashdrive', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-03-28 14:21:52', NULL),
(653, 'Itel powerbank Star 200(20000mah)', '000637', 1, 4500.00, 0.00, 13, 'Itel powerbank Star 200(20000mah)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-04 12:56:16', NULL),
(654, 'Itel powerbank Star 100(10000mah)', '000638', 1, 3300.00, 0.00, 14, 'Itel powerbank Star 100(10000mah)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-04 12:56:57', NULL),
(655, 'Itel 2ports charger', '000639', 1, 1100.00, 0.00, 11, 'Itel 2port charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-04 12:59:35', NULL),
(656, 'Havit M67 Speaker', '000640', 1, 5000.00, 0.00, 1, 'Havit M67 Speaker', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-05 08:42:59', NULL),
(657, 'Havit Sk800bt speaker', '000641', 1, 4200.00, 0.00, 1, 'Havit Sk800bt speaker', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-05 08:43:49', NULL),
(658, 'Havit M3 Speaker', '000642', 1, 4500.00, 0.00, 0, 'Havit M3 Speaker', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-05 08:44:26', NULL),
(659, 'Havit H193D Headset', '000643', 3, 3500.00, 0.00, 0, 'Havit H193D Headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-05 08:45:40', NULL),
(660, 'Havit 30000mah powerbank', '000644', 5, 11000.00, 0.00, 2, 'Havit 30000mah powerbank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-05 08:46:21', NULL),
(661, 'Tecno Tws earphone BD02 black', '000645', 1, 6400.00, 0.00, 2, 'Tecno Tws earphone BD02 black', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-05 17:29:00', NULL),
(662, 'Tecno charger Tcw_U01D(white) double output', '000646', 1, 2230.00, 0.00, 87, 'Tecno charger Tcw_U01D(white) double output', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-05 17:30:04', NULL),
(663, 'Tecno A3 (Tws earphone)', '000647', 5, 2300.00, 0.00, 27, 'Tecno A3 (Tws earphone)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-06 15:05:19', NULL),
(664, 'Tecno M1 Earbud', '000648', 1, 4100.00, 0.00, 37, 'Tecno M1 Earbud', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-06 15:06:13', NULL),
(665, 'Tecno  4g portable wifi TR109', '000649', 5, 15500.00, 0.00, 13, 'Tecno  4g portable wifi TR109', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-23 16:39:23', NULL),
(666, 'Oraimo  bud OEB-EO2D Riff', '000650', 1, 9100.00, 0.00, 26, 'Oraimo  bud OEB-EO2D Riff', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-28 14:47:08', NULL),
(667, 'Oraimo 40,000mah powerbank', '000651', 1, 16800.00, 0.00, 13, 'Oraimo 40,000mah powerbank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-28 14:48:02', NULL),
(668, 'Laptop dell 3340 intel core i5 ', '000712', 3, 90000.00, 0.00, 3, 'Laptop dell 3340 intel core i5 ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 13:03:47', NULL),
(669, 'Hp probook 440G1 core i5 laptop', '000713', 3, 100000.00, 0.00, 0, 'Hp probook 440G1 core i5 laptop', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 13:05:16', NULL),
(670, 'Hp probook 440G2 core i5 laptop', '000714', 3, 100000.00, 0.00, 0, 'Hp probook 440G2 core i5 laptop', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 13:06:15', NULL),
(671, 'Lenovo Thinkpad X250 Core i5 laptop', '000715', 3, 100000.00, 0.00, 0, 'Lenovo Thinkpad X250 Core i5 laptop', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 13:07:04', NULL),
(672, 'Sandisk 32gb SD Extreme pro', '000733', 1, 6000.00, 0.00, 2, 'Sandisk 32gb SD Extreme pro', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:20:41', NULL),
(673, 'Hp mini laptop charger', '000652', 5, 1400.00, 0.00, 3, 'Hp mini laptop charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:24:04', NULL),
(674, 'Dell Laptop charger type C 30w', '000654', 5, 9000.00, 0.00, 1, 'Dell Laptop charger type C 30w', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:26:20', NULL),
(675, 'Dell Laptop CHarger small mouth', '000653', 1, 2200.00, 0.00, 6, 'Dell Laptop CHarger small mouth', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:27:18', NULL),
(676, 'Dell Laptop Charger type 65w ', '000655', 1, 11500.00, 0.00, 1, 'Dell Laptop Charger type 65w ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:37:57', NULL),
(677, 'Dell Laptop charger type c 90w ', '000656', 1, 13000.00, 0.00, 1, 'Dell Laptop charger type c 90w ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:38:57', NULL),
(678, 'Hp Laptop charger type C', '000657', 1, 9000.00, 0.00, 2, 'Hp Laptop charger type C', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:39:38', NULL),
(679, 'Sony Laptop charger 19.5v', '000658', 1, 1900.00, 0.00, 2, 'Sony Laptop charger 19.5v', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:40:22', NULL),
(680, 'Asus Laptop Charger Pin 19v ', '000659', 1, 1500.00, 0.00, 4, 'Asus Laptop Charger Pin 19v ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:42:05', NULL),
(681, 'Lenovo USB laptop charger ', '000661', 1, 2000.00, 0.00, 5, 'Lenovo USB laptop charger ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:49:05', NULL),
(682, 'Lenovo big mouth laptop charger', '000662', 1, 1800.00, 0.00, 4, 'Lenovo big mouth laptop charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:51:29', NULL),
(683, 'Lenovo small mouth laptop charger', '000663', 1, 1800.00, 0.00, 5, 'Lenovo small mouth laptop charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:52:13', NULL),
(684, 'Samsung laptop charger', '000664', 1, 1400.00, 0.00, 3, 'Samsung laptop charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:54:36', NULL),
(685, 'Toshiba laptop charger mini', '000665', 1, 1400.00, 0.00, 2, 'Toshiba laptop charger mini', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:55:30', NULL),
(686, 'Black skin laptop cover', '000666', 1, 400.00, 0.00, 5, 'Black skin laptop cover', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:57:55', NULL),
(687, 'Lavalier Microphone (Aux)', '000667', 1, 1500.00, 0.00, 5, 'Lavalier Microphone (Aux)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:58:50', NULL),
(688, 'Lavalier Microphone (type C)', '000668', 1, 1500.00, 0.00, 1, 'Lavalier Microphone (type C)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 15:59:23', NULL),
(689, 'Type C to Type C cord', '000669', 3, 1500.00, 0.00, 2, 'Type C to Type C cord', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:00:18', NULL),
(690, 'Type C to Usb Lan', '000670', 1, 3000.00, 0.00, 10, 'Type C to Usb Lan', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:01:12', NULL),
(691, 'Type C 3 in 1 hub', '000671', 5, 3500.00, 0.00, 3, 'Type C 3 in 1 hub', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:01:48', NULL),
(692, 'Type C 8 in 1 hub', '000672', 5, 13500.00, 0.00, 2, 'Type C 8 in 1 hub', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:02:51', NULL),
(693, 'Web Cam full Hd', '000673', 1, 3000.00, 0.00, 10, 'Web Cam full Hd', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:03:26', NULL),
(694, '5v power adapter ', '000674', 3, 700.00, 0.00, 5, '5v power adapter ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:04:34', NULL),
(695, '9v power adapter ', '000675', 3, 700.00, 0.00, 5, '9v power adapter ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:05:06', NULL),
(696, '12v power adapter ', '000676', 3, 700.00, 0.00, 4, '12v power adapter ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:05:46', NULL),
(697, 'Usb light ', '000677', 1, 300.00, 0.00, 6, 'Usb light ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:06:18', NULL),
(698, 'Hp glass mouse red', '000678', 5, 1500.00, 0.00, 0, 'Hp glass mouse red', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:07:08', NULL),
(699, 'USB to SATA 3.0', '000679', 1, 2500.00, 0.00, 3, 'USB to SATA 3.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:07:59', NULL),
(700, 'USB Midi cable (sound output)', '000680', 1, 2700.00, 0.00, 2, 'USB Midi cable (sound output)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:09:47', NULL),
(701, 'Presenter (pointer)', '000681', 1, 2500.00, 0.00, 3, 'Presenter (pointer)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:11:07', NULL),
(702, 'Wifi ANTENNA', '000682', 1, 1500.00, 0.00, 1, 'Wifi ANTENNA', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:11:47', NULL),
(703, 'Easy Capture ', '000683', 1, 2500.00, 0.00, 2, 'Easy Capture ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:12:33', NULL),
(704, 'Network cable tester', '000684', 1, 1500.00, 0.00, 1, 'Network cable tester', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:13:23', NULL),
(705, 'Handboss Foaming Cleaner', '000685', 3, 1000.00, 0.00, 4, 'Handboss Foaming Cleaner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:14:03', NULL),
(706, 'Bluetooth Keyboard ', '000686', 5, 3500.00, 0.00, 3, 'Bluetooth Keyboard ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:15:22', NULL),
(707, 'Wireless keyboard mini with mouse coated keyboard', '000687', 1, 4200.00, 0.00, 4, 'Wireless keyboard mini with mouse coated keyboard', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 16:24:57', NULL),
(708, 'LDNIO 3 in 1 fast charger A3308Q', '000705', 1, 3000.00, 0.00, 2, 'LDNIO 3 in 1 fast charger A3308Q', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:15:03', NULL),
(709, 'LDNIO 4 in 1 car charger ', '000706', 1, 2400.00, 0.00, 5, 'LDNIO 4 in 1 car charger ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:16:06', NULL),
(710, 'LDNIO LC102 Type C Type C 2M ', '000707', 1, 2200.00, 0.00, 5, 'LDNIO LC102 Type C Type C 2M ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:17:21', NULL),
(711, 'Iphone to Type C cable cord', '000708', 1, 2500.00, 0.00, 8, 'Iphone to Type C cable cord', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:18:05', NULL),
(712, 'OTG Type C cable', '000709', 1, 900.00, 0.00, 3, 'OTG Type C cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:18:41', NULL),
(713, 'Yoobao PD/65W 30000mah laptop powerbank', '000710', 1, 30000.00, 0.00, 2, 'Yoobao PD/65W 30000mah laptop powerbank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:21:12', NULL),
(714, 'HDMI to Type C 4k cable HC60', '000711', 1, 5500.00, 0.00, 2, 'HDMI to Type C 4k cable HC60', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:22:01', NULL),
(715, 'Kaspersky Antivirus PC', '000716', 3, 6500.00, 0.00, 1, 'Kaspersky Antivirus PC', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:25:10', NULL),
(716, 'Kaspersky Interner Security PC', '000717', 3, 8700.00, 0.00, 1, 'Kaspersky Interner Security PC', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:26:02', NULL),
(717, 'Norton Antivirus 1 device', '000718', 3, 3500.00, 0.00, 2, 'Norton Antivirus 1 device', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:27:17', NULL),
(718, 'Norton Security deluxe 1 device', '000719', 3, 4000.00, 0.00, 3, 'Norton Security deluxe 1 device', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:28:06', NULL),
(719, 'Quick heal Antivirus pro 1pc', '000720', 3, 2200.00, 0.00, 2, 'Quick heal Antivirus pro 1pc', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:29:57', NULL),
(720, 'Quick heal Internet Security 1 user', '000721', 3, 3300.00, 0.00, 3, 'Quick heal Internet Security 1 user', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:32:57', NULL),
(721, 'PS 2 wireless pad', '000722', 1, 2700.00, 0.00, 2, 'PS 2 wireless pad', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:38:35', NULL),
(722, 'PS 3 Game Pad', '000723', 3, 2800.00, 0.00, 2, 'PS 3 Game Pad', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:39:26', NULL),
(723, 'TCL SOCL 100BT Necktone', '000724', 1, 3500.00, 0.00, 3, 'TCL SOCL 100BT Necktone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:40:41', NULL),
(724, 'TCL MTRO 100BT Necktone', '000725', 1, 7000.00, 0.00, 2, 'TCL MTRO 100BT Necktone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:41:22', NULL),
(725, 'Youth buds Necktone', '000726', 1, 2600.00, 0.00, 3, 'Youth buds Necktone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:42:13', NULL),
(726, 'Jbl Tm Stereo bluetooth headphone', '000727', 1, 3700.00, 0.00, 2, 'Jbl Tm Stereo bluetooth headphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:43:27', NULL),
(727, 'Sandisk 64gb SD with card reader', '000728', 1, 4700.00, 0.00, 3, 'Sandisk 64gb SD with card reader', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:44:49', NULL),
(728, 'Sandisk 128gb SD with card reader', '000729', 1, 8400.00, 0.00, 2, 'Sandisk 128gb SD with card reader', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:46:50', NULL),
(729, 'Sandisk 32gb SD with card reader', '000730', 1, 3200.00, 0.00, 3, 'Sandisk 32gb SD with card reader', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:49:08', NULL),
(730, 'Sandisk 128gb SD Extreme  pro', '000731', 1, 16500.00, 0.00, 1, 'Sandisk 128gb SD Extreme  pro', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:50:39', NULL),
(731, 'Sandisk 64gb SD Extreme  pro', '000732', 1, 8500.00, 0.00, 1, 'Sandisk 64gb SD Extreme  pro', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:51:20', NULL),
(732, 'OTG type C to usb cable 3.0', '000734', 1, 1700.00, 0.00, 5, 'OTG type C to usb cable 3.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:52:08', NULL),
(733, 'Gaming headset GM 006', '000735', 3, 2500.00, 0.00, 10, 'Gaming headset GM 006', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:53:07', NULL),
(734, 'TV Guard Surge protection', '000736', 3, 1600.00, 0.00, 3, 'TV Guard Surge protection', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:54:20', NULL),
(735, 'Type C hub 5 in 1', '000737', 1, 9000.00, 0.00, 5, 'Type C hub 5 in 1', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:55:38', NULL),
(736, 'Toshiba 3.0 harddisk enclosure', '000738', 3, 2700.00, 0.00, 2, 'Toshiba 3.0 harddisk enclosure', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 17:56:46', NULL),
(737, 'LDNIO bluetooth FM transmitter C704Q Android', '000739', 3, 4500.00, 0.00, 10, 'LDNIO bluetooth FM transmitter C704Q Android', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:01:53', NULL),
(738, 'Ugreen Android to usb C Adapter', '000740', 5, 2000.00, 0.00, 3, 'Ugreen Android to usb C Adapter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:02:47', NULL),
(739, 'Yoobao Laptop power bank', '000741', 5, 95000.00, 0.00, 1, 'Yoobao Laptop power bank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:04:18', NULL),
(740, 'Multi media mini wire keyboard', '000688', 1, 1800.00, 0.00, 5, 'Multi media mini wire keyboard', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:08:43', NULL),
(741, 'Apple Type C 61W', '000689', 1, 14500.00, 0.00, 1, 'Apple Type C 61W', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:09:33', NULL),
(742, 'Apple Air Charger 60w ', '000690', 1, 8000.00, 0.00, 2, 'Apple Air Charger 60w ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:12:17', NULL),
(743, 'Apple pro Charger 45w', '000691', 1, 7000.00, 0.00, 1, 'Apple pro Charger 45w', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:14:03', NULL),
(744, '106A Toner', '000692', 3, 16000.00, 0.00, 3, '106A  Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:16:06', NULL),
(745, '103A  Toner', '000693', 3, 8000.00, 0.00, 3, '103A  Toner', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:16:44', NULL),
(746, 'Wired headset', '000694', 5, 2500.00, 0.00, 4, 'Wired headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:17:43', NULL),
(747, 'USB cardreader and usb hub', '000695', 5, 3500.00, 0.00, 1, 'USB cardreader and usb hub', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:20:45', NULL),
(748, 'HP laptop battery LA04', '000696', 5, 6000.00, 0.00, 2, 'HP laptop battery LA04', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:22:05', NULL),
(749, 'Acer laptop battery D725', '000697', 3, 5700.00, 0.00, 2, 'Acer laptop battery D725', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:23:31', NULL),
(750, 'Lenovo laptop battery T410', '000698', 3, 6000.00, 0.00, 2, 'Lenovo laptop battery T410', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:24:29', NULL),
(751, 'Lenovo laptop battery T430', '000699', 3, 10000.00, 0.00, 3, 'Lenovo laptop battery T430', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:26:08', NULL),
(752, 'Toshiba laptop battery 3634', '000700', 3, 5700.00, 0.00, 2, 'Toshiba laptop battery 3634', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:27:07', NULL),
(753, 'Type C ethernet converter/ adapter 3.0 ', '000701', 1, 4500.00, 0.00, 4, 'Type C ethernet converter/ adapter 3.0 ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:28:27', NULL),
(754, 'Usb to LAN Adapter usb 2.0', '000702', 1, 1400.00, 0.00, 3, 'Usb to LAN Adapter usb 2.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:29:14', NULL),
(755, 'USB bluetooth dongle 5.0', '000703', 1, 1000.00, 0.00, 2, 'USB bluetooth dongle 5.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:29:59', NULL),
(756, 'Type C to type C extender', '000704', 1, 3000.00, 0.00, 2, 'Type C to type C extender', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:31:48', NULL),
(757, 'Asus Mini Laptop charger 19v', '000660', 1, 1400.00, 0.00, 5, 'Asus Mini Laptop charger 19v', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-04-30 18:40:19', NULL),
(758, 'G304 wireless mouse', '000742', 1, 2000.00, 0.00, 4, 'G304 wireless mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:30:09', NULL),
(759, 'G102 wired mouse', '000743', 1, 1800.00, 0.00, 5, 'G102 wired mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:30:49', NULL),
(760, 'DP2000 battery', '000744', 1, 800.00, 0.00, 9, 'DP2000 battery', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:31:28', NULL),
(761, 'DDk 995+ 2 Sim table Phone', '000745', 3, 13000.00, 0.00, 2, 'DDk 995+ 2 Sim table Phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:34:41', NULL),
(762, 'HDMI cable 20meters', '000746', 5, 8000.00, 0.00, 2, 'HDMI cable 20meters', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:35:43', NULL),
(763, 'F501 Table phone', '000747', 3, 8000.00, 0.00, 2, 'F501 Table phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:36:38', NULL),
(764, 'ET55623 Table Phone', '000748', 5, 0.00, 0.00, 2, 'ET55623 Table Phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:37:50', NULL),
(765, 'Laptop speakerCMK 209', '000749', 1, 2800.00, 0.00, 3, 'Laptop speakerCMK 209', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:39:15', NULL),
(766, 'BST M7001 battery charger', '000750', 3, 2200.00, 0.00, 5, 'BST M7001 battery charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:40:47', NULL),
(767, 'Wired keyboard', '000751', 1, 1900.00, 0.00, 2, 'Wired keyboard', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:42:04', NULL),
(768, 'F316/F317 landline battery', '000752', 5, 1300.00, 0.00, 10, 'F316/F317 landline battery', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:43:09', NULL),
(769, 'Samsung Galaxy Buds+', '000753', 1, 5000.00, 0.00, 2, 'Samsung Galaxy Buds+', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:44:44', NULL),
(770, 'S9 charger', '000754', 1, 1100.00, 0.00, 5, 'S9 charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:45:26', NULL),
(771, 'Samsung buds live R180', '000755', 1, 5000.00, 0.00, 1, 'Samsung buds live R180', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:46:18', NULL),
(772, 'Superfast 25W head', '000756', 5, 3000.00, 0.00, 5, 'Superfast 25W head', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:47:49', NULL),
(773, 'USB cable type C to type C (3A)', '000757', 1, 800.00, 0.00, 5, 'USB cable type C to type C (3A)', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:48:52', NULL),
(774, 'Samsung S6 Original box pack charger', '000758', 5, 1000.00, 0.00, 5, 'Samsung S6 Original box pack charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:50:00', NULL),
(775, 'Samsung S8 type C charger', '000759', 1, 1300.00, 0.00, 7, 'Samsung S8 type C charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:50:53', NULL),
(776, 'S10+ charger', '000760', 1, 1200.00, 0.00, 5, 'S10+ charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:51:43', NULL),
(777, 'Air 15 bud', '000761', 1, 4500.00, 0.00, 5, 'Air 15 bud', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:52:42', NULL),
(778, 'Pro 5s bud', '000762', 1, 4500.00, 0.00, 2, 'Pro 5s bud', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:53:32', NULL),
(779, 'JBL VJ 096 ', '000763', 1, 2500.00, 0.00, 2, 'JBL VJ 096 ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:55:07', NULL),
(780, 'Air sport max neck', '000764', 1, 3000.00, 0.00, 2, 'Air sport max neck', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:56:01', NULL),
(781, 'VJ headset UJ 080', '000765', 1, 5500.00, 0.00, 2, 'VJ headset UJ 080', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 14:57:41', NULL),
(782, 'Bose 700 headset', '000766', 1, 6500.00, 0.00, 1, 'Bose 700 headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:00:10', NULL),
(783, 'Vj 087 shocking bass wireless headset', '000767', 1, 6000.00, 0.00, 2, 'Vj 087 shocking bass wireless headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:02:40', NULL),
(784, 'Bose Qc 39 headset', '000768', 1, 5500.00, 0.00, 2, 'Bose Qc 39 headset', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:03:57', NULL),
(785, 'Casetify Iphone 11pro max', '000769', 3, 750.00, 0.00, 3, 'Casetify Iphone 11pro max', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:09:13', NULL);
INSERT INTO `stock_ins` (`id`, `stock_name`, `stock_unique_id`, `stock_category_id`, `stock_costprice`, `stock_price`, `stock_qty`, `stock_description`, `memo`, `date_created`, `date_updated`) VALUES
(786, 'Casetify Iphone X/Xs', '000770', 3, 750.00, 0.00, 3, 'Casetify Iphone X/Xs', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:10:12', NULL),
(787, 'Casetify Iphone 12pro max ', '000771', 3, 750.00, 0.00, 3, 'Casetify Iphone 12pro max ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:11:12', NULL),
(788, 'Casetify Iphone 11', '000772', 5, 750.00, 0.00, 1, 'Casetify Iphone 11', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:11:58', NULL),
(789, 'Casetify 7/8plus', '000773', 3, 750.00, 0.00, 3, 'Casetify 7/8plus', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:12:42', NULL),
(790, 'Iphone 13pro max 20w usb  car charger', '000775', 1, 1200.00, 0.00, 5, 'Iphone 13pro max 20w usb  car charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:14:02', NULL),
(791, '38w car charger Usb and type C ', '000776', 1, 2500.00, 0.00, 5, '38w car charger Usb and type C ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:20:36', NULL),
(792, '3M cable Iphone', '000777', 5, 800.00, 0.00, 10, '3M cable Iphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:22:05', NULL),
(793, 'Aux cable Iphone', '000778', 1, 1000.00, 0.00, 7, 'Aux cable Iphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:23:23', NULL),
(794, 'Aux cable Iphone and type C', '000779', 1, 1200.00, 0.00, 12, 'Aux cable Iphone and type C', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:24:26', NULL),
(795, 'Type C earphone', '000780', 5, 1200.00, 0.00, 10, 'Type C earphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:26:53', NULL),
(796, 'Iphone jack', '000782', 1, 800.00, 0.00, 7, 'Iphone jack', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:27:48', NULL),
(797, 'TYpe C jack', '000781', 1, 750.00, 0.00, 10, 'TYpe C jack', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:28:40', NULL),
(798, 'Iphone head', '000783', 1, 800.00, 0.00, 10, 'Iphone head', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:29:27', NULL),
(799, '7G bluetooth and charger iphone', '000784', 1, 1200.00, 0.00, 10, '7G bluetooth and charger iphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:30:21', NULL),
(800, '7G ear bluetooth iphone', '000785', 1, 1000.00, 0.00, 10, '7G ear bluetooth iphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:31:30', NULL),
(801, 'Sim adapter ', '000786', 3, 110.00, 0.00, 8, 'Sim adapter ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:33:42', NULL),
(802, 'I watch charger ', '000787', 3, 2500.00, 0.00, 2, 'I watch charger ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:36:38', NULL),
(803, 'Iphone cable', '000788', 1, 400.00, 0.00, 8, 'Iphone cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:37:41', NULL),
(804, 'Battery 5c Nokia', '000789', 1, 500.00, 0.00, 10, 'Battery 5c Nokia', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:44:35', NULL),
(805, 'Zealot S1 Bl-5c battery', '000790', 5, 500.00, 0.00, 20, 'Zealot S1 Bl-5c battery', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:46:37', NULL),
(806, 'Zealot S1 25BT battery', '000791', 1, 1000.00, 0.00, 20, 'Zealot S1 25BT battery', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:47:56', NULL),
(807, 'Iphone Xmax charger', '000792', 1, 1200.00, 0.00, 5, 'Iphone Xmax charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:49:13', NULL),
(808, 'LT power adapter', '000793', 1, 1500.00, 0.00, 1, 'LT power adapter', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:50:01', NULL),
(809, 'Iphone 12promax charger', '000794', 1, 2200.00, 0.00, 2, 'Iphone 12promax charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:51:03', NULL),
(810, 'Iphone 13pro max charger', '000795', 1, 3400.00, 0.00, 1, 'Iphone 13pro max charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:51:52', NULL),
(811, 'Poolee PD20pro 20,000mah powerbank', '000796', 1, 8000.00, 0.00, 2, 'Poolee PD20pro 20,000mah powerbank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:53:14', NULL),
(812, 'Poolee PD30pro 30,000mah powerbank', '000797', 1, 11000.00, 0.00, 2, 'Poolee PD30pro 30,000mah powerbank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:54:15', NULL),
(813, 'Romoss 40,000mah powerbank', '000798', 5, 15500.00, 0.00, 2, 'Romoss 40,000mah powerbank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:55:58', NULL),
(814, 'Romoss 30,000mah powerbank', '000799', 1, 13000.00, 0.00, 2, 'Romoss 30,000mah powerbank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:56:43', NULL),
(815, 'Newage 12500mah powerbank', '000800', 1, 5200.00, 0.00, 5, 'Newage 12500mah powerbank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 15:58:50', NULL),
(816, 'New age 18500mah powerbank', '000801', 1, 8200.00, 0.00, 5, 'New age 18500mah powerbank', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 16:00:00', NULL),
(817, 'Omni flash drive 64gb', '000802', 3, 4000.00, 0.00, 5, 'Omni flash drive 64gb', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 16:02:02', NULL),
(818, 'Omni Doza charger', '000803', 1, 3500.00, 0.00, 3, 'Omni Doza charger', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 16:02:41', NULL),
(819, 'Omni flash drive 32gb', '000804', 3, 2600.00, 0.00, 4, 'Omni flash drive 32gb', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 16:03:28', NULL),
(820, 'Omni flash drive 8gb', '000805', 3, 2120.00, 0.00, 4, 'Omni flash drive 8gb', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 16:04:11', NULL),
(821, 'Samsung Note 10+ type C data cable', '000806', 5, 800.00, 0.00, 3, 'Samsung Note 10+ type C data cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-04 16:05:13', NULL),
(822, 'Iphone 11promax apple deep black pouch', '000774', 3, 850.00, 0.00, 4, 'Iphone 11promax apple deep black pouch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-05 11:00:03', NULL),
(823, 'software installation CD', '000807', 3, 150.00, 0.00, 664, 'software installation CD', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-07 14:28:02', NULL),
(824, 'Itel A23 Android Phone', '000808', 3, 23000.00, 0.00, 4, 'Itel A23 Android Phone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-07 14:45:50', NULL),
(825, 'Transparent 22.5w PB30 30,000mah', '000809', 1, 10800.00, 0.00, 9, 'Transaparent 22.5w PB30 30,000mah', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:16:04', NULL),
(826, 'Transparent 22.5w PB30 50,000mah', '000810', 1, 15200.00, 0.00, 9, 'Transparent 22.5w PB30 50,000mah', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:16:51', NULL),
(827, '8gb memory card DJ Accessories', '000811', 1, 1450.00, 0.00, 20, '8gb memory card DJ Accessories', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:17:48', NULL),
(828, '16gb memory card DJ Accessories', '000812', 5, 1650.00, 0.00, 20, '16gb memory card DJ Accessories', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:18:46', NULL),
(829, 'Bluetooth mouse', '000813', 1, 2500.00, 0.00, 5, 'Bluetooth mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:20:15', NULL),
(830, 'Rechargeable mouse', '000814', 1, 2500.00, 0.00, 4, 'Rechargeable mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:21:04', NULL),
(831, '5port Hdmi Switch', '000815', 5, 6500.00, 0.00, 2, '5port Hdmi Switch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:22:14', NULL),
(832, '3port Hdmi Switch', '000816', 1, 3500.00, 0.00, 3, '3port Hdmi Switch', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:23:06', NULL),
(833, 'Hdmi 3.0 capture', '000817', 1, 25000.00, 0.00, 1, 'Hdmi 3.0 capture', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:24:11', NULL),
(834, 'SSD   Case', '000818', 1, 9000.00, 0.00, 2, 'SSD   Case', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:26:53', NULL),
(835, '3 in 1 cable Tv', '000819', 3, 5000.00, 0.00, 1, '3 in 1 cable Tv', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:31:31', NULL),
(837, 'Hdmi extender 60m', '000821', 1, 12000.00, 0.00, 2, 'Hdmi extender 60m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:40:51', NULL),
(838, 'Hdmi extender 30m', '000820', 1, 3500.00, 0.00, 5, 'Hdmi extender 30m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:45:42', NULL),
(839, 'Hdmi extender 120m', '000822', 1, 22000.00, 0.00, 1, 'Hdmi extender 120m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:46:26', NULL),
(840, 'Hdmi extender 150m', '000823', 1, 25000.00, 0.00, 1, 'Hdmi extender 150m', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:47:11', NULL),
(841, '5m printer cable', '000825', 3, 1000.00, 0.00, 5, '5m printer cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:52:26', NULL),
(842, 'USB to Serial', '000826', 1, 1500.00, 0.00, 3, 'USB to Serial', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:53:26', NULL),
(843, '10m printer cable', '000827', 3, 2000.00, 0.00, 5, '10m printer cable', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:54:18', NULL),
(844, 'Usb Extender', '000828', 1, 3500.00, 0.00, 2, 'Usb Extender', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:55:12', NULL),
(845, 'Bluetooth receiver', '000829', 3, 1500.00, 0.00, 1, 'Bluetooth receiver', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:56:25', NULL),
(846, 'Power pack', '000830', 1, 3500.00, 0.00, 3, 'Power pack', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:57:09', NULL),
(847, 'USB to VGA', '000831', 1, 3000.00, 0.00, 3, 'USB to VGA', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:57:47', NULL),
(848, 'USB to LAN 3.0', '000832', 1, 2700.00, 0.00, 2, 'USB to LAN 3.0', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-11 14:58:42', NULL),
(849, 'Transparent wireless neckband earphone', '000833', 1, 4800.00, 0.00, 5, 'Transparent wireless neckband earphone', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-05-25 11:58:58', NULL),
(850, 'Oraimo small speaker Obs-03s', '000834', 1, 6100.00, 0.00, 4, 'Oraimo small speaker Obs-03s', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-06-09 14:35:29', NULL),
(852, 'Itel speaker IBS-10', '000836', 1, 6200.00, 0.00, 3, 'Itel speaker IBS-10', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-06-09 14:39:37', NULL),
(853, 'Itel Neckband N53', '000837', 1, 3600.00, 0.00, 5, 'Itel Neckband N53', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-06-09 14:41:37', NULL),
(854, 'Itel earbuds ITW-60', '000838', 5, 7200.00, 0.00, 3, 'Itel earbuds ITW-60', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-06-09 14:42:59', NULL),
(855, 'Itel small charger U051EA', '000835', 1, 650.00, 0.00, 7, 'Itel small charger U051EA', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-06-09 14:44:10', NULL),
(857, 'Tecno Hipods H2', '000839', 1, 4600.00, 4950.00, 31, 'Tecno Hipods H2', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-04 14:57:07', '2022-07-22 20:50:04'),
(858, 'Oraimo sport wireless earphone E59D', '000840', 1, 6000.00, 6400.00, 12, 'Oraimo sport wireless earphone E59D', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-04 17:51:37', '2022-07-22 20:50:35'),
(859, 'Oraimo 30,000mah powerbank P300Q', '000841', 1, 13000.00, 0.00, 11, 'Oraimo 30,000mah powerbank P300Q', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-04 17:53:21', NULL),
(860, 'Tecno H3 hipods', '000842', 1, 12200.00, 0.00, 1, 'Tecno H3 hipods', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-04 17:53:57', NULL),
(861, 'Oraimo powercube 3pro Ocw U940', '000843', 5, 3200.00, 0.00, 9, 'Oraimo powercube 3pro Ocw U940', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-04 17:56:09', NULL),
(862, 'Single wired PC Gamepad', '000844', 3, 0.00, 0.00, 0, 'Single wired PC Gamepad', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:21:50', NULL),
(863, 'Single wireless PC Gamepad', '000845', 3, 0.00, 0.00, 0, 'Single wireless PC Gamepad', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:24:08', NULL),
(864, '3388 professional tripod stand with remote', '000846', 3, 0.00, 0.00, 0, '3388 professional tripod stand with remote', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:26:18', NULL),
(865, 'Logitech M171 wireless mouse', '000847', 1, 0.00, 0.00, 0, 'Logitech M171 wireless mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:27:06', NULL),
(866, 'Logitech M185 wireless mouse', '000848', 5, 0.00, 0.00, 0, 'Logitech M185 wireless mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:27:44', NULL),
(867, 'Havit Wireless Gamepad ', '000849', 3, 0.00, 0.00, 0, 'Havit Wireless Gamepad ', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:28:31', NULL),
(868, 'Logitech M186 wireless mouse', '000850', 5, 0.00, 0.00, 0, 'Logitech M186 wireless mouse', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:29:04', NULL),
(869, 'PC  camera Standing webcam', '000851', 1, 0.00, 0.00, 0, 'PC  camera Standing webcam', '{\"created_by\":\"Oluwatayo Adeyemi\",\"updated_by\":\"Oluwatayo Adeyemi\"}', '2022-07-12 17:29:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stock_update_archive`
--

CREATE TABLE `stock_update_archive` (
  `id` bigint(20) NOT NULL,
  `date_opened` datetime NOT NULL,
  `date_closed` datetime NOT NULL,
  `file_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock_update_archive`
--

INSERT INTO `stock_update_archive` (`id`, `date_opened`, `date_closed`, `file_path`) VALUES
(1, '2022-07-23 16:19:36', '2022-07-23 17:29:59', 'uploads/stockUpdates/1658593799.pdf'),
(2, '2022-07-23 17:50:10', '2022-07-23 18:20:11', 'uploads/stockUpdates/1658596811.pdf'),
(3, '2022-07-23 18:22:01', '2022-07-23 18:25:44', 'uploads/stockUpdates/1658597144.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `stock_update_quantity_history`
--

CREATE TABLE `stock_update_quantity_history` (
  `id` bigint(20) NOT NULL,
  `stock_id` varchar(25) NOT NULL,
  `user_id` bigint(11) NOT NULL,
  `quantity_added` int(11) NOT NULL,
  `old_quantity` int(11) NOT NULL,
  `new_quantity` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stock_update_quantity_history`
--

INSERT INTO `stock_update_quantity_history` (`id`, `stock_id`, `user_id`, `quantity_added`, `old_quantity`, `new_quantity`, `date_created`) VALUES
(1, '0', 1, 18, 15, 33, '2022-07-16 09:43:20'),
(2, '0', 1, 5, 38, 43, '2022-07-16 11:49:00'),
(3, '1', 1, 5, 43, 48, '2022-07-16 11:49:44'),
(4, '1', 1, 5, 48, 53, '2022-07-16 11:50:16'),
(5, '1', 1, 5, 53, 58, '2022-07-16 11:50:23'),
(6, '840', 1, 2, 1, 3, '2022-07-23 06:39:27'),
(7, '839', 1, 1, 1, 2, '2022-07-23 06:39:27'),
(8, '858', 1, 2, 8, 10, '2022-07-23 06:57:21'),
(9, '857', 1, 1, 29, 30, '2022-07-23 06:57:21'),
(10, '858', 1, 2, 10, 12, '2022-07-23 06:59:35'),
(11, '857', 1, 1, 30, 31, '2022-07-23 06:59:35'),
(12, '861', 1, 5, 9, 14, '2022-07-23 16:18:02'),
(13, '860', 1, 15, 1, 16, '2022-07-23 16:18:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `checkout`
--
ALTER TABLE `checkout`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `daily_update`
--
ALTER TABLE `daily_update`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales_item`
--
ALTER TABLE `sales_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `stock_in`
--
ALTER TABLE `stock_in`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stock_unique_id` (`stock_unique_id`);

--
-- Indexes for table `stock_ins`
--
ALTER TABLE `stock_ins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stock_unique_id` (`stock_unique_id`);

--
-- Indexes for table `stock_update_archive`
--
ALTER TABLE `stock_update_archive`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_update_quantity_history`
--
ALTER TABLE `stock_update_quantity_history`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `checkout`
--
ALTER TABLE `checkout`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `daily_update`
--
ALTER TABLE `daily_update`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sales_item`
--
ALTER TABLE `sales_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `stock_in`
--
ALTER TABLE `stock_in`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=870;

--
-- AUTO_INCREMENT for table `stock_ins`
--
ALTER TABLE `stock_ins`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=870;

--
-- AUTO_INCREMENT for table `stock_update_archive`
--
ALTER TABLE `stock_update_archive`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `stock_update_quantity_history`
--
ALTER TABLE `stock_update_quantity_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;
