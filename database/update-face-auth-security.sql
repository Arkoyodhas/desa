-- Penguatan login wajah admin untuk instalasi yang sudah berjalan.
-- Jalankan satu kali melalui phpMyAdmin setelah menimpa file aplikasi.

UPDATE admin_face_profiles
SET threshold = 0.815
WHERE threshold < 0.805
   OR threshold BETWEEN 0.839 AND 0.841;

ALTER TABLE admin_face_profiles
  MODIFY threshold DECIMAL(4,3) NOT NULL DEFAULT 0.815;

-- Dataset yang dibuat oleh akun lain, model lama, atau sampelnya tidak lengkap
-- dinonaktifkan. Pemilik akun harus login manual lalu mendaftarkan ulang sendiri.
UPDATE admin_face_profiles
SET is_active = 0
WHERE created_by IS NULL
   OR created_by <> user_id
   OR model_version <> 'human-3.3.6-faceres'
   OR sample_count < 3;
