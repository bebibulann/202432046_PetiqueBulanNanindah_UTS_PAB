import 'package:flutter/material.dart';
import '../models/transaksi.dart';

const kategoriMakan = Kategori(
  nama: 'Makan',
  gambar: 'assets/images/makan.png',
  ikon: Icons.restaurant,
  warna: Colors.orange,
);
const kategoriTransportasi = Kategori(
  nama: 'Transportasi',
  gambar: 'assets/images/transportasi.png',
  ikon: Icons.directions_bus,
  warna: Colors.blue,
);
const kategoriKuliah = Kategori(
  nama: 'Kuliah',
  gambar: 'assets/images/kuliah.png',
  ikon: Icons.menu_book,
  warna: Colors.green,
);
const kategoriHiburan = Kategori(
  nama: 'Hiburan',
  gambar: 'assets/images/hiburan.png',
  ikon: Icons.movie,
  warna: Colors.purple,
);

const List<Kategori> daftarKategori = [
  kategoriMakan,
  kategoriTransportasi,
  kategoriKuliah,
  kategoriHiburan,
];

// Data awal (dummy). Disalin ke List sementara saat aplikasi berjalan.
final List<Transaksi> dataAwal = [
  Transaksi(
    judul: 'Nasi goreng kantin',
    nominal: 15000,
    kategori: kategoriMakan,
    tanggal: DateTime(2026, 11, 8),
    catatan: 'Makan siang',
  ),
  Transaksi(
    judul: 'Ojek online ke kampus',
    nominal: 18000,
    kategori: kategoriTransportasi,
    tanggal: DateTime(2026, 11, 8),
  ),
  Transaksi(
    judul: 'Fotokopi modul',
    nominal: 12000,
    kategori: kategoriKuliah,
    tanggal: DateTime(2026, 11, 7),
    catatan: 'Modul praktikum Flutter',
  ),
  Transaksi(
    judul: 'Nonton bioskop',
    nominal: 50000,
    kategori: kategoriHiburan,
    tanggal: DateTime(2026, 11, 6),
    catatan: 'Bersama teman satu kelas',
  ),
  Transaksi(
    judul: 'Kopi dan roti',
    nominal: 22000,
    kategori: kategoriMakan,
    tanggal: DateTime(2026, 11, 5),
  ),
  Transaksi(
    judul: 'Isi saldo e-money',
    nominal: 50000,
    kategori: kategoriTransportasi,
    tanggal: DateTime(2026, 11, 4),
  ),
  Transaksi(
    judul: 'Beli buku catatan',
    nominal: 25000,
    kategori: kategoriKuliah,
    tanggal: DateTime(2026, 11, 3),
  ),
  Transaksi(
    judul: 'Langganan musik',
    nominal: 20000,
    kategori: kategoriHiburan,
    tanggal: DateTime(2026, 11, 2),
  ),
];
