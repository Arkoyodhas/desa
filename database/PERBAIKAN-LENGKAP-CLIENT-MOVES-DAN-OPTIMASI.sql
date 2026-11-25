-- PERBAIKAN LENGKAP: entertainment_game_sessions + indeks optimasi
-- Memperbaiki error:
-- Unknown column 'client_moves' in 'entertainment_game_sessions'
--
-- Aman dijalankan berulang pada MySQL 5.7+/8.0 dan MariaDB 10.3+.
-- Pilih database website desa terlebih dahulu sebelum mengimpor file ini.

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- 1. RATE LIMIT PERSISTEN
-- ============================================================
CREATE TABLE IF NOT EXISTS `request_rate_limits` (
  `bucket_key` CHAR(64) NOT NULL,
  `endpoint` VARCHAR(100) NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  `window_start` DATETIME NOT NULL,
  `hits` INT UNSIGNED NOT NULL DEFAULT 0,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`bucket_key`),
  KEY `idx_rate_updated` (`updated_at`),
  KEY `idx_rate_endpoint_ip` (`endpoint`, `ip_address`, `window_start`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 2. TABEL SESI GAME LENGKAP UNTUK INSTALASI BARU
-- ============================================================
CREATE TABLE IF NOT EXISTS `entertainment_game_sessions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` BIGINT UNSIGNED NOT NULL,
  `game_type` VARCHAR(30) NOT NULL,
  `nonce_hash` CHAR(64) NOT NULL,
  `started_at` DATETIME NOT NULL,
  `expires_at` DATETIME NOT NULL,
  `used_at` DATETIME DEFAULT NULL,
  `client_seconds` INT UNSIGNED DEFAULT NULL,
  `client_moves` INT UNSIGNED DEFAULT NULL,
  `config_value` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `created_ip` VARCHAR(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ent_game_nonce` (`nonce_hash`),
  KEY `idx_ent_game_device` (`device_id`, `game_type`, `started_at`),
  KEY `idx_ent_game_expiry` (`expires_at`, `used_at`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 3. PERBAIKAN TABEL LAMA
-- Kolom ditambahkan berurutan. client_moves dibuat sebelum
-- config_value sehingga klausa AFTER tidak lagi gagal.
-- ============================================================
DROP PROCEDURE IF EXISTS `desa_add_column_if_missing`;

DELIMITER $$

CREATE PROCEDURE `desa_add_column_if_missing`(
  IN p_table VARCHAR(64),
  IN p_column VARCHAR(64),
  IN p_definition TEXT
)
BEGIN
  IF EXISTS (
    SELECT 1
      FROM information_schema.tables
     WHERE table_schema = DATABASE()
       AND table_name = p_table
  ) AND NOT EXISTS (
    SELECT 1
      FROM information_schema.columns
     WHERE table_schema = DATABASE()
       AND table_name = p_table
       AND column_name = p_column
  ) THEN
    SET @desa_column_sql = CONCAT(
      'ALTER TABLE `',
      REPLACE(p_table, '`', ''),
      '` ADD COLUMN `',
      REPLACE(p_column, '`', ''),
      '` ',
      p_definition
    );

    PREPARE desa_column_stmt FROM @desa_column_sql;
    EXECUTE desa_column_stmt;
    DEALLOCATE PREPARE desa_column_stmt;
  END IF;
END$$

DELIMITER ;

-- Urutan kolom wajib dipertahankan.
CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'device_id',
  'BIGINT UNSIGNED NOT NULL DEFAULT 0 AFTER `id`'
);

CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'game_type',
  'VARCHAR(30) NOT NULL DEFAULT ''unknown'' AFTER `device_id`'
);

CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'nonce_hash',
  'CHAR(64) NOT NULL DEFAULT '''' AFTER `game_type`'
);

CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'started_at',
  'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `nonce_hash`'
);

CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'expires_at',
  'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `started_at`'
);

CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'used_at',
  'DATETIME DEFAULT NULL AFTER `expires_at`'
);

CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'client_seconds',
  'INT UNSIGNED DEFAULT NULL AFTER `used_at`'
);

CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'client_moves',
  'INT UNSIGNED DEFAULT NULL AFTER `client_seconds`'
);

CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'config_value',
  'TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER `client_moves`'
);

CALL `desa_add_column_if_missing`(
  'entertainment_game_sessions',
  'created_ip',
  'VARCHAR(45) NOT NULL DEFAULT '''' AFTER `config_value`'
);

DROP PROCEDURE IF EXISTS `desa_add_column_if_missing`;

