// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['id'] as int,
      userId: json['userId'] as int,
      date: DateTime.parse(json['date'] as String),
      products: json['products'] as List<dynamic>,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date.toIso8601String(),
      'products': instance.products,
    };
