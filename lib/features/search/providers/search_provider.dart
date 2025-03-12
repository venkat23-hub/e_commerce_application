import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/models/product_model.dart';

class SearchProvider extends ChangeNotifier {
  List<Product> allProducts = [];  // List to hold all products fetched from API
  List<Product> searchResults = []; // Filtered list based on search query

  bool _isLoading = false; // To indicate whether products are being fetched

  // Function to load products from an API
  Future<void> loadProductsFromAPI() async {
    setLoading(true);

    // API endpoint (change this to your actual endpoint)
    final url = 'https://fakestoreapi.com/products';  // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Successfully fetched products
        final List<dynamic> data = json.decode(response.body);
        allProducts = data.map((item) => Product.fromJson(item)).toList();
        searchResults = List.from(allProducts); // Initialize searchResults with all products
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
    }

    setLoading(false);
    notifyListeners(); // Notify the listeners to update UI
  }

  // Function to filter products based on search query
  void searchProducts(String query) {
    if (query.isEmpty) {
      searchResults = List.from(allProducts); // Show all products if no query
    } else {
      searchResults = allProducts
          .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify the listeners to update the UI
  }

  // Set loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Notify listeners to update UI when loading state changes
  }

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Getter for the search results
  List<Product> get products => searchResults;
}
