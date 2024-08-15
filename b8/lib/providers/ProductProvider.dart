import 'package:b8/helpers/DatabaseHelper.dart';
import 'package:b8/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> fetchproducts() async {
    _products = await DatabaseHelper.instance.getAllProducts();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await DatabaseHelper.instance.createProduct(product);
    _products.add(product);
    notifyListeners();
  }
}
