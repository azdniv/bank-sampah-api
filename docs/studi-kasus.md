# Studi Kasus: Sistem Informasi Bank Sampah Desa Wanasari

Desa Wanasari membutuhkan sistem informasi bank sampah untuk mendukung kebersihan lingkungan dan menambah penghasilan warga. Selama ini penyetoran sampah, harga per kilogram, dan saldo tabungan warga dicatat manual di buku sehingga rawan salah hitung dan sulit direkap. Sistem ini digunakan untuk mengelola data warga, rekening tabungan, petugas, jenis dan harga sampah, serta transaksi setoran.

## Kebutuhan Fitur
1. Mengelola data warga sebagai nasabah bank sampah
2. Mengelola rekening tabungan, satu rekening untuk satu warga
3. Mengelola data petugas yang menerima setoran
4. Mengelola kategori sampah (Plastik, Kertas, Logam, Kaca)
5. Mengelola jenis sampah beserta harga per kilogram
6. Mencatat transaksi setoran sampah oleh warga
7. Mencatat rincian jenis dan berat sampah pada setiap setoran

## Relasi Antar Tabel
- One to One: warga - rekening_tabungan
- One to Many: kategori_sampah - jenis_sampah, warga - setoran, petugas - setoran
- Many to Many: setoran - jenis_sampah (melalui detail_setoran)