// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'title': instance.title,
      'description': instance.description,
      'image': instance.imageUrl,
      'category': instance.category,
    };
