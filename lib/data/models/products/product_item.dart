import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:remindbless/core/app_assets.dart';

class ProductItem {
  final String id;
  final String name;
  final String image;
  final String price;
  final String priceSale;
  final String location; //dùng để show tag "tại cửa hàng" hay "online"
  final String categoryId;

  ProductItem({
    required this.id,
    required this.name,
    required this.image,
    required this.categoryId,
    required this.price,
    required this.priceSale,
    required this.location,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      categoryId: json['categoryId'],
      price: json['price'],
      priceSale: json['priceSale'],
      location: json['location'],
    );
  }

}

class ProductRepository {
  static Future<List<ProductItem>> loadProducts() async {
    final jsonString =
    await rootBundle.loadString(DataAssets.jsonProducts);

    final List data = json.decode(jsonString);
    return data.map((e) => ProductItem.fromJson(e)).toList();
  }
}