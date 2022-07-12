import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/auth.dart';
import '../models/cart.dart';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  static const headers = {'Content-type': 'application/json'};

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
    return http.get(Uri.parse('$baseUrl/products'), headers: headers).then((data) {
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
    return http.get(Uri.parse('$baseUrl/products/$id'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return Product.fromJson(jsonData);
      }
      return null;
    }).catchError((err) => print(err));
  }

  Future<List<Product>> getProductsByCategory(String categoryName) {
    return http
        .get(Uri.parse('$baseUrl/products/category/$categoryName'), headers: headers)
        .then((data) {
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

  Future<List<String>> getAllCategories() {
    return http.get(Uri.parse('$baseUrl/products/categories'), headers: headers).then((data) {
      final categories = <String>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        for (var category in jsonData) {
          categories.add(category);
        }
      }
      return categories;
    }).catchError((err) => print(err));
  }

  Future<Cart?> getCart(String id) {
    return http.get(Uri.parse('$baseUrl/carts/$id'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return Cart.fromJson(jsonData);
      }
      return null;
    }).catchError((err) => print(err));
  }

  Future<void> updateCart(int cartId, String userId, int productId) {
    return http
        .put(Uri.parse('$baseUrl/carts/$cartId'),
        body: jsonEncode(<String, dynamic>{
          "userId": userId,
          "date": DateTime.now().toString(),
          "products": [
            {"productId": productId, "quantity": 1}
          ]
        }))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((error) => print(error));
  }

  Future<void> deleteCart(String cartId) {
    return http.delete(Uri.parse('$baseUrl/carts/$cartId'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }
}

