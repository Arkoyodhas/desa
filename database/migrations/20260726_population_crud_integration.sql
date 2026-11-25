-- Integrasi CRUD Penduduk, Keluarga, dan Anggota Keluarga
-- Tanggal: 2026-07-26
-- Backup database sebelum menjalankan file ini.

CREATE TABLE IF NOT EXISTS `family_members` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `family_id` int(10) UNSIGNED NOT NULL,
  `resident_id` int(10) UNSIGNED NOT NULL,
  `hubungan` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_fm_family` (`family_id`),
  KEY `idx_fm_resident` (`resident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Buang relasi yatim atau relasi yang tidak sesuai dengan Nomor KK penduduk.
DELETE fm
FROM family_members fm
LEFT JOIN residents r ON r.id = fm.resident_id
LEFT JOIN families f ON f.id = fm.family_id
WHERE r.id IS NULL
   OR f.id IS NULL
   OR r.deleted_at IS NOT NULL
   OR f.no_kk <> r.no_kk;

-- Pastikan satu penduduk hanya memiliki satu baris relasi.
DELETE fm1
FROM family_members fm1
INNER JOIN family_members fm2
  ON fm1.resident_id = fm2.resident_id
 AND fm1.id > fm2.id;

-- Tambahkan unique index hanya bila belum tersedia.
SET @has_unique_resident_index := (
  SELECT COUNT(*) FROM (
    SELECT index_name
    FROM information_schema.statistics
    WHERE table_schema = DATABASE()
      AND table_name = 'family_members'
      AND non_unique = 0
    GROUP BY index_name
    HAVING COUNT(*) = 1
       AND MAX(column_name) = 'resident_id'
  ) unique_resident_indexes
);
SET @add_unique_sql := IF(
  @has_unique_resident_index = 0,
  'ALTER TABLE family_members ADD UNIQUE KEY uq_family_members_resident (resident_id)',
  'SELECT 1'
);
PREPARE population_stmt FROM @add_unique_sql;
EXECUTE population_stmt;
DEALLOCATE PREPARE population_stmt;

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS tmp_population_heads;
CREATE TEMPORARY TABLE tmp_population_heads (
  no_kk CHAR(16) NOT NULL PRIMARY KEY,
  head_id INT(10) UNSIGNED NOT NULL,
  KEY idx_tmp_population_head (head_id)
) ENGINE=MEMORY
SELECT
  no_kk,
  COALESCE(
    MIN(CASE WHEN hubungan_keluarga = 'Kepala Keluarga' THEN id END),
    MIN(id)
  ) AS head_id
FROM residents
WHERE deleted_at IS NULL
  AND no_kk REGEXP '^[0-9]{16}$'
GROUP BY no_kk;

-- Tepat satu kepala keluarga untuk setiap Nomor KK.
UPDATE residents r
INNER JOIN tmp_population_heads h ON h.no_kk = r.no_kk
SET
  r.hubungan_keluarga = 'Famili Lain',
  r.updated_at = NOW()
WHERE r.deleted_at IS NULL
  AND r.hubungan_keluarga = 'Kepala Keluarga'
  AND r.id <> h.head_id;

UPDATE residents r
INNER JOIN tmp_population_heads h ON h.head_id = r.id
SET
  r.hubungan_keluarga = 'Kepala Keluarga',
  r.updated_at = NOW()
WHERE r.deleted_at IS NULL
  AND COALESCE(r.hubungan_keluarga, '') <> 'Kepala Keluarga';

-- Buat data keluarga yang belum tersedia.
INSERT INTO families (
  no_kk, kepala_keluarga, alamat, dusun_id, rw_id, rt_id,
  status, created_by, created_at, updated_at, deleted_at
)
SELECT
  r.no_kk, r.nama, r.alamat, r.dusun_id, r.rw_id, r.rt_id,
  'aktif', NULL, NOW(), NOW(), NULL
FROM tmp_population_heads h
INNER JOIN residents r ON r.id = h.head_id
LEFT JOIN families f ON f.no_kk = h.no_kk
WHERE f.id IS NULL;

-- Pulihkan dan perbarui keluarga berdasarkan kepala keluarga terpilih.
UPDATE families f
INNER JOIN tmp_population_heads h ON h.no_kk = f.no_kk
INNER JOIN residents r ON r.id = h.head_id
SET
  f.kepala_keluarga = r.nama,
  f.alamat = r.alamat,
  f.dusun_id = r.dusun_id,
  f.rw_id = r.rw_id,
  f.rt_id = r.rt_id,
  f.status = IF(f.status IN ('aktif', 'pindah', 'tidak_aktif'), f.status, 'aktif'),
  f.deleted_at = NULL,
  f.updated_at = NOW();

-- family_members adalah indeks turunan dari residents.no_kk.
DELETE FROM family_members;

INSERT INTO family_members (
  family_id, resident_id, hubungan, created_at, updated_at
)
SELECT
  f.id, r.id, r.hubungan_keluarga, NOW(), NOW()
FROM residents r
INNER JOIN families f
  ON f.no_kk = r.no_kk
 AND f.deleted_at IS NULL
WHERE r.deleted_at IS NULL
  AND r.no_kk REGEXP '^[0-9]{16}$';

DROP TEMPORARY TABLE IF EXISTS tmp_population_heads;

INSERT INTO site_settings (setting_key, setting_value)
VALUES ('population_sync_version', '20260726_population_crud_v1')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

COMMIT;
