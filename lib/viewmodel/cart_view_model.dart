import 'package:flutter/material.dart';
import 'package:remindbless/core/base_viewmodel.dart';
import 'package:remindbless/usecases/cart_usecase.dart';

import '../data/models/products/product_model.dart' show Product;

class CartViewModel extends BaseViewModel {
  final CartUseCase useCase;

  CartViewModel(this.useCase);

  final List<Product> _items = [];

  List<Product> get items => _items;

  /// Optional: lấy argument khi screen init
  @override
  void initBaseData() {
    super.initBaseData();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    Product? product = args?['product'];
    if(product != null){
      _items.add(product);
    }
  }

  void add(Product product) {
    final index = _items.indexWhere((p) => p.productId == product.productId);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(product..quantity = 1);
    }
    notifyListeners();
  }

  void remove(Product? product) {
    if(product != null){
      _items.removeWhere((p) => p.productId == product.productId);
      notifyListeners();
    }
  }

  void increase(Product? product) {
    if(product != null){
      product.quantity++;
      notifyListeners();
    }
  }

  void decrease(Product? product) {
    if (product != null && product.quantity > 1) {
      product.quantity--;
      notifyListeners();
    }
  }

  double get totalAmount {
    return _items.fold(
      0,
          (sum, p) => sum + p.productPriceSale * p.quantity,
    );
  }

}
