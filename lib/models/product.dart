import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int id;
  String title;
  double price;
  String? description;
  String? image;
  String? category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.description,
    this.image,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> data) => _$ProductFromJson(data);
}