import 'package:flutter/material.dart';

class Kategori {
  final String nama;
  final String gambar; // path Image.asset
  final IconData ikon; // cadangan jika gambar gagal dimuat
  final MaterialColor warna;

  const Kategori({
    required this.nama,
    required this.gambar,
    required this.ikon,
    required this.warna,
  });
}

class Transaksi {
  final String judul;
  final int nominal;
  final Kategori kategori;
  final DateTime tanggal;
  final String catatan;

  const Transaksi({
    required this.judul,
    required this.nominal,
    required this.kategori,
    required this.tanggal,
    this.catatan = '',
  });
}
