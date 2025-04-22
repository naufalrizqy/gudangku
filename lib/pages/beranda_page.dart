import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'checkout_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<Product> checkoutItems = [];

  final List<Product> products = [
    Product(name: "Nasi Goreng", price: 15000),
    Product(name: "Mie Ayam", price: 12000),
    Product(name: "Ayam Geprek", price: 17000),
    Product(name: "Bakso", price: 14000),
  ];

  void addToCheckout(Product product) {
    setState(() {
      checkoutItems.add(product);
    });
  }

  void goToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutPage(items: checkoutItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Product Terlaris",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // List Produk (Full Width)
          ...products.map((product) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: const Icon(Icons.fastfood, color: Colors.orange),
                  title: Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Rp ${product.price}",
                      style: const TextStyle(color: Colors.orange)),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.orange),
                    onPressed: () => addToCheckout(product),
                  ),
                ),
              )),
          const SizedBox(height: 24),

          const Text(
            "Transaksi Terbaru",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    offset: const Offset(0, 4)),
              ],
            ),
            child: const Center(
              child: Text("Tidak ada data", style: TextStyle(color: Colors.grey)),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: checkoutItems.isEmpty
          ? null
          : ElevatedButton.icon(
              onPressed: goToCheckout,
              icon: const Icon(Icons.shopping_cart_checkout),
              label: const Text("Checkout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
              ),
            ),
    );
  }
}
