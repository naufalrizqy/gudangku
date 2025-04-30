import 'product_model.dart';

class TransactionModel {
  final List<Product> items;
  final DateTime dateTime;

  TransactionModel({required this.items, required this.dateTime});
}