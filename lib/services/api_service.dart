import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/auth.dart';
import '../models/cart_update.dart';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<dynamic> login(String username, String password) {
    final credentials = Auth(username: username, password: password);
    return http
        .post(Uri.parse('$baseUrl/auth/login'), body: credentials.toJson())
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return jsonData;
      }
    }).catchError((err) => print(err));
  }

  Future<List<Product>> getAllProducts() async {
    return http.get(Uri.parse('$baseUrl/products')).then((data) {
      final products = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        for (var product in jsonData) {
          products.add(Product.fromJson(product));
        }
      }
      return products;
    }).catchError((err) => print(err));
  }

  Future<Product?> getProduct(int id) {
    return http.get(Uri.parse('$baseUrl/products/$id')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return Product.fromJson(jsonData);
      }
      return null;
    }).catchError((err) => print(err));
  }

  Future<void> updateCart(int cartId, int productId) {
    final cartUpdate =
    CartUpdate(userId: cartId, date: DateTime.now(), products: [
      {'productId': productId, 'quantity': 1}
    ]);
    return http
        .put(Uri.parse('$baseUrl/carts/$cartId'),
        body: json.encode(cartUpdate.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }
}

