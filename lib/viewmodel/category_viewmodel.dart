import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/base_viewmodel.dart';
import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/data/models/data_home.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/data/models/products/product_model.dart';
import 'package:remindbless/usecases/categories_usecase.dart';

class CategoryViewModel extends BaseViewModel {
  final CategoryUseCase useCase;

  CategoryViewModel(this.useCase) {
    // Tự động fetch khi ViewModel được tạo
    fetchCategories();
  }

  List<Category> categories = [];
  List<Product> products = [];

  /// Fetch categories từ API
  Future<void> fetchCategories() async {
    categories = categoriesDummy;
    // try {
    //   categories = await useCase.fetchCategories();
    // } catch (e) {
    //
    //
    // }
    notifyListeners();
  }

  Future<void> getProductsByCategoryKey(String categoryKey) async {
    products = await ProductRepository.loadProducts();
    if (categoryKey != 'ALL'){
      products = products
          .where((p) => p.categoryKey == categoryKey)
          .toList();
    }

    print("AAAAAAAA ${products.length}");

    // try {
    //   products = await useCase.getProductsByCategoryKey(categoryKey);
    //   print("API result: ${products.length}");
    // } catch (e) {
    //   await ProductRepository.loadProducts();
    //   products
    //       .where((p) => p.categoryKey == categoryKey)
    //       .toList();
    // }
    notifyListeners();
  }
}
