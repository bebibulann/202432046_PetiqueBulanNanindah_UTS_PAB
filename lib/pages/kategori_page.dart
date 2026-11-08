import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/transaksi.dart';
import '../utils/format.dart';
import '../widgets/kategori_gambar.dart';
import 'detail_page.dart';

class KategoriPage extends StatefulWidget {
  final List<Transaksi> transaksi;
  final int indexAwal; // 0 = Semua, 1.. = kategori
  final void Function(Transaksi) onHapus;

  const KategoriPage({
    super.key,
    required this.transaksi,
    required this.onHapus,
    this.indexAwal = 0,
  });

  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  Future<void> _bukaDetail(Transaksi t) async {
    final hasil = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(transaksi: t)),
    );
    if (hasil == 'hapus') {
      widget.onHapus(t);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: daftarKategori.length + 1,
      initialIndex: widget.indexAwal,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaksi per Kategori'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              const Tab(text: 'Semua'),
              ...daftarKategori.map((k) => Tab(text: k.nama)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _isiTab(widget.transaksi, null),
            ...daftarKategori.map((k) => _isiTab(
                  widget.transaksi.where((t) => t.kategori == k).toList(),
                  k,
                )),
          ],
        ),
      ),
    );
  }

  Widget _isiTab(List<Transaksi> data, Kategori? kategori) {
    final subtotal = data.fold(0, (jumlah, t) => jumlah + t.nominal);
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (kategori != null) ...[
                  KategoriGambar(kategori: kategori, ukuran: 48),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kategori == null
                            ? 'Semua Kategori'
                            : 'Subtotal ${kategori.nama}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        rupiah(subtotal),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text('${data.length} transaksi'),
              ],
            ),
          ),
        ),
        Expanded(
          child: data.isEmpty
              ? const Center(child: Text('Belum ada transaksi'))
              : ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final t = data[index];
                    return ListTile(
                      leading: KategoriGambar(kategori: t.kategori),
                      title: Text(t.judul),
                      subtitle: Text(tanggalIndo(t.tanggal)),
                      trailing: Text(
                        '- ${rupiah(t.nominal)}',
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      onTap: () => _bukaDetail(t),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
