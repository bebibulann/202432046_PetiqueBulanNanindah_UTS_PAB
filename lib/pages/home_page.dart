import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/transaksi.dart';
import '../utils/format.dart';
import '../widgets/kategori_gambar.dart';
import 'detail_page.dart';
import 'form_page.dart';
import 'kategori_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Data disimpan sementara di List selama aplikasi berjalan.
  final List<Transaksi> _transaksi = List.of(dataAwal);

  int get _total => _transaksi.fold(0, (jumlah, t) => jumlah + t.nominal);

  int _subtotal(Kategori k) => _transaksi
      .where((t) => t.kategori == k)
      .fold(0, (jumlah, t) => jumlah + t.nominal);

  int _jumlah(Kategori k) => _transaksi.where((t) => t.kategori == k).length;

  // Navigator.push ke formulir, lalu menerima data baru lewat Navigator.pop.
  Future<void> _tambah() async {
    final hasil = await Navigator.push<Transaksi>(
      context,
      MaterialPageRoute(builder: (context) => const FormPage()),
    );
    if (hasil != null) {
      setState(() => _transaksi.insert(0, hasil));
    }
  }

  Future<void> _bukaDetail(Transaksi t) async {
    final hasil = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(transaksi: t)),
    );
    if (hasil == 'hapus') {
      setState(() => _transaksi.remove(t));
    }
  }

  void _bukaKategori(int indexTab) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KategoriPage(
          transaksi: _transaksi,
          indexAwal: indexTab,
          onHapus: (t) => setState(() => _transaksi.remove(t)),
        ),
      ),
    ).then((_) => setState(() {})); // segarkan ringkasan saat kembali
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Keuangan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            tooltip: 'Per kategori',
            onPressed: () => _bukaKategori(0),
          ),
        ],
      ),
      body: Column(
        children: [
          _headerTotal(),
          _judulBagian('Kategori'),
          SizedBox(
            height: 96,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: daftarKategori.length,
              itemBuilder: (context, index) =>
                  _kartuKategori(daftarKategori[index], index + 1),
            ),
          ),
          _judulBagian('Riwayat Transaksi'),
          Expanded(child: _daftarTransaksi()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambah,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }

  Widget _headerTotal() {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image.network: gambar dari internet
          Image.network(
            'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=800',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Theme.of(context).colorScheme.primary),
          ),
          Container(color: const Color(0x99000000)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Pengeluaran',
                    style: TextStyle(color: Colors.white70)),
                Text(
                  rupiah(_total),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_transaksi.length} transaksi tercatat',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _judulBagian(String teks) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          teks,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _kartuKategori(Kategori k, int indexTab) {
    return SizedBox(
      width: 190,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _bukaKategori(indexTab),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                KategoriGambar(kategori: k, ukuran: 44),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(k.nama,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(rupiah(_subtotal(k)),
                          style: const TextStyle(fontSize: 12)),
                      Text('${_jumlah(k)} transaksi',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _daftarTransaksi() {
    if (_transaksi.isEmpty) {
      return const Center(child: Text('Belum ada transaksi'));
    }
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: _transaksi.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final t = _transaksi[index];
        return ListTile(
          leading: KategoriGambar(kategori: t.kategori),
          title: Text(t.judul),
          subtitle: Text('${t.kategori.nama} • ${tanggalIndo(t.tanggal)}'),
          trailing: Text(
            '- ${rupiah(t.nominal)}',
            style: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onTap: () => _bukaDetail(t),
        );
      },
    );
  }
}
