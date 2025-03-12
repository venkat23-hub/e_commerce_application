import 'package:flutter/material.dart';
import '../../core/models/product_model.dart'; // Ensure the correct import path for your Product model
import '../features/product_details/presentation/product_details_screen.dart'; // Ensure the correct import path for your ProductDetailsScreen

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        leading: SizedBox(  // Added SizedBox to control the width of the leading widget
          width: 50,
          height: 50,
          child: Image.network(
            product.image, // Use the 'image' property as the URL for the product image
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          product.title, // Title of the product
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\$${product.price.toStringAsFixed(2)}', // Price of the product
          style: TextStyle(color: Colors.green),
        ),
        onTap: () {
          // Handle the tap to navigate to the Product Details screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product), // Pass the product to the details screen
            ),
          );
        },
      ),
    );
  }
}
