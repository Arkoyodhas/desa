-- Migrasi Zona Hiburan interaktif modern
-- Aman dijalankan pada instalasi lama. Jalankan satu kali melalui phpMyAdmin
-- atau biarkan aplikasi melakukan migrasi otomatis saat /hiburan dibuka.

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
