import 'package:flutter/material.dart';
import '../models/transaksi.dart';

/// Gambar kategori (Image.asset). Jika file gambar belum ada,
/// otomatis memakai ikon sebagai cadangan.
class KategoriGambar extends StatelessWidget {
  final Kategori kategori;
  final double ukuran;

  const KategoriGambar({super.key, required this.kategori, this.ukuran = 44});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ukuran * 0.2),
      child: Image.asset(
        kategori.gambar,
        width: ukuran,
        height: ukuran,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: ukuran,
          height: ukuran,
          color: kategori.warna,
          child: Icon(kategori.ikon, color: Colors.white, size: ukuran * 0.55),
        ),
      ),
    );
  }
}
