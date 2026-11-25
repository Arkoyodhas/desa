-- Perbaikan kompatibilitas Halaman Statis dan CRUD admin.
-- Aman dijalankan setelah backup database.
-- Catatan: kode aplikasi juga mencoba menambahkan kolom yang hilang secara otomatis.

CREATE TABLE IF NOT EXISTS `pages` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `slug` VARCHAR(200) NOT NULL,
  `content` MEDIUMTEXT NULL,
  `image` VARCHAR(255) NULL,
  `attachment` VARCHAR(255) NULL,
  `meta_title` VARCHAR(200) NULL,
  `meta_description` VARCHAR(300) NULL,
  `template` VARCHAR(30) NOT NULL DEFAULT 'default',
  `sort_order` INT NOT NULL DEFAULT 99,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_by` INT UNSIGNED NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_pages_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pada instalasi lama, gunakan menu Halaman Statis sekali setelah deployment.
-- Aplikasi akan mendeteksi dan menambahkan kolom berikut bila hilang:
-- image, attachment, meta_title, meta_description, template, sort_order,
-- is_active, created_by, created_at, updated_at, dan deleted_at.
