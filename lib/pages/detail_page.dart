import 'package:flutter/material.dart';
import '../models/transaksi.dart';
import '../utils/format.dart';
import '../widgets/kategori_gambar.dart';

class DetailPage extends StatelessWidget {
  final Transaksi transaksi;

  const DetailPage({super.key, required this.transaksi});

  @override
  Widget build(BuildContext context) {
    final t = transaksi;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Transaksi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            KategoriGambar(kategori: t.kategori, ukuran: 110),
            const SizedBox(height: 16),
            Text(
              rupiah(t.nominal),
              style: const TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _baris('Keterangan', t.judul),
                    const Divider(),
                    _baris('Kategori', t.kategori.nama),
                    const Divider(),
                    _baris('Tanggal', tanggalIndo(t.tanggal)),
                    const Divider(),
                    _baris('Catatan', t.catatan.isEmpty ? '-' : t.catatan),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kembali'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    // Mengirim perintah hapus kembali ke halaman sebelumnya.
                    onPressed: () => Navigator.pop(context, 'hapus'),
                    icon: const Icon(Icons.delete),
                    label: const Text('Hapus'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _baris(String label, String nilai) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(label, style: const TextStyle(color: Colors.black54)),
        ),
        Expanded(
          child: Text(nilai,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
