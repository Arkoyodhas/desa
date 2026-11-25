-- =====================================================================
-- Migrasi v5 — Desa Dawung (jalankan sekali via phpMyAdmin > SQL)
-- Aman dijalankan ulang (IF EXISTS / IF NOT EXISTS / INSERT IGNORE).
-- =====================================================================

-- 1) Tabel FAQ beranda (juga dibuat otomatis oleh aplikasi bila belum ada)
CREATE TABLE IF NOT EXISTS `faqs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `question` VARCHAR(255) NOT NULL,
  `answer` TEXT NOT NULL,
  `sort_order` INT NOT NULL DEFAULT 99,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`), KEY `idx_faqs_order` (`is_active`, `sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2) Hapus penyimpanan email pada form publik (surat & feedback)
ALTER TABLE `service_requests` DROP COLUMN IF EXISTS `email`;
ALTER TABLE `feedback_responses` DROP COLUMN IF EXISTS `respondent_email`;
-- Pengaduan: kolom kontak kini hanya nomor HP; kosongkan kontak lama yang berupa email
UPDATE `complaints` SET `kontak` = NULL WHERE `kontak` LIKE '%@%';

-- 3) Izin (permission) granular baru. Role yang punya izin lama otomatis mendapat izin baru.
INSERT IGNORE INTO `permissions` (`name`, `slug`, `created_at`, `updated_at`) VALUES
 ('Balas Live Chat', 'balas_chat', NOW(), NOW()),
 ('Lihat Feedback / Survei', 'lihat_feedback', NOW(), NOW()),
 ('Lihat Statistik Kunjungan', 'lihat_kunjungan', NOW(), NOW()),
 ('Kelola Zona Hiburan', 'kelola_hiburan', NOW(), NOW());
INSERT IGNORE INTO `role_permissions` (`role_id`, `permission_id`)
 SELECT rp.role_id, np.id FROM role_permissions rp JOIN permissions op ON op.id = rp.permission_id JOIN permissions np ON np.slug = 'balas_chat' WHERE op.slug = 'kelola_tampilan';
INSERT IGNORE INTO `role_permissions` (`role_id`, `permission_id`)
 SELECT rp.role_id, np.id FROM role_permissions rp JOIN permissions op ON op.id = rp.permission_id JOIN permissions np ON np.slug = 'kelola_hiburan' WHERE op.slug = 'kelola_tampilan';
INSERT IGNORE INTO `role_permissions` (`role_id`, `permission_id`)
 SELECT rp.role_id, np.id FROM role_permissions rp JOIN permissions op ON op.id = rp.permission_id JOIN permissions np ON np.slug = 'lihat_feedback' WHERE op.slug = 'lihat_audit';
INSERT IGNORE INTO `role_permissions` (`role_id`, `permission_id`)
 SELECT rp.role_id, np.id FROM role_permissions rp JOIN permissions op ON op.id = rp.permission_id JOIN permissions np ON np.slug = 'lihat_kunjungan' WHERE op.slug = 'lihat_audit';

-- 4) Pengaturan baru (tabel key-value site_settings) — nilai default
INSERT IGNORE INTO `site_settings` (`setting_key`, `setting_value`) VALUES
 ('maintenance_mode', '0'), ('maintenance_message', ''), ('maintenance_until', ''),
 ('wa_route_chat', ''), ('wa_route_surat', ''), ('wa_route_aduan', ''),
 ('wa_route_kontak', ''), ('wa_route_feedback', ''), ('wa_route_keamanan', ''),
 ('hero_layer_sky', ''), ('hero_layer_hills', ''), ('hero_layer_village', ''), ('hero_diorama_image', '');

-- Catatan: kolom users.phone sudah ada; aplikasi kini mewajibkan diisi setelah login.
-- Reset password memakai users.reset_token (hash OTP) + users.reset_expires (10 menit).
