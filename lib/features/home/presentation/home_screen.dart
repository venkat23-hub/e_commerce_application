import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../authentication/presentation/login_screen.dart';
import '../../cart/presentation/cart_screen.dart';
import '../../cart/providers/cart_provider.dart';
import '../../product_details/presentation/product_details_screen.dart';
import '../../search/presentation/search_screen.dart'; // Import the SearchScreen
import '../providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to hold the current selected index for Bottom Navigation
  int _currentIndex = 0;

  // Screens for Bottom Navigation
  final List<Widget> _screens = [
    HomeScreenBody(), // The main body of the HomeScreen
    SearchScreen(), // The Search Screen
    CartScreen(), // The CartScreen
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce App'),
        actions: [
          // Optional action like login or logout button
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex], // Display the selected screen based on the current index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartProvider.itemCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        cartProvider.itemCount.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Change the screen based on the selected index
          });
        },
      ),
    );
  }
}

// This widget displays the body of the home screen with a list of products
class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    // If products are empty, show a loading indicator
    if (homeProvider.products.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        // Load more products when the end of the list is reached
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          homeProvider.loadMore();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: homeProvider.products.length,
        itemBuilder: (context, index) {
          final product = homeProvider.products[index];

          return ListTile(
            leading: Image.network(product.image, width: 50), // Display product image
            title: Text(product.title),
            subtitle: Text('\$${product.price}'),
            onTap: () {
              // Navigate to product details screen when tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
