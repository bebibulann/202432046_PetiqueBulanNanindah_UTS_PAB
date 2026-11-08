import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/transaksi.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _judulCtrl = TextEditingController();
  final _nominalCtrl = TextEditingController();
  final _catatanCtrl = TextEditingController();
  Kategori? _kategori;

  String? _errJudul;
  String? _errNominal;
  String? _errKategori;

  @override
  void dispose() {
    _judulCtrl.dispose();
    _nominalCtrl.dispose();
    _catatanCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    final judul = _judulCtrl.text.trim();
    final nominal = int.tryParse(_nominalCtrl.text.replaceAll('.', '').trim());

    setState(() {
      _errJudul = judul.isEmpty ? 'Keterangan wajib diisi' : null;
      _errNominal = (nominal == null || nominal <= 0)
          ? 'Nominal harus berupa angka lebih dari 0'
          : null;
      _errKategori = _kategori == null ? 'Pilih salah satu kategori' : null;
    });

    if (_errJudul != null || _errNominal != null || _errKategori != null) {
      return;
    }

    final baru = Transaksi(
      judul: judul,
      nominal: nominal!,
      kategori: _kategori!,
      tanggal: DateTime.now(),
      catatan: _catatanCtrl.text.trim(),
    );
    // Navigator.pop mengirim data transaksi baru kembali ke beranda.
    Navigator.pop(context, baru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _judulCtrl,
              decoration: InputDecoration(
                labelText: 'Keterangan',
                hintText: 'Contoh: Makan siang',
                border: const OutlineInputBorder(),
                errorText: _errJudul,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nominalCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nominal',
                prefixText: 'Rp ',
                border: const OutlineInputBorder(),
                errorText: _errNominal,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Kategori>(
              value: _kategori,
              decoration: InputDecoration(
                labelText: 'Kategori',
                border: const OutlineInputBorder(),
                errorText: _errKategori,
              ),
              items: daftarKategori
                  .map((k) => DropdownMenuItem(value: k, child: Text(k.nama)))
                  .toList(),
              onChanged: (k) => setState(() => _kategori = k),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _catatanCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tanggal otomatis diisi hari ini.',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _simpan,
                    child: const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
