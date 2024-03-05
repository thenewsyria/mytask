import 'package:flutter/material.dart';
import '../controllers/product_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

class ProductListingScreen extends ConsumerWidget {
  const ProductListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productController = ref.watch(productControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Listing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/productFavorites');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: productController.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Product> productList = snapshot.data!;
            if (productList.isEmpty) {
              return const Center(
                child: Text('No products available.'),
              );
            }
            return ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                Product product = productList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ListTile(
                        title: Text(product.title),
                        subtitle: Text('\$${product.price.toString()}'),
                        leading: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Image.network(
                            product.image,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            productController.isFavorite(product)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: productController.isFavorite(product)
                                ? Colors.red
                                : null,
                          ),
                          onPressed: () {
                            productController.toggleFavorite(product);
                          },
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
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
