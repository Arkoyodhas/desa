-- OPSIONAL: hapus permanen tabel/data dari fitur IMEI dan generator AI lama.
-- BUAT BACKUP DATABASE SEBELUM MENJALANKAN FILE INI.
-- Source code paket baru sudah tidak memiliki menu, rute, controller, atau konektor fitur tersebut.
-- Jangan jalankan file ini apabila riwayat lama masih perlu disimpan.

DROP TABLE IF EXISTS device_rate_limits;
DROP TABLE IF EXISTS device_registration_logs;
DROP TABLE IF EXISTS device_official_checks;
DROP TABLE IF EXISTS device_diagnostics;
DROP TABLE IF EXISTS device_registration_documents;
DROP TABLE IF EXISTS device_imeis;
DROP TABLE IF EXISTS device_registrations;

DROP TABLE IF EXISTS entertainment_ai_content;

UPDATE entertainment_quiz_questions
SET is_active = 0, updated_at = NOW()
WHERE source = 'ai';

DELETE FROM site_settings
WHERE setting_key IN ('entertainment_ai_enabled', 'entertainment_ai_topics');
