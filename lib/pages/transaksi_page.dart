import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/product_model.dart';
import '../models/transaction_model.dart';

class TransaksiPage extends StatelessWidget {
  static List<TransactionModel> history = [];

  const TransaksiPage({super.key});

  Future<void> _printTransaksi(BuildContext context) async {
    final pdf = pw.Document();
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final dateFormatter = DateFormat('dd MMM yyyy – HH:mm');

    if (history.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Belum ada riwayat transaksi')),
      );
      return;
    }

    for (var transaksi in history) {
      final total = transaksi.items.fold(0, (sum, item) => sum + item.price * item.quantity);

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Tanggal: ${dateFormatter.format(transaksi.dateTime)}"),
                pw.SizedBox(height: 10),
                ...transaksi.items.map((item) => pw.Text(
                    "${item.name} x${item.quantity} - ${currencyFormatter.format(item.price * item.quantity)}")),
                pw.Divider(),
                pw.Text(
                  "Total: ${currencyFormatter.format(total)}",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 20),
              ],
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final dateFormatter = DateFormat('dd MMM yyyy – HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () => _printTransaksi(context),
            tooltip: 'Cetak Transaksi',
          ),
        ],
      ),
      body: history.isEmpty
          ? const Center(child: Text('Belum ada transaksi'))
          : ListView.builder(
              itemCount: history.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final transaksi = history[index];
                final total = transaksi.items.fold(0, (sum, item) => sum + item.price * item.quantity);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🗓️ ${dateFormatter.format(transaksi.dateTime)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        ...transaksi.items.map((item) => Text(
                            "${item.name} x${item.quantity} - ${currencyFormatter.format(item.price * item.quantity)}")),
                        const Divider(),
                        Text(
                          "Total: ${currencyFormatter.format(total)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
