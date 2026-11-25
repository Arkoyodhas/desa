-- Data Stunting Desa Dawung - Juli 2026
-- Sumber: DATA STUNTING BULAN JULI 2026.xlsx
-- Dibuat agar kompatibel dengan tabel stunting_data pada aplikasi.
-- Privasi: nama disimpan sebagai inisial; NIK, alamat, dan posyandu tidak dimasukkan
-- karena kolom tersebut tidak tersedia dan tampilan publik memang menggunakan inisial.
-- Tanggal pemeriksaan pada sumber hanya menyebut bulan Juli 2026.
-- Nilai default di bawah menggunakan 2026-07-01; ubah satu nilai ini bila tanggal pastinya berbeda.

SET NAMES utf8mb4;
SET @tanggal_pemeriksaan_stunting := DATE('2026-07-01');
START TRANSACTION;

-- Baris 1: S.P.R. | lahir 2023-04-05 | RT 25
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'S.P.R.', '2023-04-05', 'L', '25', NULL,
  88.70, 11.80, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'S.P.R.'
    AND `tanggal_lahir` = '2023-04-05'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 2: H.P.M. | lahir 2021-10-07 | RT 6
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'H.P.M.', '2021-10-07', 'L', '6', NULL,
  99.00, 12.50, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'H.P.M.'
    AND `tanggal_lahir` = '2021-10-07'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 3: B.S. | lahir 2022-04-08 | RT 10
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'B.S.', '2022-04-08', 'L', '10', NULL,
  93.50, 10.80, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'B.S.'
    AND `tanggal_lahir` = '2022-04-08'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 4: M.A.B.A. | lahir 2023-08-09 | RT 12
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'M.A.B.A.', '2023-08-09', 'L', '12', NULL,
  85.00, 11.50, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'M.A.B.A.'
    AND `tanggal_lahir` = '2023-08-09'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 5: D.E.F. | lahir 2022-09-09 | RT 8
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'D.E.F.', '2022-09-09', 'L', '8', NULL,
  93.30, 12.70, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'D.E.F.'
    AND `tanggal_lahir` = '2022-09-09'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 6: A.W.N. | lahir 2025-07-12 | RT 28
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'A.W.N.', '2025-07-12', 'L', '28', NULL,
  69.30, 8.20, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'A.W.N.'
    AND `tanggal_lahir` = '2025-07-12'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 7: M.K.M. | lahir 2024-05-14 | RT 27
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'M.K.M.', '2024-05-14', 'L', '27', NULL,
  80.60, 9.70, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'M.K.M.'
    AND `tanggal_lahir` = '2024-05-14'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 8: A.D.J. | lahir 2024-01-20 | RT 29
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'A.D.J.', '2024-01-20', 'L', '29', NULL,
  84.00, 10.90, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'A.D.J.'
    AND `tanggal_lahir` = '2024-01-20'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 9: A.M.A.G. | lahir 2021-07-23 | RT 6
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'A.M.A.G.', '2021-07-23', 'L', '6', NULL,
  98.80, 15.50, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'A.M.A.G.'
    AND `tanggal_lahir` = '2021-07-23'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 10: L.A.B. | lahir 2024-06-05 | RT 29
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'L.A.B.', '2024-06-05', 'L', '29', NULL,
  80.50, 9.60, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'L.A.B.'
    AND `tanggal_lahir` = '2024-06-05'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 11: B.M. | lahir 2024-10-30 | RT 29
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'B.M.', '2024-10-30', 'L', '29', NULL,
  76.30, 8.10, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'B.M.'
    AND `tanggal_lahir` = '2024-10-30'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 12: A.K.J.A. | lahir 2023-12-01 | RT 15
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'A.K.J.A.', '2023-12-01', 'P', '15', NULL,
  83.70, 10.50, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'A.K.J.A.'
    AND `tanggal_lahir` = '2023-12-01'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 13: D.Q.A. | lahir 2024-07-09 | RT 29
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'D.Q.A.', '2024-07-09', 'P', '29', NULL,
  79.00, 8.20, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'D.Q.A.'
    AND `tanggal_lahir` = '2024-07-09'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 14: R.H.K. | lahir 2023-11-09 | RT 20
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'R.H.K.', '2023-11-09', 'P', '20', NULL,
  84.20, 9.80, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'R.H.K.'
    AND `tanggal_lahir` = '2023-11-09'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 15: A.Q.A. | lahir 2024-07-14 | RT 13
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'A.Q.A.', '2024-07-14', 'P', '13', NULL,
  79.50, 9.80, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'A.Q.A.'
    AND `tanggal_lahir` = '2024-07-14'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 16: N.K.S. | lahir 2022-10-18 | RT 6
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'N.K.S.', '2022-10-18', 'P', '6', NULL,
  92.00, 12.10, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'N.K.S.'
    AND `tanggal_lahir` = '2022-10-18'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 17: Q.A.S. | lahir 2023-09-19 | RT 15
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'Q.A.S.', '2023-09-19', 'P', '15', NULL,
  84.30, 10.00, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'Q.A.S.'
    AND `tanggal_lahir` = '2023-09-19'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 18: F.R. | lahir 2022-09-29 | RT 25
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'F.R.', '2022-09-29', 'L', '25', NULL,
  92.00, 11.50, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'F.R.'
    AND `tanggal_lahir` = '2022-09-29'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 19: A.A.Z. | lahir 2023-05-24 | RT 12
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'A.A.Z.', '2023-05-24', 'P', '12', NULL,
  85.00, 9.50, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'A.A.Z.'
    AND `tanggal_lahir` = '2023-05-24'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 20: D.E.P.S. | lahir 2023-07-24 | RT 3
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'D.E.P.S.', '2023-07-24', 'P', '3', NULL,
  83.00, 10.50, 'sangat_pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'D.E.P.S.'
    AND `tanggal_lahir` = '2023-07-24'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 21: Z.M.K. | lahir 2023-09-28 | RT 32
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'Z.M.K.', '2023-09-28', 'P', '32', NULL,
  84.20, 9.50, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'Z.M.K.'
    AND `tanggal_lahir` = '2023-09-28'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 22: H.L.T. | lahir 2024-10-13 | RT 2
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'H.L.T.', '2024-10-13', 'L', '2', NULL,
  78.60, 10.00, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'H.L.T.'
    AND `tanggal_lahir` = '2024-10-13'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 23: G.P.M. | lahir 2024-12-16 | RT 6
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'G.P.M.', '2024-12-16', 'L', '6', NULL,
  77.50, 8.00, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'G.P.M.'
    AND `tanggal_lahir` = '2024-12-16'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 24: A.S.N. | lahir 2025-01-24 | RT 17
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'A.S.N.', '2025-01-24', 'L', '17', NULL,
  76.00, 8.60, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'A.S.N.'
    AND `tanggal_lahir` = '2025-01-24'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 25: M.A. | lahir 2021-12-29 | RT -
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'M.A.', '2021-12-29', 'L', NULL, NULL,
  96.50, 12.70, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'M.A.'
    AND `tanggal_lahir` = '2021-12-29'
    AND `jenis_kelamin` = 'L'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 26: G.P.J. | lahir 2023-06-03 | RT 3
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'G.P.J.', '2023-06-03', 'P', '3', NULL,
  87.00, 9.20, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'G.P.J.'
    AND `tanggal_lahir` = '2023-06-03'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 27: K.P.W. | lahir 2024-01-11 | RT 20
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'K.P.W.', '2024-01-11', 'P', '20', NULL,
  81.60, 9.20, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'K.P.W.'
    AND `tanggal_lahir` = '2024-01-11'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 28: J.R.P. | lahir 2024-09-14 | RT 6
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'J.R.P.', '2024-09-14', 'P', '6', NULL,
  78.00, 8.80, 'pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'J.R.P.'
    AND `tanggal_lahir` = '2024-09-14'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

