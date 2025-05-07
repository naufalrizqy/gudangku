import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../models/product_model.dart';
import '../models/transaction_model.dart';

class TransaksiPage extends StatelessWidget {
  static List<TransactionModel> history = [];

  const TransaksiPage({super.key});

  Future<void> _printTransaksi(BuildContext context) async {
    final pdf = pw.Document();
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final dateFormatter = DateFormat('dd MMM yyyy - HH:mm');

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
          margin: const pw.EdgeInsets.all(24),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text("Nota Pembelian", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                ),
                pw.Center(
                  child: pw.Text("Gudangku", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                ),
                pw.SizedBox(height: 5),
                pw.Divider(),
                pw.Text("Tanggal : ${dateFormatter.format(transaksi.dateTime)}"),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(4),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(3),
                    3: const pw.FlexColumnWidth(3),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Item')),
                        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Qty')),
                        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Harga')),
                        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Subtotal')),
                      ],
                    ),
                    ...transaksi.items.map((item) => pw.TableRow(
                          children: [
                            pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(item.name)),
                            pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('${item.quantity}')),
                            pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(currencyFormatter.format(item.price))),
                            pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(currencyFormatter.format(item.price * item.quantity))),
                          ],
                        )),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    "Total: ${currencyFormatter.format(total)}",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Center(child: pw.Text("Terima kasih telah berbelanja!", style: pw.TextStyle(fontStyle: pw.FontStyle.italic))),
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
