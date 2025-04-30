import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'transaksi_page.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';

class CheckoutPage extends StatefulWidget {
  final List<Product> items;
  const CheckoutPage({super.key, required this.items});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  void tambah(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  void kurang(Product product) {
    setState(() {
      if (product.quantity > 1) {
        product.quantity--;
      } else {
        widget.items.remove(product);
      }
    });
  }

  void bayar() {
  if (widget.items.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Keranjang kosong')),
    );
    return;
  }

  // Simpan transaksi baru
  TransaksiPage.history.add(TransactionModel(
    items: widget.items.map((e) => Product(
      name: e.name,
      price: e.price,
      quantity: e.quantity,
    )).toList(),
    dateTime: DateTime.now(),
  ));

  // Kosongkan keranjang
  setState(() {
    widget.items.clear();
  });

  // Tampilkan notif
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Pembayaran berhasil!')),
  );
}


  @override
  Widget build(BuildContext context) {
    int total = widget.items.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: widget.items.isEmpty
          ? const Center(child: Text('Keranjang kosong'))
          : ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text("Rp ${item.price} x ${item.quantity}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => kurang(item),
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () => tambah(item),
                          icon: const Icon(Icons.add_circle, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
     bottomNavigationBar: Padding(
  padding: const EdgeInsets.all(16),
  child: ElevatedButton(
    onPressed: bayar,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.indigo,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    child: Text(
      'Bayar Rp $total',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white, // font warna putih
      ),
    ),
  ),
),

    );
  }
}