-- Baris 29: A.M. | lahir 2022-11-24 | RT -
INSERT INTO `stunting_data`
  (`nama_inisial`, `tanggal_lahir`, `jenis_kelamin`, `rt`, `rw`, `tinggi_cm`, `berat_kg`, `status`, `tindakan`, `tanggal_pemeriksaan`, `created_at`)
SELECT
  'A.M.', '2022-11-24', 'P', NULL, NULL,
  86.00, 10.10, 'sangat_pendek', 'PMT Balita Stunting dari DD dan puskesmas,Mantoux test,konsul DSA',
  @tanggal_pemeriksaan_stunting, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1
  FROM `stunting_data`
  WHERE `nama_inisial` = 'A.M.'
    AND `tanggal_lahir` = '2022-11-24'
    AND `jenis_kelamin` = 'P'
    AND `tanggal_pemeriksaan` = @tanggal_pemeriksaan_stunting
);

COMMIT;

-- Ringkasan sumber:
-- Total data: 29
-- Laki-laki: 16
-- Perempuan: 13
-- Pendek: 27
-- Sangat pendek: 2
-- SQL ini aman diimpor ulang: data dengan inisial, tanggal lahir, jenis kelamin,
-- dan tanggal pemeriksaan yang sama tidak akan ditambahkan dua kali.
