-- Migrasi Live Chat berbasis perangkat
-- Kompatibel dengan MariaDB 10.6+. Jalankan sekali pada database lama bila
-- akun database produksi tidak memiliki izin CREATE/ALTER saat aplikasi berjalan.

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

INSERT INTO `site_settings` (`setting_key`,`setting_value`)
VALUES ('livechat_message_limit','20')
ON DUPLICATE KEY UPDATE `setting_key`=VALUES(`setting_key`);

INSERT INTO `site_settings` (`setting_key`,`setting_value`)
VALUES ('livechat_rate_minutes','1')
ON DUPLICATE KEY UPDATE `setting_key`=VALUES(`setting_key`);

INSERT INTO `chat_quick_replies` (`title`,`body`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Tawarkan bantuan','Ada yang bisa kami bantu?',1,10,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `chat_quick_replies`);

INSERT INTO `chat_quick_replies` (`title`,`body`,`is_active`,`sort_order`,`created_at`,`updated_at`)
SELECT 'Lengkapi data','Silakan lengkapi data berikut agar kami dapat membantu prosesnya.',1,20,NOW(),NOW()
WHERE NOT EXISTS (SELECT 1 FROM `chat_quick_replies` WHERE `title`='Lengkapi data');

INSERT INTO `site_settings` (`setting_key`,`setting_value`)
VALUES ('livechat_schema_version','2')
ON DUPLICATE KEY UPDATE `setting_value`=VALUES(`setting_value`);
