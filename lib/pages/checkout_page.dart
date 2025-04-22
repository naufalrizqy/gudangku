import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CheckoutPage extends StatefulWidget {
  final List<Product> items;

  const CheckoutPage({super.key, required this.items});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Map untuk menyimpan item dan jumlahnya
  final Map<Product, int> cart = {};

  @override
  void initState() {
    super.initState();
    // Inisialisasi jumlah jadi 1 untuk tiap produk awal
    for (var item in widget.items) {
      cart[item] = (cart[item] ?? 0) + 1;
    }
  }

  void increment(Product product) {
    setState(() {
      cart[product] = (cart[product] ?? 0) + 1;
    });
  }

  void decrement(Product product) {
    setState(() {
      if (cart[product] != null) {
        if (cart[product]! > 1) {
          cart[product] = cart[product]! - 1;
        } else {
          cart.remove(product); // hapus kalau 0
        }
      }
    });
  }

  int getTotal() {
    int total = 0;
    cart.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  void bayar() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keranjang masih kosong')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pembayaran berhasil!')),
      );
      setState(() {
        cart.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: cart.isEmpty
            ? const Center(
                child: Text('Keranjang kosong'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Produk dipilih:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final product = cart.keys.elementAt(index);
                        final qty = cart[product]!;
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(product.name),
                            subtitle: Text("Rp ${product.price} x $qty"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  onPressed: () => decrement(product),
                                ),
                                Text('$qty'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle),
                                  onPressed: () => increment(product),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Text(
                    "Total: Rp ${getTotal()}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: bayar,
                    icon: const Icon(Icons.payment),
                    label: const Text("Bayar Sekarang"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(48),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
