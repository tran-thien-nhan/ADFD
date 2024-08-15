class Product {
  final String id;
  final String name;
  final double price;
  final bool isAvailable;
  final String category;
  final DateTime releaseDate;
  final String image;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.isAvailable,
      required this.category,
      required this.releaseDate,
      required this.image});
}
