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
      final existing = checkoutItems.where((e) => e.name == product.name).toList();
      if (existing.isNotEmpty) {
        existing.first.quantity += 1;
      } else {
        checkoutItems.add(Product(name: product.name, price: product.price));
      }
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
          const Text("Product Terlaris",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // Produk
          ...products.map((product) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.fastfood, color: Colors.orange),
                  title: Text(product.name),
                  subtitle: Text("Rp ${product.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.orange),
                    onPressed: () => addToCheckout(product),
                  ),
                ),
              )),
        ],
      ),
      floatingActionButton: checkoutItems.isEmpty
          ? null
          : FloatingActionButton.extended(
              backgroundColor: Colors.orange,
              onPressed: goToCheckout,
              icon: const Icon(Icons.shopping_cart_checkout),
              label: const Text('Checkout'),
            ),
    );
  }
}
