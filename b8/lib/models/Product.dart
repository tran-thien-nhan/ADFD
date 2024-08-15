class Product {
  int? id;
  String name;
  String category;
  bool isAvailable;
  String condition;

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.isAvailable,
    required this.condition,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'isAvailable': isAvailable,
      'condition': condition,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      category: json['category'] as String,
      isAvailable: json['isAvailable'] as bool,
      condition: json['condition'] as String,
    );
  }
}
