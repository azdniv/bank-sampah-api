require('dotenv').config();
const express = require('express');
const pool = require('./db');
const jenisSampahRoutes = require('./routes/jenisSampah');

const app = express();
app.use(express.json());

// Route pengetes koneksi server dan database
app.get('/', async (req, res) => {
  try {
    const hasil = await pool.query('SELECT COUNT(*) AS jumlah FROM jenis_sampah');
    res.json({
      pesan: 'API Bank Sampah Desa Wanasari berjalan',
      jumlah_jenis_sampah: Number(hasil.rows[0].jumlah),
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Route CRUD jenis sampah
app.use('/api/jenis-sampah', jenisSampahRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server berjalan di http://localhost:${PORT}`);
});