import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/product_details_screen.dart';
import 'views/product_favorite_screen.dart';
import 'views/product_listing_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const ProductListingScreen(),
        '/productDetail': (context) => const ProductDetailScreen(),
        '/productFavorites': (context) => const ProductFavoriteScreen(),

      },
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}
