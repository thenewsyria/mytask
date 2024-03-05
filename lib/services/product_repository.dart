
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product_model.dart';

class ProductRepository {
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product(
        title: item['title'],
        price: item['price'].toDouble(),
        description: item['description'], 
        image: item['image'],
      )).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

