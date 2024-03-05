import 'package:riverpod/riverpod.dart';
import '../models/product_model.dart';
import '../services/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/product_repository.dart';

final productRepositoryProvider = Provider((ref) => ProductRepository());

final productControllerProvider = Provider((ref) => ProductController(ref));

class ProductController {
  final dynamic ref;
  List<Product> favoriteProducts = [];

  ProductController(this.ref);

  Future<List<Product>> fetchProducts() async {
    final repository = ref.read(productRepositoryProvider);
    return await repository.getProducts();
  }

  bool isFavorite(Product product) {
    return favoriteProducts.contains(product);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      favoriteProducts.remove(product);
    } else {
      favoriteProducts.add(product);
    }
  }
}
