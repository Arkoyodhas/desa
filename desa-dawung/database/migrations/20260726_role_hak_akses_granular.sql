-- ============================================================
-- Migrasi Role & Hak Akses Granular
-- Untuk website yang sudah berjalan di cPanel.
-- Aman dijalankan ulang.
-- ============================================================

CREATE TABLE IF NOT EXISTS `user_permissions` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `effect` enum('allow','deny') NOT NULL DEFAULT 'allow',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`,`permission_id`),
  KEY `idx_user_permissions_permission` (`permission_id`),
  KEY `idx_user_permissions_effect` (`effect`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `permissions` (`name`, `slug`, `created_at`, `updated_at`) VALUES
('Kelola Profil Desa', 'kelola_profil', NOW(), NOW()),
('Kelola Penduduk', 'kelola_penduduk', NOW(), NOW()),
('Import Penduduk', 'import_penduduk', NOW(), NOW()),
('Export Penduduk', 'export_penduduk', NOW(), NOW()),
('Kelola Data Publik', 'kelola_konten', NOW(), NOW()),
('Kelola Berita', 'kelola_berita', NOW(), NOW()),
('Kelola Galeri', 'kelola_galeri', NOW(), NOW()),
('Kelola Layanan', 'kelola_layanan', NOW(), NOW()),
('Kelola Pengaduan', 'kelola_pengaduan', NOW(), NOW()),
('Kelola Transparansi', 'kelola_transparansi', NOW(), NOW()),
('Kelola Dokumen', 'kelola_dokumen', NOW(), NOW()),
('Kelola Tampilan Website', 'kelola_tampilan', NOW(), NOW()),
('Kelola Musik', 'kelola_musik', NOW(), NOW()),
('Kelola Event Effect', 'kelola_event', NOW(), NOW()),
('Lihat Audit & Monitoring', 'lihat_audit', NOW(), NOW()),
('Kelola User Admin', 'kelola_user', NOW(), NOW())
ON DUPLICATE KEY UPDATE
  `name` = VALUES(`name`);

-- Admin Desa memperoleh izin Data Publik agar akses IDM, Bansos,
-- Stunting, PWA, dan QR konsisten dengan menu admin.
INSERT IGNORE INTO `role_permissions` (`role_id`, `permission_id`)
SELECT r.id, p.id
FROM `roles` r
JOIN `permissions` p ON p.slug = 'kelola_konten'
WHERE r.slug = 'admin-desa';

-- Bersihkan override yang menunjuk user atau permission yang sudah tidak ada.
DELETE up
FROM `user_permissions` up
LEFT JOIN `users` u ON u.id = up.user_id
LEFT JOIN `permissions` p ON p.id = up.permission_id
WHERE u.id IS NULL OR p.id IS NULL;
