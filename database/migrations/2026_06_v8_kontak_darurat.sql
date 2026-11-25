-- v8: Tombol Siaga & Kontak Darurat (tabel juga dibuat otomatis saat halaman pertama dibuka)
CREATE TABLE IF NOT EXISTS `emergency_contacts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `category` VARCHAR(30) NOT NULL DEFAULT 'lainnya',
  `phone` VARCHAR(20) NOT NULL,
  `has_whatsapp` TINYINT(1) NOT NULL DEFAULT 0,
  `icon` VARCHAR(40) NOT NULL DEFAULT 'bi-telephone-fill',
  `color` VARCHAR(7) NOT NULL DEFAULT '#DC2626',
  `sort_order` INT NOT NULL DEFAULT 99,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`), KEY `idx_emergency_order` (`is_active`, `sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `permissions` (`name`, `slug`, `created_at`, `updated_at`) VALUES ('Kelola Kontak Darurat', 'kelola_kontak_darurat', NOW(), NOW());
INSERT IGNORE INTO `role_permissions` (`role_id`, `permission_id`)
 SELECT rp.role_id, np.id FROM role_permissions rp JOIN permissions op ON op.id = rp.permission_id JOIN permissions np ON np.slug = 'kelola_kontak_darurat' WHERE op.slug = 'kelola_tampilan';

INSERT IGNORE INTO `site_settings` (`setting_key`, `setting_value`) VALUES ('siaga_enabled', '1'), ('siaga_label', 'Siaga Darurat'), ('btn_siaga_color', '#DC2626');