-- Isi nonce kosong/NULL dengan nilai unik sebelum indeks UNIQUE dibuat.
UPDATE `entertainment_game_sessions`
   SET `nonce_hash` = SHA2(
     CONCAT(
       'repair:',
       `id`,
       ':',
       UUID(),
       ':',
       RAND()
     ),
     256
   )
 WHERE `nonce_hash` IS NULL
    OR `nonce_hash` = '';

-- Hapus duplikat nonce lama, hanya menyisakan ID terkecil.
DELETE newer
  FROM `entertainment_game_sessions` AS newer
  JOIN `entertainment_game_sessions` AS older
    ON older.`nonce_hash` = newer.`nonce_hash`
   AND older.`id` < newer.`id`;

-- ============================================================
-- 4. INDEKS TABEL SESI GAME
-- ============================================================
DROP PROCEDURE IF EXISTS `desa_add_index_if_missing`;

DELIMITER $$

CREATE PROCEDURE `desa_add_index_if_missing`(
  IN p_table VARCHAR(64),
  IN p_index VARCHAR(64),
  IN p_columns TEXT,
  IN p_unique TINYINT
)
BEGIN
  IF EXISTS (
    SELECT 1
      FROM information_schema.tables
     WHERE table_schema = DATABASE()
       AND table_name = p_table
  ) AND NOT EXISTS (
    SELECT 1
      FROM information_schema.statistics
     WHERE table_schema = DATABASE()
       AND table_name = p_table
       AND index_name = p_index
  ) THEN
    SET @desa_index_sql = CONCAT(
      'ALTER TABLE `',
      REPLACE(p_table, '`', ''),
      '` ADD ',
      IF(p_unique = 1, 'UNIQUE ', ''),
      'INDEX `',
      REPLACE(p_index, '`', ''),
      '` (',
      p_columns,
      ')'
    );

    PREPARE desa_index_stmt FROM @desa_index_sql;
    EXECUTE desa_index_stmt;
    DEALLOCATE PREPARE desa_index_stmt;
  END IF;
END$$

DELIMITER ;

CALL `desa_add_index_if_missing`(
  'entertainment_game_sessions',
  'uq_ent_game_nonce',
  '`nonce_hash`',
  1
);

CALL `desa_add_index_if_missing`(
  'entertainment_game_sessions',
  'idx_ent_game_device',
  '`device_id`,`game_type`,`started_at`',
  0
);

CALL `desa_add_index_if_missing`(
  'entertainment_game_sessions',
  'idx_ent_game_expiry',
  '`expires_at`,`used_at`',
  0
);

-- ============================================================
-- 5. INDEKS OPTIMASI WEBSITE
-- Prosedur hanya menambahkan indeks bila tabel dan seluruh
-- kolom yang dibutuhkan tersedia.
-- ============================================================
DROP PROCEDURE IF EXISTS `desa_add_safe_index`;

DELIMITER $$

CREATE PROCEDURE `desa_add_safe_index`(
  IN p_table VARCHAR(64),
  IN p_index VARCHAR(64),
  IN p_columns TEXT,
  IN p_required_columns TEXT
)
BEGIN
  DECLARE v_missing INT DEFAULT 0;
  DECLARE v_column VARCHAR(64);
  DECLARE v_remaining TEXT;
  DECLARE v_comma INT DEFAULT 0;

  SET v_remaining = p_required_columns;

  WHILE CHAR_LENGTH(v_remaining) > 0 DO
    SET v_comma = LOCATE(',', v_remaining);

    IF v_comma = 0 THEN
      SET v_column = TRIM(v_remaining);
      SET v_remaining = '';
    ELSE
      SET v_column = TRIM(SUBSTRING(v_remaining, 1, v_comma - 1));
      SET v_remaining = SUBSTRING(v_remaining, v_comma + 1);
    END IF;

    IF NOT EXISTS (
      SELECT 1
        FROM information_schema.columns
       WHERE table_schema = DATABASE()
         AND table_name = p_table
         AND column_name = v_column
    ) THEN
      SET v_missing = v_missing + 1;
    END IF;
  END WHILE;

  IF EXISTS (
    SELECT 1
      FROM information_schema.tables
     WHERE table_schema = DATABASE()
       AND table_name = p_table
  ) AND v_missing = 0
    AND NOT EXISTS (
      SELECT 1
        FROM information_schema.statistics
       WHERE table_schema = DATABASE()
         AND table_name = p_table
         AND index_name = p_index
    )
  THEN
    SET @desa_safe_index_sql = CONCAT(
      'ALTER TABLE `',
      REPLACE(p_table, '`', ''),
      '` ADD INDEX `',
      REPLACE(p_index, '`', ''),
      '` (',
      p_columns,
      ')'
    );

    PREPARE desa_safe_index_stmt FROM @desa_safe_index_sql;
    EXECUTE desa_safe_index_stmt;
    DEALLOCATE PREPARE desa_safe_index_stmt;
  END IF;
