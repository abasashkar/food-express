import 'dart:convert';
import 'package:ecomerce_bloc_new/data/models/product_models.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final String baseUrl = "http://10.0.2.2:6000";

  Future<List<Product>> fetchProduct() async {
    final response = await http.get(Uri.parse("$baseUrl/api/products/"));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> searchProduct(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/products?name=$query"),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Search failed');
    }
  }

  Future<List<Product>> fetchByCategory(String category) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/products?Category=$category"),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("category filter failed");
    }
  }
}
