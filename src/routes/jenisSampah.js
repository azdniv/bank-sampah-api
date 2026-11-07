const express = require('express');
const pool = require('../db');

const router = express.Router();

// 1. GET semua data
router.get('/', async (req, res) => {
  try {
    const hasil = await pool.query(
      `SELECT j.id, j.kategori_id, k.nama_kategori, j.nama_jenis, j.harga_per_kg
       FROM jenis_sampah j
       JOIN kategori_sampah k ON k.id = j.kategori_id
       ORDER BY j.id`
    );
    res.json({ jumlah: hasil.rows.length, data: hasil.rows });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 2. GET berdasarkan ID
router.get('/:id', async (req, res) => {
  try {
    const hasil = await pool.query(
      `SELECT j.id, j.kategori_id, k.nama_kategori, j.nama_jenis, j.harga_per_kg
       FROM jenis_sampah j
       JOIN kategori_sampah k ON k.id = j.kategori_id
       WHERE j.id = $1`,
      [req.params.id]
    );
    if (hasil.rows.length === 0) {
      return res.status(404).json({ pesan: 'Data tidak ditemukan' });
    }
    res.json(hasil.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 3. POST data baru
router.post('/', async (req, res) => {
  try {
    const { kategori_id, nama_jenis, harga_per_kg } = req.body;

    if (!kategori_id || !nama_jenis || harga_per_kg === undefined) {
      return res.status(400).json({
        pesan: 'kategori_id, nama_jenis, dan harga_per_kg wajib diisi',
      });
    }

    const hasil = await pool.query(
      `INSERT INTO jenis_sampah (kategori_id, nama_jenis, harga_per_kg)
       VALUES ($1, $2, $3)
       RETURNING *`,
      [kategori_id, nama_jenis, harga_per_kg]
    );
    res.status(201).json({
      pesan: 'Data berhasil ditambahkan',
      data: hasil.rows[0],
    });
  } catch (error) {
    if (error.code === '23503') {
      return res.status(400).json({ pesan: 'kategori_id tidak ditemukan' });
    }
    res.status(500).json({ error: error.message });
  }
});

// 4. PUT update data
router.put('/:id', async (req, res) => {
  try {
    const { kategori_id, nama_jenis, harga_per_kg } = req.body;

    if (!kategori_id || !nama_jenis || harga_per_kg === undefined) {
      return res.status(400).json({
        pesan: 'kategori_id, nama_jenis, dan harga_per_kg wajib diisi',
      });
    }

    const hasil = await pool.query(
      `UPDATE jenis_sampah
       SET kategori_id = $1, nama_jenis = $2, harga_per_kg = $3
       WHERE id = $4
       RETURNING *`,
      [kategori_id, nama_jenis, harga_per_kg, req.params.id]
    );
    if (hasil.rows.length === 0) {
      return res.status(404).json({ pesan: 'Data tidak ditemukan' });
    }
    res.json({
      pesan: 'Data berhasil diperbarui',
      data: hasil.rows[0],
    });
  } catch (error) {
    if (error.code === '23503') {
      return res.status(400).json({ pesan: 'kategori_id tidak ditemukan' });
    }
    res.status(500).json({ error: error.message });
  }
});

// 5. DELETE hapus data
router.delete('/:id', async (req, res) => {
  try {
    const hasil = await pool.query(
      'DELETE FROM jenis_sampah WHERE id = $1 RETURNING *',
      [req.params.id]
    );
    if (hasil.rows.length === 0) {
      return res.status(404).json({ pesan: 'Data tidak ditemukan' });
    }
    res.json({
      pesan: 'Data berhasil dihapus',
      data: hasil.rows[0],
    });
  } catch (error) {
    if (error.code === '23503') {
      return res.status(409).json({
        pesan: 'Data tidak bisa dihapus karena sudah dipakai di detail setoran',
      });
    }
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;