END$$

DELIMITER ;

CALL `desa_add_safe_index`('news', 'idx_news_public',
  '`status`,`published_at`,`deleted_at`',
  'status,published_at,deleted_at');

CALL `desa_add_safe_index`('news', 'idx_news_category_public',
  '`category_id`,`status`,`published_at`',
  'category_id,status,published_at');

CALL `desa_add_safe_index`('news', 'idx_news_title_search',
  '`title`(120)',
  'title');

CALL `desa_add_safe_index`('announcements', 'idx_announcement_public',
  '`is_active`,`start_date`,`end_date`,`deleted_at`',
  'is_active,start_date,end_date,deleted_at');

CALL `desa_add_safe_index`('agendas', 'idx_agenda_public',
  '`event_date`,`status`,`deleted_at`',
  'event_date,status,deleted_at');

CALL `desa_add_safe_index`('services', 'idx_services_public',
  '`is_active`,`name`,`deleted_at`',
  'is_active,name,deleted_at');

CALL `desa_add_safe_index`('service_requests', 'idx_service_ticket',
  '`ticket`',
  'ticket');

CALL `desa_add_safe_index`('service_requests', 'idx_service_status_date',
  '`status`,`created_at`,`deleted_at`',
  'status,created_at,deleted_at');

CALL `desa_add_safe_index`('service_requests', 'idx_service_nik',
  '`nik`',
  'nik');

CALL `desa_add_safe_index`('complaints', 'idx_complaint_ticket',
  '`ticket`',
  'ticket');

CALL `desa_add_safe_index`('complaints', 'idx_complaint_status_date',
  '`status`,`created_at`,`deleted_at`',
  'status,created_at,deleted_at');

CALL `desa_add_safe_index`('complaints', 'idx_complaint_category',
  '`category`,`created_at`',
  'category,created_at');

CALL `desa_add_safe_index`('galleries', 'idx_gallery_public',
  '`is_active`,`type`,`category`,`year`,`deleted_at`',
  'is_active,type,category,year,deleted_at');

CALL `desa_add_safe_index`('gallery_albums', 'idx_album_public',
  '`is_active`,`slug`',
  'is_active,slug');

CALL `desa_add_safe_index`('umkm_products', 'idx_umkm_public',
  '`is_active`,`deleted_at`,`id`',
  'is_active,deleted_at,id');

CALL `desa_add_safe_index`('village_potentials', 'idx_potential_public',
  '`is_active`,`deleted_at`,`id`',
  'is_active,deleted_at,id');

CALL `desa_add_safe_index`('background_music', 'idx_music_public',
  '`is_active`,`start_date`,`end_date`,`id`',
  'is_active,start_date,end_date,id');

CALL `desa_add_safe_index`('menus', 'idx_menu_location_active',
  '`location`,`is_active`,`sort_order`,`parent_id`',
  'location,is_active,sort_order,parent_id');

CALL `desa_add_safe_index`('visit_logs', 'idx_visit_date_path',
  '`visited_at`,`path`(120)',
  'visited_at,path');

CALL `desa_add_safe_index`('contact_messages', 'idx_contact_date',
  '`created_at`',
  'created_at');

CALL `desa_add_safe_index`('feedback_responses', 'idx_feedback_date',
  '`created_at`',
  'created_at');

CALL `desa_add_safe_index`('push_subscriptions', 'idx_push_created',
  '`created_at`',
  'created_at');

CALL `desa_add_safe_index`('entertainment_events', 'idx_ent_event_created',
  '`created_at`,`event_type`,`game_type`',
  'created_at,event_type,game_type');

DROP PROCEDURE IF EXISTS `desa_add_safe_index`;
DROP PROCEDURE IF EXISTS `desa_add_index_if_missing`;

-- ============================================================
-- 6. PEMBERSIHAN DATA SEMENTARA KEDALUWARSA
-- ============================================================
DELETE FROM `request_rate_limits`
 WHERE `updated_at` < NOW() - INTERVAL 2 DAY;

DELETE FROM `entertainment_game_sessions`
 WHERE `expires_at` < NOW() - INTERVAL 1 DAY
    OR (`used_at` IS NOT NULL
        AND `used_at` < NOW() - INTERVAL 1 DAY);

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- 7. VERIFIKASI
-- Hasil harus menampilkan client_seconds, client_moves,
-- config_value, dan created_ip.
-- ============================================================
SHOW COLUMNS FROM `entertainment_game_sessions`;
SHOW INDEX FROM `entertainment_game_sessions`;
