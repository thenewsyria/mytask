// models/product_model.dart
class Product {
  final String title;
  final double price;
  final String description;
  final String image;
  bool isFavorite;

  Product({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });
}
