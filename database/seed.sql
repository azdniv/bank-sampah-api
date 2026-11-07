-- =====================================================
-- Data contoh Bank Sampah Desa Wanasari
-- Jalankan SETELAH schema.sql
-- =====================================================

INSERT INTO warga (nik, nama, alamat, no_hp) VALUES
('3500000000000001', 'Siti Aminah',  'Dusun Krajan RT 01 RW 01', '081234560001'),
('3500000000000002', 'Budi Santoso', 'Dusun Krajan RT 02 RW 01', '081234560002'),
('3500000000000003', 'Rina Wati',    'Dusun Tengah RT 01 RW 02', '081234560003');

INSERT INTO rekening_tabungan (warga_id, no_rekening, saldo) VALUES
(1, 'BS-0001', 39500),
(2, 'BS-0002', 21000),
(3, 'BS-0003', 6000);

INSERT INTO petugas (nama, no_hp) VALUES
('Agus Prasetyo', '081298760001'),
('Dewi Lestari',  '081298760002');

INSERT INTO kategori_sampah (nama_kategori) VALUES
('Plastik'),
('Kertas'),
('Logam'),
('Kaca');

INSERT INTO jenis_sampah (kategori_id, nama_jenis, harga_per_kg) VALUES
(1, 'Botol PET',          3000),
(1, 'Plastik Campur',     1500),
(2, 'Kardus',             2000),
(2, 'Kertas HVS',         2500),
(3, 'Kaleng Aluminium',  12000),
(3, 'Besi Tua',           3500),
(4, 'Botol Kaca',          500);

INSERT INTO setoran (warga_id, petugas_id, tanggal, total_nilai) VALUES
(1, 1, '2026-11-02', 12000),
(2, 1, '2026-11-03', 21000),
(1, 2, '2026-11-04', 27500),
(3, 2, '2026-11-04',  6000);

INSERT INTO detail_setoran (setoran_id, jenis_sampah_id, berat_kg, subtotal) VALUES
(1, 1, 2.00,  6000),
(1, 3, 3.00,  6000),
(2, 5, 1.50, 18000),
(2, 2, 2.00,  3000),
(3, 4, 4.00, 10000),
(3, 6, 5.00, 17500),
(4, 7, 6.00,  3000),
(4, 1, 1.00,  3000);