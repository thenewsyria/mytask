import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/product_controller.dart';
import '../models/product_model.dart';



class ProductFavoriteScreen extends ConsumerWidget {
  const ProductFavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productController = ref.watch(productControllerProvider);

    List<Product> favoriteProducts = productController.favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text('No favorite products yet.'),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                Product product = favoriteProducts[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toString()}'),
                  leading: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Image.network(product.image),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/productDetail',
                      arguments: {
                        'title': product.title,
                        'price': product.price,
                        'description': product.description,
                        'image': product.image,
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}