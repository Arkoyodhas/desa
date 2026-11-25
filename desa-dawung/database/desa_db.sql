SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;




CREATE TABLE `activity_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(60) NOT NULL,
  `module` varchar(80) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `admin_face_profiles` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `label` varchar(120) NOT NULL DEFAULT 'Dataset wajah',
  `descriptor` longtext NOT NULL,
  `sample_count` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `threshold` decimal(4,3) NOT NULL DEFAULT 0.815,
  `model_version` varchar(80) NOT NULL DEFAULT 'human-3.3.6-faceres',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;





CREATE TABLE `agendas` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `event_date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `pic` varchar(150) DEFAULT NULL,
  `status` enum('akan_datang','berlangsung','selesai','dibatalkan') NOT NULL DEFAULT 'akan_datang',
  `documentation` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `announcements` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `is_important` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `background_music` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(10) DEFAULT NULL,
  `file_size` int(10) UNSIGNED DEFAULT 0,
  `volume` tinyint(3) UNSIGNED NOT NULL DEFAULT 50,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `autoplay` tinyint(1) NOT NULL DEFAULT 0,
  `loop_music` tinyint(1) NOT NULL DEFAULT 1,
  `display_position` varchar(20) NOT NULL DEFAULT 'kanan-bawah',
  `active_pages` varchar(100) NOT NULL DEFAULT 'semua',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `bansos_programs` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(150) NOT NULL COMMENT 'PKH, BPNT, BLT-DD, dll',
  `deskripsi` text DEFAULT NULL,
  `sumber_dana` varchar(100) DEFAULT NULL,
  `tahun` year(4) NOT NULL,
  `nilai_per_penerima` bigint(20) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `bansos_recipients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `program_id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(150) NOT NULL,
  `nik` varchar(16) DEFAULT NULL COMMENT 'ditampilkan ter-mask ke publik',
  `alamat` varchar(200) DEFAULT NULL,
  `rt` varchar(5) DEFAULT NULL,
  `rw` varchar(5) DEFAULT NULL,
  `keterangan` varchar(200) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `blocked_ips` (
  `id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(45) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `budget_transparencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `year` smallint(6) NOT NULL,
  `type` enum('pendapatan','belanja','pembiayaan') NOT NULL DEFAULT 'belanja',
  `category` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `budget_amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `realization_amount` decimal(16,2) DEFAULT 0.00,
  `source` varchar(80) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `chat_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `room_id` char(36) NOT NULL,
  `sender` varchar(10) NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `chat_rooms` (
  `id` char(36) NOT NULL,
  `visitor_name` varchar(60) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `device` varchar(20) DEFAULT NULL,
  `browser` varchar(30) DEFAULT NULL,
  `os` varchar(30) DEFAULT NULL,
  `country` varchar(80) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `status` varchar(12) NOT NULL DEFAULT 'open',
  `unread_admin` int(11) NOT NULL DEFAULT 0,
  `typing_user` datetime DEFAULT NULL,
  `typing_admin` datetime DEFAULT NULL,
  `last_message` varchar(160) DEFAULT NULL,
  `last_message_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `complaints` (
  `id` int(10) UNSIGNED NOT NULL,
  `ticket` varchar(30) NOT NULL,
  `nama` varchar(150) NOT NULL,
  `kontak` varchar(150) DEFAULT NULL,
  `category` varchar(80) DEFAULT NULL,
  `content` text NOT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `is_anonymous` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('diterima','diproses','selesai','ditolak') NOT NULL DEFAULT 'diterima',
  `priority` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `complaint_responses` (
  `id` int(10) UNSIGNED NOT NULL,
  `complaint_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `response` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `contact_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `development_projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `year` smallint(6) NOT NULL,
  `source` varchar(80) DEFAULT NULL,
  `budget` decimal(16,2) DEFAULT 0.00,
  `realization` decimal(16,2) DEFAULT 0.00,
  `progress` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` varchar(30) NOT NULL DEFAULT 'perencanaan',
  `location` varchar(200) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `document` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `documents` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `category` varchar(80) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_type` varchar(10) DEFAULT NULL,
  `file_size` int(10) UNSIGNED DEFAULT 0,
  `year` smallint(6) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `downloads` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `event_effects` (
  `id` int(10) UNSIGNED NOT NULL,
  `event_name` varchar(150) NOT NULL,
  `event_type` varchar(40) NOT NULL DEFAULT 'custom',
  `effect_type` varchar(30) NOT NULL DEFAULT 'confetti',
  `message` varchar(255) DEFAULT NULL,
  `banner_text` varchar(255) DEFAULT NULL,
  `color_scheme` varchar(200) DEFAULT '#e63946,#ffffff',
  `theme_color` varchar(10) DEFAULT NULL,
  `intensity` varchar(15) NOT NULL DEFAULT 'sedang',
  `duration` int(11) NOT NULL DEFAULT 12,
  `frequency` int(11) NOT NULL DEFAULT 0,
  `active_pages` varchar(100) NOT NULL DEFAULT 'semua',
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time NOT NULL DEFAULT '00:00:00',
  `end_time` time NOT NULL DEFAULT '23:59:59',
  `closable_by_user` tinyint(1) NOT NULL DEFAULT 1,
  `show_once_per_visit` tinyint(1) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 1,
  `music_id` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `event_effect_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `event_effect_id` int(10) UNSIGNED NOT NULL,
  `action` varchar(40) NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `event_effect_schedules` (
  `id` int(10) UNSIGNED NOT NULL,
  `event_effect_id` int(10) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time NOT NULL DEFAULT '00:00:00',
  `end_time` time NOT NULL DEFAULT '23:59:59',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `families` (
  `id` int(10) UNSIGNED NOT NULL,
  `no_kk` char(16) NOT NULL,
  `kepala_keluarga` varchar(150) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `dusun_id` int(10) UNSIGNED DEFAULT NULL,
  `rw_id` int(10) UNSIGNED DEFAULT NULL,
  `rt_id` int(10) UNSIGNED DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'aktif',
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `family_members` (
  `id` int(10) UNSIGNED NOT NULL,
  `family_id` int(10) UNSIGNED NOT NULL,
  `resident_id` int(10) UNSIGNED NOT NULL,
  `hubungan` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `feedback_questions` (
  `id` int(10) UNSIGNED NOT NULL,
  `label` varchar(255) NOT NULL,
  `type` enum('rating','choice','text','textarea') NOT NULL DEFAULT 'rating',
  `options` text DEFAULT NULL COMMENT 'JSON array untuk type=choice',
  `required` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `feedback_questions` (`id`, `label`, `type`, `options`, `required`, `sort_order`, `is_active`) VALUES
(2, 'Seberapa membantu Website Desa untuk mendapatkan informasi?', 'rating', NULL, 1, 3, 1),
(3, 'Saran atau masukan untuk kami', 'textarea', NULL, 0, 5, 0),
(4, 'Bagaimana pengalaman Anda mengunjungi website desa kami?', 'rating', NULL, 1, 2, 1),
(5, 'Informasi apa yang paling Anda cari?', 'choice', '[\"Berita\",\"Agenda\",\"Layanan\",\"Dana Desa\",\"IDM\",\"Bansos\",\"Stunting\",\"Lainnya\"]', 1, 4, 1),
(6, 'Saran atau masukan untuk kami', 'textarea', NULL, 0, 6, 1),
(7, 'Apakah Anda menemukan info yang anda mau cari?', 'choice', '[\"Ya, seluruhnya\",\"Sebagian saja\",\"Tidak\"]', 1, 7, 1),
(8, 'Informasi apa yang tidak ditemukan?', 'textarea', NULL, 0, 8, 1),
(9, 'Berapa lama sampai menemukan info yang anda mau cari?', 'choice', '[\"<1 menit\",\"1–3 menit\",\">3 menit\",\"Tidak ketemu\"]', 1, 9, 1);



CREATE TABLE `feedback_responses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `respondent_name` varchar(120) DEFAULT NULL,
  `respondent_email` varchar(150) DEFAULT NULL,
  `answers` longtext NOT NULL COMMENT 'JSON {question_id: answer}',
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `galleries` (
  `id` int(10) UNSIGNED NOT NULL,
  `album_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('foto','video') NOT NULL DEFAULT 'foto',
  `title` varchar(200) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `youtube_url` varchar(255) DEFAULT NULL,
  `category` varchar(80) DEFAULT NULL,
  `year` smallint(6) DEFAULT NULL,
  `protected` tinyint(1) NOT NULL DEFAULT 0,
  `watermark` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `gallery_albums` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `slug` varchar(170) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(80) DEFAULT NULL,
  `year` smallint(6) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `idm_data` (
  `id` int(10) UNSIGNED NOT NULL,
  `tahun` year(4) NOT NULL,
  `iks` decimal(5,4) NOT NULL DEFAULT 0.0000 COMMENT 'Indeks Ketahanan Sosial 0-1',
  `ike` decimal(5,4) NOT NULL DEFAULT 0.0000 COMMENT 'Indeks Ketahanan Ekonomi 0-1',
  `ikl` decimal(5,4) NOT NULL DEFAULT 0.0000 COMMENT 'Indeks Ketahanan Lingkungan 0-1',
  `idm` decimal(5,4) GENERATED ALWAYS AS ((`iks` + `ike` + `ikl`) / 3) VIRTUAL,
  `catatan` text DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `import_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `total_rows` int(11) NOT NULL DEFAULT 0,
  `valid_rows` int(11) NOT NULL DEFAULT 0,
  `invalid_rows` int(11) NOT NULL DEFAULT 0,
  `mode` varchar(20) DEFAULT 'skip',
  `note` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `ip_locations` (
  `ip` varchar(45) NOT NULL,
  `country` varchar(80) DEFAULT NULL,
  `country_code` char(2) DEFAULT NULL,
  `region_name` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `isp` varchar(190) DEFAULT NULL,
  `lat` decimal(10,6) DEFAULT NULL,
  `lon` decimal(10,6) DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'success',
  `looked_up_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `media_files` (
  `id` int(10) UNSIGNED NOT NULL,
  `filename` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `type` varchar(30) DEFAULT NULL,
  `size` int(10) UNSIGNED DEFAULT 0,
  `uploaded_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '#',
  `icon` varchar(60) DEFAULT NULL,
  `target` varchar(10) NOT NULL DEFAULT '_self',
  `location` varchar(20) NOT NULL DEFAULT 'main',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `menus` (`id`, `parent_id`, `title`, `url`, `icon`, `target`, `location`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Beranda', '/', 'bi-house', '_self', 'main', 1, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(2, NULL, 'Profil', '/profil', 'bi-info-circle', '_self', 'main', 2, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(3, NULL, 'Pemerintahan', '/pemerintahan', 'bi-people', '_self', 'main', 3, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(4, NULL, 'Berita', '/berita', 'bi-newspaper', '_self', 'main', 4, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(5, NULL, 'Layanan', '/layanan', 'bi-file-earmark-text', '_self', 'main', 5, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(6, NULL, 'Informasi', '#', 'bi-grid', '_self', 'main', 6, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(7, NULL, 'Transparansi', '/transparansi', 'bi-cash-stack', '_self', 'main', 7, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(8, NULL, 'Pengaduan', '/pengaduan', 'bi-chat-square-text', '_self', 'main', 8, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(9, NULL, 'Kontak', '/kontak', 'bi-envelope', '_self', 'main', 9, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(10, 6, 'Pengumuman', '/pengumuman', 'bi-megaphone', '_self', 'main', 1, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(11, 6, 'Agenda', '/agenda', 'bi-calendar-event', '_self', 'main', 2, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(12, 6, 'Galeri', '/galeri', 'bi-images', '_self', 'main', 3, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(13, 6, 'Statistik', '/statistik', 'bi-bar-chart', '_self', 'main', 4, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(14, 6, 'Dokumen Publik', '/dokumen', 'bi-folder2-open', '_self', 'main', 5, 1, '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(15, 6, 'UMKM & Potensi', '/umkm', 'bi-shop', '_self', 'main', 6, 1, '2026-07-08 22:07:33', '2026-07-23 17:32:27'),
(16, NULL, 'Profil Desa', '/profil', 'bi-info-circle', '_self', 'footer', 1, 1, '2026-07-08 22:07:33', '2026-07-23 18:18:23'),
(17, NULL, 'Berita', '/berita', 'bi-newspaper', '_self', 'footer', 2, 1, '2026-07-08 22:07:33', '2026-07-23 18:18:53'),
(18, NULL, 'Layanan', '/layanan', 'bi-file-earmark-text', '_self', 'footer', 3, 1, '2026-07-08 22:07:33', '2026-07-23 18:19:19'),
(19, NULL, 'Transparansi', '/transparansi', 'bi-cash-stack', '_self', 'footer', 4, 1, '2026-07-08 22:07:33', '2026-07-23 18:19:37'),
(20, NULL, 'Pengaduan', '/pengaduan', 'bi-chat-square-text', '_self', 'footer', 5, 1, '2026-07-08 22:07:33', '2026-07-23 18:19:57'),
(21, NULL, 'Dokumen', '/dokumen', 'bi-folder2-open', '_self', 'footer', 6, 1, '2026-07-08 22:07:33', '2026-07-23 18:20:48'),
(22, NULL, 'Web Dawung', '#', 'bi-search', '_blank', 'main', 10, 1, '2026-07-09 02:49:21', '2026-07-23 18:24:49'),
(23, 22, 'E-Perpus', 'https://eperpus.dawung-sambirejo.desa.id', 'bi-book', '_blank', 'main', 1, 1, '2026-07-09 02:50:55', '2026-07-23 18:26:57'),
(24, 22, 'E-Commerce', 'https://bumdes.dawung-sambirejo.desa.id', 'bi-shop', '_blank', 'main', 2, 1, '2026-07-09 02:52:08', '2026-07-23 22:09:56'),
(25, 3, 'Pemerintahan Desa', '/pemerintahan', 'bi-people', '_self', 'main', 1, 1, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(26, 3, 'Struktur Organisasi (SOTK)', '/sotk', 'bi-diagram-3', '_self', 'main', 2, 1, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(27, 6, 'SDGs Desa', '/sdgs', 'bi-globe-asia-australia', '_self', 'main', 7, 1, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(28, 6, 'IDM', '/idm', 'bi-house', '_self', 'main', 8, 1, '2026-07-23 17:31:11', '2026-07-23 17:32:15'),
(29, 6, 'Data Bansos', '/bansos', 'bi-gift', '_self', 'main', 9, 1, '2026-07-23 17:36:08', '2026-07-23 17:37:44'),
(30, 6, 'Stunting', '/stunting', 'bi-hospital', '_self', 'main', 10, 1, '2026-07-23 17:39:43', '2026-07-23 17:39:43'),
(31, NULL, 'Website E-Perpus', 'https://eperpus.dawung-sambirejo.desa.id', 'bi-book', '_blank', 'footer', 7, 1, '2026-07-23 18:15:47', '2026-07-23 18:20:55'),
(32, NULL, 'Website E-Commerce Dawung', 'https://bumdes.dawung-sambirejo.desa.id', 'bi-shop', '_self', 'footer', 8, 1, '2026-07-23 18:21:35', '2026-07-23 18:22:54');



CREATE TABLE `news` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `excerpt` varchar(500) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `meta_title` varchar(200) DEFAULT NULL,
  `meta_description` varchar(300) DEFAULT NULL,
  `status` enum('draft','published','scheduled') NOT NULL DEFAULT 'draft',
  `published_at` datetime DEFAULT NULL,
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `allow_comments` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `news_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(120) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `news_categories` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Pemerintahan', 'pemerintahan', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(2, 'Pembangunan', 'pembangunan', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(3, 'Kegiatan Warga', 'kegiatan-warga', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(4, 'Kesehatan', 'kesehatan', '2026-07-08 22:07:33', '2026-07-08 22:07:33');



CREATE TABLE `news_comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `news_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `content` text NOT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `news_tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `news_tag_relations` (
  `news_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `meta_title` varchar(200) DEFAULT NULL,
  `meta_description` varchar(300) DEFAULT NULL,
  `template` varchar(30) NOT NULL DEFAULT 'default',
  `sort_order` int(11) NOT NULL DEFAULT 99,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `permissions` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Kelola Profil Desa', 'kelola_profil', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(2, 'Kelola Penduduk', 'kelola_penduduk', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(3, 'Import Penduduk', 'import_penduduk', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(4, 'Export Penduduk', 'export_penduduk', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(5, 'Kelola Berita', 'kelola_berita', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(6, 'Kelola Layanan', 'kelola_layanan', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(7, 'Kelola Pengaduan', 'kelola_pengaduan', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(8, 'Kelola Transparansi', 'kelola_transparansi', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(9, 'Kelola Dokumen', 'kelola_dokumen', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(10, 'Kelola Galeri', 'kelola_galeri', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(11, 'Kelola Tampilan Website', 'kelola_tampilan', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(12, 'Kelola Musik', 'kelola_musik', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(13, 'Kelola Event Effect', 'kelola_event', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(14, 'Kelola User Admin', 'kelola_user', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(15, 'Lihat Audit Log', 'lihat_audit', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(16, 'Kelola Data Publik', 'kelola_konten', '2026-07-26 00:00:00', '2026-07-26 00:00:00');



CREATE TABLE `push_notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `body` varchar(300) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `sent_count` int(11) NOT NULL DEFAULT 0,
  `fail_count` int(11) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `push_subscriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `endpoint_hash` char(64) NOT NULL,
  `endpoint` text NOT NULL,
  `p256dh` varchar(255) DEFAULT NULL,
  `auth` varchar(100) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `regions` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('dusun','rw','rt') NOT NULL,
  `name` varchar(100) NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `kepala` varchar(150) DEFAULT NULL,
  `latitude` varchar(30) DEFAULT NULL,
  `longitude` varchar(30) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `residents` (
  `id` int(10) UNSIGNED NOT NULL,
  `nik` char(16) NOT NULL,
  `no_kk` char(16) DEFAULT NULL,
  `nama` varchar(150) NOT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL DEFAULT 'L',
  `agama` varchar(30) DEFAULT NULL,
  `pendidikan` varchar(60) DEFAULT NULL,
  `pekerjaan` varchar(100) DEFAULT NULL,
  `status_perkawinan` varchar(30) DEFAULT NULL,
  `hubungan_keluarga` varchar(40) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `dusun_id` int(10) UNSIGNED DEFAULT NULL,
  `rw_id` int(10) UNSIGNED DEFAULT NULL,
  `rt_id` int(10) UNSIGNED DEFAULT NULL,
  `status_penduduk` enum('hidup','meninggal','pindah','tidak_aktif') NOT NULL DEFAULT 'hidup',
  `no_hp` varchar(20) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `roles` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'super-admin', 'Akses penuh seluruh sistem', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(2, 'Admin Desa', 'admin-desa', 'Mengelola hampir seluruh konten desa', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(3, 'Pemdes', 'operator-penduduk', 'Mengelola data penduduk, keluarga, wilayah', '2026-07-08 22:07:33', '2026-07-09 16:43:05'),
(4, 'Operator Berita', 'operator-berita', 'Mengelola berita, pengumuman, agenda', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(5, 'Operator Layanan', 'operator-layanan', 'Mengelola layanan & pengaduan', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(6, 'Operator Keuangan', 'operator-keuangan', 'Mengelola transparansi & dokumen', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(7, 'Operator Galeri', 'operator-galeri', 'Mengelola galeri & album', '2026-07-08 22:07:33', '2026-07-08 22:07:33'),
(8, 'Viewer', 'viewer', 'Hanya melihat dashboard', '2026-07-08 22:07:33', '2026-07-08 22:07:33');



CREATE TABLE `role_permissions` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 15),
(2, 16),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(3, 12),
(3, 13),
(3, 14),
(3, 15);



CREATE TABLE IF NOT EXISTS `screenshot_chat_targets` (
  `attempt_id` bigint(20) UNSIGNED NOT NULL,
  `session_key` char(64) NOT NULL,
  `visitor_token` char(64) DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `room_id` char(36) DEFAULT NULL,
  `invite_pending` tinyint(1) NOT NULL DEFAULT 0,
  `claimed_at` datetime DEFAULT NULL,
  `last_seen_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`attempt_id`),
  KEY `idx_ss_chat_session` (`session_key`,`invite_pending`),
  KEY `idx_ss_chat_token` (`visitor_token`,`invite_pending`),
  KEY `idx_ss_chat_ip` (`ip_address`),
  KEY `idx_ss_chat_room` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `screenshot_attempts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `method` varchar(30) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `device` varchar(20) DEFAULT NULL,
  `browser` varchar(30) DEFAULT NULL,
  `os` varchar(30) DEFAULT NULL,
  `country` varchar(80) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `sdgs_scores` (
  `id` int(10) UNSIGNED NOT NULL,
  `goal_number` tinyint(3) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `color` varchar(10) NOT NULL DEFAULT '#12649e',
  `icon` varchar(60) DEFAULT 'bi-globe-asia-australia',
  `score` decimal(5,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `sdgs_scores` (`id`, `goal_number`, `title`, `color`, `icon`, `score`, `description`, `is_active`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Desa Tanpa Kemiskinan', '#e5243b', 'bi-piggy-bank', 62.50, 'Menurunkan angka kemiskinan warga desa hingga nol persen.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(2, 2, 'Desa Tanpa Kelaparan', '#dda63a', 'bi-egg-fried', 71.20, 'Ketahanan pangan dan gizi warga desa tercukupi.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(3, 3, 'Desa Sehat dan Sejahtera', '#4c9f38', 'bi-heart-pulse', 68.40, 'Layanan kesehatan dasar desa yang berkualitas.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(4, 4, 'Pendidikan Desa Berkualitas', '#c5192d', 'bi-mortarboard', 65.80, 'Akses pendidikan berkualitas untuk seluruh warga.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(5, 5, 'Keterlibatan Perempuan Desa', '#ff3a21', 'bi-gender-female', 59.30, 'Kesetaraan dan pemberdayaan perempuan desa.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(6, 6, 'Desa Layak Air Bersih dan Sanitasi', '#26bde2', 'bi-droplet', 74.60, 'Akses air bersih dan sanitasi layak bagi semua.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(7, 7, 'Desa Berenergi Bersih dan Terbarukan', '#fcc30b', 'bi-lightning-charge', 48.90, 'Energi bersih dan terjangkau untuk warga desa.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(8, 8, 'Pertumbuhan Ekonomi Desa Merata', '#a21942', 'bi-graph-up-arrow', 57.70, 'Ekonomi desa tumbuh merata dan berkelanjutan.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(9, 9, 'Infrastruktur dan Inovasi Desa', '#fd6925', 'bi-cone-striped', 60.10, 'Infrastruktur desa sesuai kebutuhan dan inovatif.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(10, 10, 'Desa Tanpa Kesenjangan', '#dd1367', 'bi-people', 55.40, 'Mengurangi kesenjangan antar warga desa.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(11, 11, 'Kawasan Permukiman Desa Aman dan Nyaman', '#fd9d24', 'bi-house-check', 66.90, 'Permukiman desa yang aman, nyaman, dan tertata.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(12, 12, 'Konsumsi dan Produksi Desa Sadar Lingkungan', '#bf8b2e', 'bi-recycle', 52.30, 'Pola konsumsi dan produksi yang ramah lingkungan.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(13, 13, 'Desa Tanggap Perubahan Iklim', '#3f7e44', 'bi-cloud-sun', 49.80, 'Kesiapsiagaan desa terhadap perubahan iklim.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(14, 14, 'Desa Peduli Lingkungan Laut', '#0a97d9', 'bi-water', 45.00, 'Menjaga ekosistem perairan dan laut sekitar desa.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(15, 15, 'Desa Peduli Lingkungan Darat', '#56c02b', 'bi-tree', 63.20, 'Menjaga ekosistem daratan, hutan, dan lahan desa.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(16, 16, 'Desa Damai Berkeadilan', '#00689d', 'bi-shield-check', 70.50, 'Desa yang damai, adil, dan kelembagaan kuat.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(17, 17, 'Kemitraan untuk Pembangunan Desa', '#19486a', 'bi-handshake', 58.60, 'Kerja sama multipihak untuk pembangunan desa.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38'),
(18, 18, 'Kelembagaan Desa Dinamis dan Budaya Desa Adaptif', '#6f1d78', 'bi-bank', 61.00, 'Kelembagaan desa dinamis dan budaya desa adaptif.', 1, NULL, '2026-07-09 16:29:38', '2026-07-09 16:29:38');



CREATE TABLE `services` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `slug` varchar(220) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `requirements` text DEFAULT NULL,
  `flow` text DEFAULT NULL,
  `duration` varchar(80) DEFAULT NULL,
  `fee` varchar(80) DEFAULT NULL,
  `template` mediumtext DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `services` (`id`, `name`, `slug`, `description`, `requirements`, `flow`, `duration`, `fee`, `template`, `is_active`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Surat Keterangan Domisili', 'surat-keterangan-domisili', '<p>Surat keterangan yang menyatakan bahwa seseorang benar berdomisili di wilayah desa.</p>', 'Fotokopi KTP\nFotokopi KK\nSurat pengantar RT/RW', 'Ajukan permohonan online atau datang ke kantor desa\nVerifikasi berkas oleh petugas\nPenandatanganan oleh kepala desa\nSurat selesai dan dapat diambil', '1 hari kerja', 'Gratis', 'SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini Kepala Desa, menerangkan bahwa:\n\nNama : {nama}\nNIK : {nik}\nAlamat : {alamat}\n\nAdalah benar warga yang berdomisili di wilayah kami. Surat ini dibuat untuk keperluan: {keperluan}.\n\nNomor Surat: {nomor_surat}\nTanggal: {tanggal}', 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(2, 'Surat Keterangan Usaha', 'surat-keterangan-usaha', '<p>Surat keterangan bagi warga yang memiliki usaha untuk keperluan permodalan atau perizinan.</p>', 'Fotokopi KTP\nFotokopi KK\nSurat pengantar RT/RW\nFoto tempat usaha', 'Ajukan permohonan\nVerifikasi dan survei singkat\nPenandatanganan\nSurat selesai', '1-2 hari kerja', 'Gratis', 'SURAT KETERANGAN USAHA\n\nYang bertanda tangan di bawah ini Kepala Desa, menerangkan bahwa:\n\nNama : {nama}\nNIK : {nik}\nAlamat : {alamat}\n\nAdalah benar memiliki usaha sebagaimana keperluan: {keperluan}.\n\nNomor Surat: {nomor_surat}\nTanggal: {tanggal}', 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(3, 'Surat Pengantar KTP', 'surat-pengantar-ktp', '<p>Surat pengantar untuk pembuatan atau perpanjangan KTP elektronik.</p>', 'Fotokopi KK\nSurat pengantar RT/RW', 'Ajukan permohonan\nVerifikasi data kependudukan\nSurat selesai', '1 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(4, 'Surat Pengantar KK', 'surat-pengantar-kk', '<p>Surat pengantar pembuatan atau perubahan Kartu Keluarga.</p>', 'Fotokopi KTP\nKK lama (jika perubahan)\nSurat pengantar RT/RW\nBuku nikah (jika KK baru)', 'Ajukan permohonan\nVerifikasi data\nSurat selesai', '1 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(5, 'Surat Keterangan Tidak Mampu', 'surat-keterangan-tidak-mampu', '<p>Surat keterangan untuk keperluan beasiswa, keringanan biaya kesehatan, dan bantuan sosial.</p>', 'Fotokopi KTP\nFotokopi KK\nSurat pengantar RT/RW', 'Ajukan permohonan\nVerifikasi kondisi oleh petugas\nPenandatanganan\nSurat selesai', '1-2 hari kerja', 'Gratis', 'SURAT KETERANGAN TIDAK MAMPU\n\nYang bertanda tangan di bawah ini Kepala Desa, menerangkan bahwa:\n\nNama : {nama}\nNIK : {nik}\nAlamat : {alamat}\n\nAdalah benar warga kami yang tergolong keluarga kurang mampu. Surat dibuat untuk keperluan: {keperluan}.\n\nNomor Surat: {nomor_surat}\nTanggal: {tanggal}', 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(6, 'Surat Keterangan Kelahiran', 'surat-keterangan-kelahiran', '<p>Surat keterangan kelahiran sebagai dasar pengurusan akta kelahiran.</p>', 'Surat keterangan lahir dari bidan/RS\nFotokopi KTP orang tua\nFotokopi KK\nFotokopi buku nikah', 'Ajukan permohonan\nVerifikasi berkas\nSurat selesai', '1 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(7, 'Surat Keterangan Kematian', 'surat-keterangan-kematian', '<p>Surat keterangan kematian untuk pengurusan akta kematian dan administrasi lainnya.</p>', 'Surat keterangan dari RS/pernyataan keluarga\nFotokopi KTP almarhum\nFotokopi KK', 'Ajukan permohonan\nVerifikasi\nSurat selesai', '1 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(8, 'Surat Keterangan Pindah', 'surat-keterangan-pindah', '<p>Surat pengantar pindah domisili keluar wilayah desa.</p>', 'Fotokopi KTP\nFotokopi KK\nSurat pengantar RT/RW', 'Ajukan permohonan\nVerifikasi\nSurat selesai', '1 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(9, 'Surat Keterangan Belum Menikah', 'surat-keterangan-belum-menikah', '<p>Surat keterangan status belum menikah untuk berbagai keperluan.</p>', 'Fotokopi KTP\nFotokopi KK\nSurat pengantar RT/RW\nMaterai', 'Ajukan permohonan\nVerifikasi\nSurat selesai', '1 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(10, 'Surat Pengantar Nikah', 'surat-pengantar-nikah', '<p>Surat pengantar nikah (N1-N4) untuk pendaftaran ke KUA.</p>', 'Fotokopi KTP calon pengantin\nFotokopi KK\nSurat pengantar RT/RW\nPas foto', 'Ajukan permohonan\nVerifikasi data\nSurat selesai', '1 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(11, 'Surat Keterangan Ahli Waris', 'surat-keterangan-ahli-waris', '<p>Surat keterangan ahli waris untuk pengurusan harta peninggalan.</p>', 'Fotokopi KTP seluruh ahli waris\nFotokopi KK\nSurat kematian\nSaksi 2 orang', 'Ajukan permohonan\nVerifikasi dan musyawarah keluarga\nPenandatanganan saksi & kepala desa\nSurat selesai', '2-3 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(12, 'Surat Keterangan Kehilangan', 'surat-keterangan-kehilangan', '<p>Surat keterangan kehilangan dokumen atau barang.</p>', 'Fotokopi KTP\nKronologi kehilangan', 'Ajukan permohonan\nVerifikasi\nSurat selesai', '1 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL),
(13, 'Surat Pengantar Lainnya', 'surat-pengantar-lainnya', '<p>Surat pengantar untuk keperluan lain yang membutuhkan pengantar desa.</p>', 'Fotokopi KTP\nFotokopi KK\nSurat pengantar RT/RW', 'Ajukan permohonan\nVerifikasi\nSurat selesai', '1 hari kerja', 'Gratis', NULL, 1, NULL, '2026-07-08 22:07:33', '2026-07-08 22:07:33', NULL);



CREATE TABLE `service_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `ticket` varchar(30) NOT NULL,
  `service_id` int(10) UNSIGNED NOT NULL,
  `nik` char(16) NOT NULL,
  `nama` varchar(150) NOT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `keperluan` text DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `status` enum('baru','diproses','selesai','ditolak') NOT NULL DEFAULT 'baru',
  `admin_note` text DEFAULT NULL,
  `letter_number` varchar(80) DEFAULT NULL,
  `processed_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `service_requirements` (
  `id` int(10) UNSIGNED NOT NULL,
  `service_id` int(10) UNSIGNED NOT NULL,
  `requirement` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `site_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `sotk_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(150) NOT NULL,
  `jabatan` varchar(150) NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `sort_order` int(11) NOT NULL DEFAULT 99,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `stunting_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_inisial` varchar(20) NOT NULL COMMENT 'inisial saja, mis: A.R.',
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `rt` varchar(5) DEFAULT NULL,
  `rw` varchar(5) DEFAULT NULL,
  `tinggi_cm` decimal(5,2) DEFAULT 0.00,
  `berat_kg` decimal(5,2) DEFAULT 0.00,
  `status` enum('normal','pendek','sangat_pendek','beresiko') NOT NULL DEFAULT 'normal',
  `tindakan` varchar(255) DEFAULT NULL,
  `tanggal_pemeriksaan` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `umkm_products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `owner` varchar(150) DEFAULT NULL,
  `category` varchar(80) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` varchar(80) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `whatsapp` varchar(20) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `maps_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `username` varchar(60) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL DEFAULT 8,
  `phone` varchar(30) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `must_change_password` tinyint(1) NOT NULL DEFAULT 0,
  `remember_token` varchar(255) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL,
  `failed_attempts` int(11) NOT NULL DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `user_permissions` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `effect` enum('allow','deny') NOT NULL DEFAULT 'allow',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`,`permission_id`),
  KEY `idx_user_permissions_permission` (`permission_id`),
  KEY `idx_user_permissions_effect` (`effect`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `user_roles` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `village_officials` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(150) NOT NULL,
  `jabatan` varchar(120) NOT NULL,
  `kategori` varchar(30) NOT NULL DEFAULT 'pemerintah',
  `foto` varchar(255) DEFAULT NULL,
  `pendidikan` varchar(80) DEFAULT NULL,
  `masa_jabatan` varchar(60) DEFAULT NULL,
  `kontak` varchar(60) DEFAULT NULL,
  `tugas` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 99,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `show_on_home` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `village_potentials` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `category` varchar(30) NOT NULL DEFAULT 'lainnya',
  `description` mediumtext DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `village_profiles` (
  `id` int(10) UNSIGNED NOT NULL,
  `section_key` varchar(60) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `visit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(190) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `referer` varchar(255) DEFAULT NULL,
  `device` varchar(20) DEFAULT NULL,
  `browser` varchar(30) DEFAULT NULL,
  `os` varchar(30) DEFAULT NULL,
  `language` varchar(12) DEFAULT NULL,
  `is_unique` tinyint(1) NOT NULL DEFAULT 0,
  `country` varchar(80) DEFAULT NULL,
  `region_name` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `visited_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_logs_user` (`user_id`),
  ADD KEY `idx_logs_created` (`created_at`);

ALTER TABLE `admin_face_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_face_user_active` (`user_id`,`is_active`),
  ADD KEY `idx_face_login` (`is_active`,`model_version`,`user_id`,`created_by`),
  ADD KEY `fk_face_creator` (`created_by`);

ALTER TABLE `agendas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_agenda_date` (`event_date`);

ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ann_active` (`is_active`,`start_date`,`end_date`);

ALTER TABLE `background_music`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `bansos_programs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tahun` (`tahun`);

ALTER TABLE `bansos_recipients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_program` (`program_id`);

ALTER TABLE `blocked_ips`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_ip` (`ip`);

ALTER TABLE `budget_transparencies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_budget_year` (`year`,`type`);

ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_room` (`room_id`,`id`);

ALTER TABLE `chat_rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_last` (`last_message_at`);

ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket` (`ticket`),
  ADD KEY `idx_comp_status` (`status`);

ALTER TABLE `complaint_responses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cr_complaint` (`complaint_id`);

ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `development_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_proj_year` (`year`);

ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_doc_cat` (`category`,`is_public`,`is_active`);

ALTER TABLE `event_effects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_event_active` (`is_active`,`start_date`,`end_date`);

ALTER TABLE `event_effect_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_eel_event` (`event_effect_id`);

ALTER TABLE `event_effect_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ees_event` (`event_effect_id`);

ALTER TABLE `families`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_families_kk` (`no_kk`),
  ADD KEY `idx_fam_wilayah` (`dusun_id`,`rw_id`,`rt_id`);

ALTER TABLE `family_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fm_family` (`family_id`),
  ADD KEY `idx_fm_resident` (`resident_id`);

ALTER TABLE `feedback_questions`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `feedback_responses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_created` (`created_at`);

ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_gal_album` (`album_id`,`is_active`);

ALTER TABLE `gallery_albums`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

ALTER TABLE `idm_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_tahun` (`tahun`);

ALTER TABLE `import_logs`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `ip_locations`
  ADD PRIMARY KEY (`ip`);

ALTER TABLE `media_files`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_menus_loc` (`location`,`is_active`,`sort_order`);

ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_news_status` (`status`,`published_at`),
  ADD KEY `idx_news_cat` (`category_id`),
  ADD KEY `idx_news_views` (`views`);

ALTER TABLE `news_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

ALTER TABLE `news_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_comments_news` (`news_id`,`is_approved`);

ALTER TABLE `news_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

ALTER TABLE `news_tag_relations`
  ADD PRIMARY KEY (`news_id`,`tag_id`);

ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

ALTER TABLE `push_notifications`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `push_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_endpoint` (`endpoint_hash`);

ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_regions_type` (`type`),
  ADD KEY `idx_regions_parent` (`parent_id`);

ALTER TABLE `residents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_residents_nik` (`nik`),
  ADD KEY `idx_res_nama` (`nama`),
  ADD KEY `idx_res_kk` (`no_kk`),
  ADD KEY `idx_res_wilayah` (`dusun_id`,`rw_id`,`rt_id`),
  ADD KEY `idx_res_deleted` (`deleted_at`),
  ADD KEY `idx_res_jk` (`jenis_kelamin`),
  ADD KEY `idx_res_status` (`status_penduduk`);

ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`);

ALTER TABLE `screenshot_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ip` (`ip_address`),
  ADD KEY `idx_created` (`created_at`);

ALTER TABLE `sdgs_scores`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

ALTER TABLE `service_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket` (`ticket`),
  ADD KEY `idx_sr_status` (`status`),
  ADD KEY `idx_sr_service` (`service_id`);

ALTER TABLE `service_requirements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sreq_service` (`service_id`);

ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

ALTER TABLE `sotk_items`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `stunting_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_rt_rw` (`rt`,`rw`),
  ADD KEY `idx_periksa` (`tanggal_pemeriksaan`);

ALTER TABLE `umkm_products`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_role` (`role_id`);

ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`);

ALTER TABLE `village_officials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_off_cat` (`kategori`,`is_active`,`sort_order`);

ALTER TABLE `village_potentials`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `village_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `section_key` (`section_key`);

ALTER TABLE `visit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_visited` (`visited_at`),
  ADD KEY `idx_path` (`path`),
  ADD KEY `idx_ip` (`ip_address`);


ALTER TABLE `activity_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=652;

ALTER TABLE `admin_face_profiles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `agendas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `announcements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `background_music`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `bansos_programs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `bansos_recipients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `blocked_ips`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `budget_transparencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `chat_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

ALTER TABLE `complaints`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `complaint_responses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `contact_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `development_projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `documents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `event_effects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `event_effect_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `event_effect_schedules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `families`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1785;

ALTER TABLE `family_members`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1773;

ALTER TABLE `feedback_questions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE `feedback_responses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `galleries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

ALTER TABLE `gallery_albums`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `idm_data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `import_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `media_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

ALTER TABLE `news`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

ALTER TABLE `news_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `news_comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `news_tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

ALTER TABLE `push_notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `push_subscriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

ALTER TABLE `regions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

ALTER TABLE `residents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5456;

ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `screenshot_attempts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

ALTER TABLE `sdgs_scores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

ALTER TABLE `services`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

ALTER TABLE `service_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `service_requirements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `site_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2381;

ALTER TABLE `sotk_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

ALTER TABLE `stunting_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `umkm_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `village_officials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

ALTER TABLE `village_potentials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `village_profiles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `visit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=792;


ALTER TABLE `admin_face_profiles`
  ADD CONSTRAINT `fk_face_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_face_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `bansos_recipients`
  ADD CONSTRAINT `fk_recipient_program` FOREIGN KEY (`program_id`) REFERENCES `bansos_programs` (`id`) ON DELETE CASCADE;


CREATE TABLE IF NOT EXISTS `visitor_devices` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `token_hash` char(64) NOT NULL,
  `token_hint` char(12) NOT NULL,
  `session_key` char(64) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `device` varchar(20) DEFAULT NULL,
  `browser` varchar(30) DEFAULT NULL,
  `os` varchar(30) DEFAULT NULL,
  `current_path` varchar(190) DEFAULT NULL,
  `current_title` varchar(190) DEFAULT NULL,
  `room_id` char(36) DEFAULT NULL,
  `pending_invite` tinyint(1) NOT NULL DEFAULT 0,
  `first_seen_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_seen_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_visitor_device_token` (`token_hash`),
  KEY `idx_visitor_device_online` (`last_seen_at`),
  KEY `idx_visitor_device_room` (`room_id`),
  KEY `idx_visitor_device_ip` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `chat_admin_initiations` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `room_id` char(36) NOT NULL,
  `visitor_device_id` bigint(20) UNSIGNED NOT NULL,
  `admin_user_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `page_path` varchar(190) DEFAULT NULL,
  `first_message` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_chat_init_room` (`room_id`),
  KEY `idx_chat_init_device` (`visitor_device_id`),
  KEY `idx_chat_init_admin` (`admin_user_id`),
  KEY `idx_chat_init_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `chat_quick_replies` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `body` varchar(1000) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_quick_active` (`is_active`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `chat_rooms`
  ADD COLUMN IF NOT EXISTS `visitor_device_id` bigint(20) UNSIGNED DEFAULT NULL AFTER `city`,
  ADD COLUMN IF NOT EXISTS `initiated_by_admin_id` int(10) UNSIGNED DEFAULT NULL AFTER `visitor_device_id`,
  ADD COLUMN IF NOT EXISTS `initiated_at` datetime DEFAULT NULL AFTER `initiated_by_admin_id`,
  ADD COLUMN IF NOT EXISTS `unread_user` int(11) NOT NULL DEFAULT 0 AFTER `unread_admin`;

ALTER TABLE `chat_messages`
  ADD COLUMN IF NOT EXISTS `sender_user_id` int(10) UNSIGNED DEFAULT NULL AFTER `sender`,
  ADD COLUMN IF NOT EXISTS `delivered_at` datetime DEFAULT NULL AFTER `body`,
  ADD COLUMN IF NOT EXISTS `read_at` datetime DEFAULT NULL AFTER `delivered_at`;

CREATE INDEX IF NOT EXISTS `idx_room_device` ON `chat_rooms` (`visitor_device_id`);
CREATE INDEX IF NOT EXISTS `idx_message_status` ON `chat_messages` (`room_id`, `sender`, `read_at`);

INSERT INTO `chat_quick_replies` (`title`,`body`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Tawarkan bantuan','Ada yang bisa kami bantu?',1,10,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `chat_quick_replies`);

INSERT INTO `chat_quick_replies` (`title`,`body`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Lengkapi data','Silakan lengkapi data berikut agar kami dapat membantu prosesnya.',1,20,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `chat_quick_replies` WHERE `title`='Lengkapi data');



CREATE TABLE IF NOT EXISTS `entertainment_devices` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `token_hash` char(64) NOT NULL,
  `token_hint` char(12) NOT NULL,
  `nickname` varchar(32) DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `device` varchar(20) DEFAULT NULL,
  `browser` varchar(30) DEFAULT NULL,
  `os` varchar(30) DEFAULT NULL,
  `total_points` int(11) NOT NULL DEFAULT 0,
  `current_streak` int(11) NOT NULL DEFAULT 0,
  `longest_streak` int(11) NOT NULL DEFAULT 0,
  `last_visit_date` date DEFAULT NULL,
  `first_seen_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_seen_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ent_device_token` (`token_hash`),
  KEY `idx_ent_points` (`total_points`),
  KEY `idx_ent_last_seen` (`last_seen_at`),
  KEY `idx_ent_ip` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entertainment_device_ips` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `first_seen_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_seen_at` datetime NOT NULL DEFAULT current_timestamp(),
  `visit_count` int(10) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ent_device_ip` (`device_id`,`ip_address`),
  KEY `idx_ent_ip_address` (`ip_address`),
  KEY `idx_ent_ip_last_seen` (`last_seen_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entertainment_events` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `event_type` varchar(40) NOT NULL,
  `game_type` varchar(30) DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT 0,
  `points` int(11) NOT NULL DEFAULT 0,
  `ip_address` varchar(45) NOT NULL,
  `page_path` varchar(190) DEFAULT NULL,
  `meta_json` longtext DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_ent_event_device` (`device_id`,`created_at`),
  KEY `idx_ent_event_type` (`event_type`,`game_type`,`created_at`),
  KEY `idx_ent_event_ip` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entertainment_daily_games` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `play_date` date NOT NULL,
  `game_type` varchar(30) NOT NULL,
  `attempts` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `best_score` int(11) NOT NULL DEFAULT 0,
  `points_awarded` int(11) NOT NULL DEFAULT 0,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ent_daily_game` (`device_id`,`play_date`,`game_type`),
  KEY `idx_ent_daily_date` (`play_date`,`game_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entertainment_quiz_questions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `question` varchar(500) NOT NULL,
  `option_a` varchar(255) NOT NULL,
  `option_b` varchar(255) NOT NULL,
  `option_c` varchar(255) NOT NULL,
  `option_d` varchar(255) NOT NULL,
  `correct_option` char(1) NOT NULL,
  `explanation` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_ent_quiz_active` (`is_active`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entertainment_quiz_answers` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` int(10) UNSIGNED NOT NULL,
  `answer_option` char(1) NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT 0,
  `points` int(11) NOT NULL DEFAULT 0,
  `answer_date` date NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ent_quiz_daily` (`device_id`,`answer_date`),
  KEY `idx_ent_quiz_question` (`question_id`),
  KEY `idx_ent_quiz_date` (`answer_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entertainment_wheel_spins` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `spin_date` date NOT NULL,
  `prize_label` varchar(80) NOT NULL,
  `prize_points` int(11) NOT NULL DEFAULT 0,
  `ip_address` varchar(45) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ent_wheel_daily` (`device_id`,`spin_date`),
  KEY `idx_ent_wheel_date` (`spin_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entertainment_device_badges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `badge_key` varchar(40) NOT NULL,
  `awarded_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ent_device_badge` (`device_id`,`badge_key`),
  KEY `idx_ent_badge_key` (`badge_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entertainment_daily_bonuses` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `bonus_date` date NOT NULL,
  `bonus_key` varchar(40) NOT NULL,
  `points` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ent_daily_bonus` (`device_id`,`bonus_date`,`bonus_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Bhinneka Tunggal Ika memiliki arti…','Berbeda-beda tetapi tetap satu','Bersatu kita teguh','Maju bersama bangsa','Gotong royong selamanya','A','Semboyan Bhinneka Tunggal Ika berarti berbeda-beda tetapi tetap satu.',1,10,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions`);

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Planet terbesar dalam tata surya adalah…','Bumi','Mars','Jupiter','Saturnus','C','Jupiter merupakan planet terbesar dalam tata surya.',1,20,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Planet terbesar dalam tata surya adalah…');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Air membeku pada suhu berapa derajat Celsius?','0°C','10°C','32°C','100°C','A','Pada tekanan normal, air membeku pada 0°C.',1,30,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Air membeku pada suhu berapa derajat Celsius?');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Hewan yang mengalami metamorfosis sempurna adalah…','Ayam','Kupu-kupu','Kucing','Ikan','B','Kupu-kupu melalui tahap telur, larva, pupa, dan dewasa.',1,40,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Hewan yang mengalami metamorfosis sempurna adalah…');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Pulau terluas di Indonesia adalah…','Jawa','Bali','Madura','Kalimantan','D','Bagian Indonesia di Pulau Kalimantan merupakan wilayah pulau terluas di Indonesia.',1,50,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Pulau terluas di Indonesia adalah…');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Perangkat untuk mengukur suhu disebut…','Barometer','Termometer','Higrometer','Speedometer','B','Termometer digunakan untuk mengukur suhu.',1,60,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Perangkat untuk mengukur suhu disebut…');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Sumber energi utama bagi bumi adalah…','Bulan','Angin','Matahari','Air','C','Sebagian besar energi di bumi berasal dari Matahari.',1,70,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Sumber energi utama bagi bumi adalah…');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Lawan kata “optimis” adalah…','Pesimis','Aktif','Kreatif','Objektif','A','Optimis berlawanan makna dengan pesimis.',1,80,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Lawan kata “optimis” adalah…');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Hasil dari 12 × 8 adalah…','84','88','92','96','D','12 dikalikan 8 sama dengan 96.',1,90,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Hasil dari 12 × 8 adalah…');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Organ tubuh yang memompa darah adalah…','Paru-paru','Ginjal','Jantung','Hati','C','Jantung memompa darah ke seluruh tubuh.',1,100,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Organ tubuh yang memompa darah adalah…');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Bahasa pemrograman yang berjalan langsung di browser adalah…','JavaScript','SQL','PHP','C','A','JavaScript merupakan bahasa utama yang dijalankan langsung oleh browser.',1,110,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Bahasa pemrograman yang berjalan langsung di browser adalah…');

INSERT INTO `entertainment_quiz_questions`
(`question`,`option_a`,`option_b`,`option_c`,`option_d`,`correct_option`,`explanation`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Satu jam terdiri dari berapa menit?','30','45','60','90','C','Satu jam terdiri dari 60 menit.',1,120,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `entertainment_quiz_questions` WHERE `question`='Satu jam terdiri dari berapa menit?');


COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;




SET NAMES utf8mb4;

SET @db_name := DATABASE();

SET @sql := IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS
   WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='entertainment_devices' AND COLUMN_NAME='avatar_key') = 0,
  "ALTER TABLE entertainment_devices ADD COLUMN avatar_key VARCHAR(30) NOT NULL DEFAULT 'leaf' AFTER nickname",
  "SELECT 1"
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS
   WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='entertainment_devices' AND COLUMN_NAME='frame_key') = 0,
  "ALTER TABLE entertainment_devices ADD COLUMN frame_key VARCHAR(30) NOT NULL DEFAULT 'simple' AFTER avatar_key",
  "SELECT 1"
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS
   WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='entertainment_devices' AND COLUMN_NAME='featured_badge') = 0,
  "ALTER TABLE entertainment_devices ADD COLUMN featured_badge VARCHAR(40) DEFAULT NULL AFTER frame_key",
  "SELECT 1"
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS entertainment_activity_rewards (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  device_id BIGINT UNSIGNED NOT NULL,
  reward_date DATE NOT NULL,
  activity_key VARCHAR(40) NOT NULL,
  source_key VARCHAR(190) DEFAULT NULL,
  points INT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_ent_activity_daily (device_id, reward_date, activity_key),
  KEY idx_ent_activity_date (reward_date, activity_key),
  KEY idx_ent_activity_device (device_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS entertainment_polls (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  question VARCHAR(500) NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  starts_at DATETIME DEFAULT NULL,
  ends_at DATETIME DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_ent_poll_active (is_active, starts_at, ends_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS entertainment_poll_options (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  poll_id INT UNSIGNED NOT NULL,
  label VARCHAR(255) NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY idx_ent_poll_option (poll_id, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS entertainment_poll_votes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  poll_id INT UNSIGNED NOT NULL,
  option_id INT UNSIGNED NOT NULL,
  device_id BIGINT UNSIGNED NOT NULL,
  ip_address VARCHAR(45) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_ent_poll_device (poll_id, device_id),
  KEY idx_ent_poll_vote (poll_id, option_id),
  KEY idx_ent_poll_vote_device (device_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS entertainment_story_progress (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  device_id BIGINT UNSIGNED NOT NULL,
  story_key VARCHAR(40) NOT NULL,
  node_key VARCHAR(40) NOT NULL,
  path_json LONGTEXT DEFAULT NULL,
  completed TINYINT(1) NOT NULL DEFAULT 0,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_ent_story_device (device_id, story_key),
  KEY idx_ent_story_updated (updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS entertainment_facts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  category VARCHAR(60) NOT NULL,
  content VARCHAR(700) NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  sort_order INT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_ent_fact_active (is_active, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS entertainment_daily_boxes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  device_id BIGINT UNSIGNED NOT NULL,
  claim_date DATE NOT NULL,
  reward_label VARCHAR(100) NOT NULL,
  reward_points INT NOT NULL DEFAULT 0,
  ip_address VARCHAR(45) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_ent_box_daily (device_id, claim_date),
  KEY idx_ent_box_date (claim_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO site_settings (setting_key, setting_value) VALUES
('entertainment_activity_points_enabled','1'),
('entertainment_poll_enabled','1'),
('entertainment_story_enabled','1'),
('entertainment_facts_enabled','1'),
('entertainment_profile_enabled','1'),
('entertainment_daily_box_enabled','1')
ON DUPLICATE KEY UPDATE setting_key=VALUES(setting_key);

INSERT INTO entertainment_polls
(question,is_active,starts_at,ends_at,created_at,updated_at)
SELECT
'Konten apa yang paling ingin Anda lihat lebih sering di website?',1,NULL,NULL,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM entertainment_polls LIMIT 1);

SET @poll_id := (SELECT id FROM entertainment_polls ORDER BY id DESC LIMIT 1);

INSERT INTO entertainment_poll_options (poll_id,label,sort_order)
SELECT @poll_id,'Informasi layanan',10
WHERE @poll_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entertainment_poll_options WHERE poll_id=@poll_id)
UNION ALL
SELECT @poll_id,'Berita dan kegiatan',20
WHERE @poll_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entertainment_poll_options WHERE poll_id=@poll_id)
UNION ALL
SELECT @poll_id,'Tips bermanfaat',30
WHERE @poll_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entertainment_poll_options WHERE poll_id=@poll_id)
UNION ALL
SELECT @poll_id,'Konten hiburan',40
WHERE @poll_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entertainment_poll_options WHERE poll_id=@poll_id);

INSERT INTO entertainment_facts (category,content,is_active,sort_order,created_at)
SELECT seed.category,seed.content,1,seed.sort_order,NOW()
FROM (
  SELECT 'Kesehatan' category,'Minum air secara teratur membantu tubuh menjaga suhu, konsentrasi, dan fungsi organ.' content,10 sort_order
  UNION ALL SELECT 'Keamanan Digital','Gunakan kata sandi yang berbeda untuk setiap akun dan aktifkan verifikasi dua langkah bila tersedia.',20
  UNION ALL SELECT 'Teknologi','QR Code dapat menyimpan teks, tautan, kontak, atau informasi verifikasi dalam pola dua dimensi.',30
  UNION ALL SELECT 'Lingkungan','Memisahkan sampah organik dan anorganik membuat proses pengolahan dan daur ulang lebih efektif.',40
  UNION ALL SELECT 'Pengetahuan','Lebah berkomunikasi tentang arah sumber makanan melalui gerakan yang dikenal sebagai tarian waggle.',50
  UNION ALL SELECT 'Kesehatan','Berjalan kaki ringan secara rutin dapat membantu menjaga kebugaran jantung dan kualitas tidur.',60
  UNION ALL SELECT 'Keamanan Digital','Jangan pernah membagikan kode OTP, PIN, atau kata sandi kepada siapa pun.',70
  UNION ALL SELECT 'Budaya','Gotong royong merupakan nilai sosial yang menekankan kerja bersama untuk kepentingan bersama.',80
  UNION ALL SELECT 'Teknologi','Cache browser membantu halaman yang pernah dikunjungi dimuat lebih cepat.',90
  UNION ALL SELECT 'Lingkungan','Menanam tanaman lokal dapat membantu menyediakan habitat bagi serangga penyerbuk.',100
  UNION ALL SELECT 'Pengetahuan','Satu hari di Bumi berlangsung sekitar 23 jam 56 menit bila dihitung terhadap bintang-bintang.',110
  UNION ALL SELECT 'Kesehatan','Istirahat singkat setelah menatap layar dapat membantu mengurangi ketegangan mata.',120
) seed
WHERE NOT EXISTS (SELECT 1 FROM entertainment_facts LIMIT 1);

INSERT INTO site_settings (setting_key,setting_value)
VALUES ('entertainment_schema_version','2')
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value);

INSERT INTO site_settings (setting_key,setting_value)
VALUES ('asset_version','20260726-entertainment-modern')
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value);

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS request_rate_limits (
  bucket_key CHAR(64) NOT NULL,
  endpoint VARCHAR(100) NOT NULL,
  ip_address VARCHAR(45) NOT NULL,
  window_start DATETIME NOT NULL,
  hits INT UNSIGNED NOT NULL DEFAULT 0,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (bucket_key),
  KEY idx_rate_updated (updated_at),
  KEY idx_rate_endpoint_ip (endpoint, ip_address, window_start)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS entertainment_game_sessions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  device_id BIGINT UNSIGNED NOT NULL,
  game_type VARCHAR(30) NOT NULL,
  nonce_hash CHAR(64) NOT NULL,
  started_at DATETIME NOT NULL,
  expires_at DATETIME NOT NULL,
  used_at DATETIME DEFAULT NULL,
  client_seconds INT UNSIGNED DEFAULT NULL,
  client_moves INT UNSIGNED DEFAULT NULL,
  config_value TINYINT UNSIGNED NOT NULL DEFAULT 0,
  created_ip VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_ent_game_nonce (nonce_hash),
  KEY idx_ent_game_device (device_id, game_type, started_at),
  KEY idx_ent_game_expiry (expires_at, used_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



SET @desa_has_client_seconds := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'entertainment_game_sessions'
    AND column_name = 'client_seconds'
);
SET @desa_add_client_seconds := IF(
  @desa_has_client_seconds = 0,
  'ALTER TABLE `entertainment_game_sessions` ADD COLUMN `client_seconds` INT UNSIGNED DEFAULT NULL AFTER `used_at`',
  'SELECT 1'
);
PREPARE stmt_client_seconds FROM @desa_add_client_seconds;
EXECUTE stmt_client_seconds;
DEALLOCATE PREPARE stmt_client_seconds;

SET @desa_has_client_moves := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'entertainment_game_sessions'
    AND column_name = 'client_moves'
);
SET @desa_add_client_moves := IF(
  @desa_has_client_moves = 0,
  'ALTER TABLE `entertainment_game_sessions` ADD COLUMN `client_moves` INT UNSIGNED DEFAULT NULL AFTER `client_seconds`',
  'SELECT 1'
);
PREPARE stmt_client_moves FROM @desa_add_client_moves;
EXECUTE stmt_client_moves;
DEALLOCATE PREPARE stmt_client_moves;

SET @desa_has_game_config := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'entertainment_game_sessions'
    AND column_name = 'config_value'
);
SET @desa_add_game_config := IF(
  @desa_has_game_config = 0,
  'ALTER TABLE `entertainment_game_sessions` ADD COLUMN `config_value` TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER `client_moves`',
  'SELECT 1'
);
PREPARE stmt_game_config FROM @desa_add_game_config;
EXECUTE stmt_game_config;
DEALLOCATE PREPARE stmt_game_config;

SET @desa_has_created_ip := (
  SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'entertainment_game_sessions'
    AND column_name = 'created_ip'
);
SET @desa_add_created_ip := IF(
  @desa_has_created_ip = 0,
  'ALTER TABLE `entertainment_game_sessions` ADD COLUMN `created_ip` VARCHAR(45) NOT NULL DEFAULT '''' AFTER `config_value`',
  'SELECT 1'
);
PREPARE stmt_created_ip FROM @desa_add_created_ip;
EXECUTE stmt_created_ip;
DEALLOCATE PREPARE stmt_created_ip;

DROP PROCEDURE IF EXISTS desa_add_index;
DELIMITER $$
CREATE PROCEDURE desa_add_index(
  IN p_table VARCHAR(64),
  IN p_index VARCHAR(64),
  IN p_columns TEXT
)
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = DATABASE() AND table_name = p_table
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.statistics
    WHERE table_schema = DATABASE() AND table_name = p_table AND index_name = p_index
  ) THEN
    SET @sql_index = CONCAT(
      'ALTER TABLE `', REPLACE(p_table, '`', ''), '` ADD INDEX `',
      REPLACE(p_index, '`', ''), '` (', p_columns, ')'
    );
    PREPARE stmt_index FROM @sql_index;
    EXECUTE stmt_index;
    DEALLOCATE PREPARE stmt_index;
  END IF;
END$$
DELIMITER ;

CALL desa_add_index('news', 'idx_news_public', '`status`,`published_at`,`deleted_at`');
CALL desa_add_index('news', 'idx_news_category_public', '`category_id`,`status`,`published_at`');
CALL desa_add_index('news', 'idx_news_title_search', '`title`(120)');
CALL desa_add_index('announcements', 'idx_announcement_public', '`is_active`,`start_date`,`end_date`,`deleted_at`');
CALL desa_add_index('agendas', 'idx_agenda_public', '`event_date`,`status`,`deleted_at`');
CALL desa_add_index('services', 'idx_services_public', '`is_active`,`name`,`deleted_at`');
CALL desa_add_index('service_requests', 'idx_service_ticket', '`ticket`');
CALL desa_add_index('service_requests', 'idx_service_status_date', '`status`,`created_at`,`deleted_at`');
CALL desa_add_index('service_requests', 'idx_service_nik', '`nik`');
CALL desa_add_index('complaints', 'idx_complaint_ticket', '`ticket`');
CALL desa_add_index('complaints', 'idx_complaint_status_date', '`status`,`created_at`,`deleted_at`');
CALL desa_add_index('complaints', 'idx_complaint_category', '`category`,`created_at`');
CALL desa_add_index('galleries', 'idx_gallery_public', '`is_active`,`type`,`category`,`year`,`deleted_at`');
CALL desa_add_index('gallery_albums', 'idx_album_public', '`is_active`,`slug`');
CALL desa_add_index('umkm_products', 'idx_umkm_public', '`is_active`,`deleted_at`,`id`');
CALL desa_add_index('village_potentials', 'idx_potential_public', '`is_active`,`deleted_at`,`id`');
CALL desa_add_index('background_music', 'idx_music_public', '`is_active`,`start_date`,`end_date`,`id`');
CALL desa_add_index('menus', 'idx_menu_location_active', '`location`,`is_active`,`sort_order`,`parent_id`');
CALL desa_add_index('visit_logs', 'idx_visit_date_path', '`visited_at`,`path`(120)');
CALL desa_add_index('contact_messages', 'idx_contact_date', '`created_at`');
CALL desa_add_index('feedback_responses', 'idx_feedback_date', '`created_at`');
CALL desa_add_index('push_subscriptions', 'idx_push_created', '`created_at`');
CALL desa_add_index('entertainment_events', 'idx_ent_event_created', '`created_at`,`event_type`,`game_type`');

DROP PROCEDURE IF EXISTS desa_add_index;

DELETE FROM request_rate_limits WHERE updated_at < NOW() - INTERVAL 2 DAY;
DELETE FROM entertainment_game_sessions
WHERE expires_at < NOW() - INTERVAL 1 DAY
   OR (used_at IS NOT NULL AND used_at < NOW() - INTERVAL 1 DAY);
