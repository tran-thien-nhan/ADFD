import 'dart:convert';
import 'dart:typed_data';

class Product {
  final int id;
  final String name;
  final double price;
  final String? imagePath;
  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
    };
  }
}
