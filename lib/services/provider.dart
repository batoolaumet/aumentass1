import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/product.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final response = await http.get(Uri.parse('https://api.slingacademy.com/v1/sample-data/products'));

  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);
    final List<Product> products = List<Product>.from(data['products'].map((product) => Product.fromJson(product)));
    return products;
  } else {
    throw Exception('Failed to load products');
  }
});

// Provider for fetching product details based on the selected product's ID
final productDetailsProvider = FutureProviderFamily<ProductsResponse, int>((ref, productId) async {
  final response = await http.get(Uri.parse('https://api.slingacademy.com/v1/sample-data/products/$productId'));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    final ProductsResponse products_response = ProductsResponse.fromJson(data);
    print("/////////");
    print(products_response );
   return products_response;
  } else {
    throw Exception('Failed to load product details');
  }
});