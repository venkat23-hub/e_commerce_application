import 'package:flutter/material.dart';
import '../../../core/services/api_service.dart';
import '../../../core/models/product_model.dart';

class HomeProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  int _limit = 10;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  HomeProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedProducts = await ApiService().fetchProducts(_limit);
      _products = fetchedProducts;
    } catch (e) {
      print("Error fetching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void loadMore() {
    _limit += 5;
    fetchProducts();
  }
}
