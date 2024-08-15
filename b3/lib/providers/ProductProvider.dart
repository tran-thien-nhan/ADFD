// import 'package:b3/models/Product.dart';
// import 'package:flutter/material.dart';

// class Productprovider with ChangeNotifier {
//   final List<Product> _products = [
//     Product(
//         id: "1",
//         name: "tran",
//         price: 200,
//         isAvailable: true,
//         category: "food",
//         releaseDate: DateTime.now()),
//     Product(
//         id: "2",
//         name: "thien",
//         price: 250,
//         isAvailable: true,
//         category: "drink",
//         releaseDate: DateTime.now()),
//     Product(
//         id: "3",
//         name: "nhan",
//         price: 300,
//         isAvailable: true,
//         category: "food",
//         releaseDate: DateTime.now())
//   ];
//   List<Product> get products => _products;

//   void addProduct(Product product) {
//     _products.add(product);
//     notifyListeners();
//   }

//   //update product
//   void updateProduct(Product updatedProduct) {
//     int index =
//         _products.indexWhere((product) => product.id == updatedProduct.id);
//     if (index != -1) {
//       _products[index] = updatedProduct;
//       notifyListeners();
//     }
//   }
// }

import 'package:b3/models/Product.dart';
import 'package:flutter/material.dart';

class Productprovider with ChangeNotifier {
  final List<Product> _products = []; // Khởi tạo mảng rỗng

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  // Cập nhật sản phẩm
  void updateProduct(Product updatedProduct) {
    int index =
        _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }

  //delete sản phẩm
  void deleteProduct(String productId) {
    int index = _products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      _products.removeAt(index);
      notifyListeners();
    }
  }
}
