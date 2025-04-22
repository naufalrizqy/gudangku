import 'package:flutter/material.dart';
import '../constants/colors.dart';
class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Kosong karena belum ada transaksi
    final bool isEmpty = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        foregroundColor: Colors.white ,
        backgroundColor: Colors.indigo,
      ),
      body: isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada transaksi',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView(
              // nanti kalau ada data transaksi, render ListTile di sini
            ),
    );
  }
}
