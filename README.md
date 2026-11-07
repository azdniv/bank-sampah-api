# Bank Sampah Desa Wanasari - Backend Database dan REST API

Backend sistem informasi bank sampah untuk Desa Wanasari, dibuat dengan **PostgreSQL** dan **Express.js**.

## Studi Kasus

Desa Wanasari membutuhkan sistem informasi bank sampah untuk mendukung kebersihan lingkungan dan menambah penghasilan warga. Selama ini penyetoran sampah, harga per kilogram, dan saldo tabungan warga dicatat manual di buku sehingga rawan salah hitung dan sulit direkap.

Sistem ini digunakan untuk mengelola data warga, rekening tabungan, petugas, jenis dan harga sampah, serta transaksi setoran. Penjelasan lengkap ada di `docs/studi-kasus.md`.

## Struktur Database

Terdiri dari 7 tabel:

| Tabel | Fungsi |
|---|---|
| `warga` | Data warga (nasabah) |
| `rekening_tabungan` | Rekening tabungan warga |
| `petugas` | Petugas penerima setoran |
| `kategori_sampah` | Kategori sampah (Plastik, Kertas, Logam, Kaca) |
| `jenis_sampah` | Jenis sampah beserta harga per kg |
| `setoran` | Transaksi penyetoran sampah |
| `detail_setoran` | Rincian jenis dan berat sampah tiap setoran |

### Relasi

| Jenis | Tabel |
|---|---|
| One to One | `warga` - `rekening_tabungan` |
| One to Many | `kategori_sampah` - `jenis_sampah` |
| One to Many | `warga` - `setoran` |
| One to Many | `petugas` - `setoran` |
| Many to Many | `setoran` - `jenis_sampah` (melalui `detail_setoran`) |

Skrip SQL ada di folder `database/`:
- `schema.sql` : membuat struktur tabel
- `seed.sql` : mengisi data contoh

## Teknologi

- Node.js
- Express.js
- PostgreSQL (library `pg`)
- dotenv
- nodemon (untuk development)

## Cara Menjalankan

1. Buat database `bank_sampah_db` di PostgreSQL
2. Jalankan `database/schema.sql`, lalu `database/seed.sql`
3. Salin `.env.example` menjadi `.env`, lalu isi `DB_PASSWORD` dengan password PostgreSQL Anda
4. Install dependensi:
   ```
   npm install
   ```
5. Jalankan server:
   ```
   npm run dev
   ```
6. Server berjalan di `http://localhost:3000`

## Endpoint REST API (tabel `jenis_sampah`)

| Method | URL | Fungsi |
|---|---|---|
| GET | `/api/jenis-sampah` | Ambil semua data |
| GET | `/api/jenis-sampah/:id` | Ambil data berdasarkan ID |
| POST | `/api/jenis-sampah` | Tambah data baru |
| PUT | `/api/jenis-sampah/:id` | Ubah data |
| DELETE | `/api/jenis-sampah/:id` | Hapus data |

### Contoh body untuk POST dan PUT

```json
{
  "kategori_id": 1,
  "nama_jenis": "Gelas Plastik",
  "harga_per_kg": 2000
}
```

## Hasil Pengujian Postman

Screenshot hasil tes kelima endpoint ada di folder `docs/screenshots/`.
