-- =====================================================
-- Sistem Informasi Bank Sampah Desa Wanasari
-- Database: PostgreSQL
-- =====================================================

-- Hapus tabel lama (urutan dari tabel anak ke tabel induk)
DROP TABLE IF EXISTS detail_setoran;
DROP TABLE IF EXISTS setoran;
DROP TABLE IF EXISTS jenis_sampah;
DROP TABLE IF EXISTS kategori_sampah;
DROP TABLE IF EXISTS petugas;
DROP TABLE IF EXISTS rekening_tabungan;
DROP TABLE IF EXISTS warga;

-- 1. Data warga (nasabah bank sampah)
CREATE TABLE warga (
  id SERIAL PRIMARY KEY,
  nik VARCHAR(16) NOT NULL UNIQUE,
  nama VARCHAR(100) NOT NULL,
  alamat TEXT,
  no_hp VARCHAR(15)
);

-- 2. Rekening tabungan (ONE TO ONE dengan warga)
CREATE TABLE rekening_tabungan (
  id SERIAL PRIMARY KEY,
  warga_id INT NOT NULL UNIQUE REFERENCES warga(id) ON DELETE CASCADE,
  no_rekening VARCHAR(20) NOT NULL UNIQUE,
  saldo NUMERIC(12,2) NOT NULL DEFAULT 0
);

-- 3. Data petugas penerima setoran
CREATE TABLE petugas (
  id SERIAL PRIMARY KEY,
  nama VARCHAR(100) NOT NULL,
  no_hp VARCHAR(15)
);

-- 4. Kategori sampah
CREATE TABLE kategori_sampah (
  id SERIAL PRIMARY KEY,
  nama_kategori VARCHAR(50) NOT NULL UNIQUE
);

-- 5. Jenis sampah (ONE TO MANY: satu kategori punya banyak jenis)
CREATE TABLE jenis_sampah (
  id SERIAL PRIMARY KEY,
  kategori_id INT NOT NULL REFERENCES kategori_sampah(id),
  nama_jenis VARCHAR(100) NOT NULL,
  harga_per_kg NUMERIC(10,2) NOT NULL
);

-- 6. Setoran (ONE TO MANY: warga -> setoran, petugas -> setoran)
CREATE TABLE setoran (
  id SERIAL PRIMARY KEY,
  warga_id INT NOT NULL REFERENCES warga(id),
  petugas_id INT NOT NULL REFERENCES petugas(id),
  tanggal DATE NOT NULL DEFAULT CURRENT_DATE,
  total_nilai NUMERIC(12,2) NOT NULL DEFAULT 0
);

-- 7. Detail setoran (MANY TO MANY: setoran <-> jenis_sampah)
CREATE TABLE detail_setoran (
  setoran_id INT NOT NULL REFERENCES setoran(id) ON DELETE CASCADE,
  jenis_sampah_id INT NOT NULL REFERENCES jenis_sampah(id),
  berat_kg NUMERIC(8,2) NOT NULL,
  subtotal NUMERIC(12,2) NOT NULL,
  PRIMARY KEY (setoran_id, jenis_sampah_id)
);