import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/product_cart.dart';
import '../providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the SearchProvider
    final searchProvider = Provider.of<SearchProvider>(context);

    // Load products if not already loaded
    if (searchProvider.allProducts.isEmpty) {
      searchProvider.loadProductsFromAPI();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchDelegate());
            },
          ),
        ],
      ),
      body: searchProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : searchProvider.searchResults.isEmpty
          ? Center(child: Text('No products found'))
          : ListView.builder(
        itemCount: searchProvider.searchResults.length,
        itemBuilder: (context, index) {
          final product = searchProvider.searchResults[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search for products...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Reset query
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);

    // Trigger search on query update
    if (query.isNotEmpty) {
      searchProvider.searchProducts(query);
    }

    return Consumer<SearchProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: provider.searchResults.length,
          itemBuilder: (context, index) {
            final product = provider.searchResults[index];
            return ProductCard(product: product); // Custom widget to show product
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
