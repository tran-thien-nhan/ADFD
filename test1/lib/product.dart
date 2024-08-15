class Product {
  int? id;
  String productName;
  double price;
  int quantity;

  Product(
      {this.id,
      required this.productName,
      required this.price,
      required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_name': productName,
      'price': price,
      'quantity': quantity,
    };
  }
}
