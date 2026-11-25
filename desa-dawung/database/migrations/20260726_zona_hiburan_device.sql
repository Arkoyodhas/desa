-- Zona Hiburan berbasis perangkat anonim
-- Aman dijalankan pada instalasi lama. Tidak menghapus data apa pun.

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

INSERT INTO `site_settings` (`setting_key`,`setting_value`) VALUES
('entertainment_enabled','1'),
('entertainment_quiz_enabled','1'),
('entertainment_memory_enabled','1'),
('entertainment_puzzle_enabled','1'),
('entertainment_wheel_enabled','1'),
('entertainment_leaderboard_enabled','1'),
('entertainment_retention','permanent')
ON DUPLICATE KEY UPDATE `setting_key`=VALUES(`setting_key`);

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

INSERT INTO `site_settings` (`setting_key`,`setting_value`)
VALUES ('entertainment_schema_version','1')
ON DUPLICATE KEY UPDATE `setting_value`=VALUES(`setting_value`);
