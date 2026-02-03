import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/data/models/banks/bank_model.dart';
import 'package:remindbless/data/models/products/product_model.dart';

class StoryItem {
  final String name;
  final String image;

  StoryItem({
    required this.name,
    required this.image,
  });

  factory StoryItem.fromJson(Map<String, dynamic> json) {
    return StoryItem(
      name: json['name'],
      image: json['image'],
    );
  }

}

class ProductRepository {
  static Future<List<Product>> loadProducts() async {
    final jsonString =
    await rootBundle.loadString(DataAssets.jsonProducts);

    final List data = json.decode(jsonString);
    return data.map((e) => Product.fromJson(e)).toList();
  }
  static Future<List<Bank>> loadBanks() async {
    final jsonString =
    await rootBundle.loadString(DataAssets.jsonBanks);

    final List data = json.decode(jsonString);
    return data.map((e) => Bank.fromJson(e)).toList();
  }


  static Future<List<StoryItem>> loadStory() async {
    final jsonString =
    await rootBundle.loadString(DataAssets.jsonStory);

    final List data = json.decode(jsonString);
    return data.map((e) => StoryItem.fromJson(e)).toList();
  }
}