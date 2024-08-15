import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/Product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _shouldLog = true; // Cờ hiệu để kiểm soát việc logging

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final url = "http://10.0.2.2:8080/api/products";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // In log chỉ khi cờ hiệu cho phép
        if (_shouldLog) {
          print('Response body: ${response.body}');
          _shouldLog = false; // Chỉ in log một lần
        }

        final data = jsonResponse['data'] as List;
        _products = data.map((json) => Product.fromJson(json)).toList();
        //notifyListeners(); // Thông báo để cập nhật giao diện
      } else {
        if (_shouldLog) {
          print('Failed to load products. Status code: ${response.statusCode}');
          _shouldLog = false; // Chỉ in log một lần
        }
        throw Exception('Failed to load products');
      }
    } catch (error) {
      if (_shouldLog) {
        print('Error fetching products: $error');
        _shouldLog = false; // Chỉ in log một lần
      }
      throw error;
    }
  }

  // Phương thức thêm sản phẩm mới
  Future<void> addProduct(Product product) async {
    final url = "http://10.0.2.2:8080/api/products";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 201) {
        // Làm mới danh sách sản phẩm sau khi thêm sản phẩm mới
        await fetchProducts();
      } else {
        throw Exception('Failed to add product');
      }
    } catch (error) {
      print('Error adding product: $error');
      throw error;
    }
  }
}
