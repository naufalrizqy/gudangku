import 'package:flutter/material.dart';
import '../models/product_model.dart';

class KeranjangProvider with ChangeNotifier {
  final List<Product> _keranjang = [];

  List<Product> get keranjang => _keranjang;

  void tambahProduk(Product product) {
    _keranjang.add(product);
    notifyListeners();
  }

  void hapusProduk(Product product) {
    _keranjang.remove(product);
    notifyListeners();
  }

  void bersihkanKeranjang() {
    _keranjang.clear();
    notifyListeners();
  }
}
