/* Penyesuaian scan wajah untuk database website yang sudah berjalan. */
SET @desa_face_table_exists := (
  SELECT COUNT(*)
  FROM information_schema.tables
  WHERE table_schema = DATABASE()
    AND table_name = 'admin_face_profiles'
);

SET @desa_face_threshold_update := IF(
  @desa_face_table_exists = 1,
  'UPDATE `admin_face_profiles` SET `threshold` = 0.815 WHERE `threshold` < 0.805 OR `threshold` BETWEEN 0.839 AND 0.841',
  'SELECT 1'
);
PREPARE desa_face_threshold_stmt FROM @desa_face_threshold_update;
EXECUTE desa_face_threshold_stmt;
DEALLOCATE PREPARE desa_face_threshold_stmt;

SET @desa_face_threshold_default := IF(
  @desa_face_table_exists = 1,
  'ALTER TABLE `admin_face_profiles` MODIFY `threshold` DECIMAL(4,3) NOT NULL DEFAULT 0.815',
  'SELECT 1'
);
PREPARE desa_face_default_stmt FROM @desa_face_threshold_default;
EXECUTE desa_face_default_stmt;
DEALLOCATE PREPARE desa_face_default_stmt;
