-- Zona Hiburan: streak bermain dan assignment kuis stabil tanpa layanan AI.
-- Aman dijalankan satu kali pada MySQL/MariaDB. Aplikasi juga menjalankan
-- migrasi setara otomatis melalui Entertainment::ensureSchema().

ALTER TABLE entertainment_devices
  ADD COLUMN IF NOT EXISTS last_play_date DATE DEFAULT NULL AFTER last_visit_date;

UPDATE entertainment_devices
SET last_play_date = last_visit_date
WHERE last_play_date IS NULL
  AND current_streak > 0
  AND last_visit_date IS NOT NULL;

ALTER TABLE entertainment_quiz_questions
  ADD COLUMN IF NOT EXISTS source VARCHAR(20) NOT NULL DEFAULT 'manual' AFTER sort_order,
  ADD COLUMN IF NOT EXISTS category VARCHAR(60) DEFAULT NULL AFTER source,
  ADD COLUMN IF NOT EXISTS difficulty VARCHAR(20) DEFAULT NULL AFTER category,
  ADD COLUMN IF NOT EXISTS question_hash CHAR(64) DEFAULT NULL AFTER difficulty;

CREATE TABLE IF NOT EXISTS entertainment_quiz_assignments (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  device_id BIGINT UNSIGNED NOT NULL,
  assignment_date DATE NOT NULL,
  question_id INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_ent_quiz_assignment (device_id, assignment_date),
  KEY idx_ent_quiz_assignment_question (question_id),
  KEY idx_ent_quiz_assignment_date (assignment_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

UPDATE entertainment_quiz_questions
SET is_active = 0, updated_at = NOW()
WHERE source = 'ai';

DELETE FROM site_settings
WHERE setting_key IN ('entertainment_ai_enabled', 'entertainment_ai_topics');

INSERT INTO site_settings (setting_key, setting_value)
VALUES ('entertainment_schema_version', '4')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);
