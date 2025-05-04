import 'package:flutter/material.dart';
import 'package:kasim/model/user_model.dart';
import 'package:kasim/provider/auth_provider.dart';
import 'package:kasim/provider/user_provider.dart';
import 'package:kasim/screen/login_screen.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../provider/cart_provider.dart';
import 'cart_screen.dart';
import 'product_detail.dart';

class ProductScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Wireless Headphones',
      imageUrl: 'assets/images/1.png',
      price: 59.99,
      description: 'High-quality wireless headphones with noise cancellation and long battery life.',
    ),
    Product(
      id: '2',
      name: 'Smart Watch',
      imageUrl: 'assets/images/2.png',
      price: 120.00,
      description: 'Feature-packed smartwatch with fitness tracking and notifications.',
    ),
    Product(
      id: '3',
      name: 'Gaming Mouse',
      imageUrl: 'assets/images/3.png',
      price: 39.49,
      description: 'Ergonomic gaming mouse with customizable RGB lighting.',
    ),
    Product(
      id: '4',
      name: 'Bluetooth Speaker',
      imageUrl: 'assets/images/4.png',
      price: 79.99,
      description: 'Portable Bluetooth speaker with deep bass and waterproof design.',
    ),
    Product(
      id: '1',
      name: 'Wireless Headphones',
      imageUrl: 'assets/images/1.png',
      price: 59.99,
      description: 'High-quality wireless headphones with noise cancellation and long battery life.',
    ),
    Product(
      id: '2',
      name: 'Smart Watch',
      imageUrl: 'assets/images/2.png',
      price: 120.00,
      description: 'Feature-packed smartwatch with fitness tracking and notifications.',
    ),
    Product(
      id: '3',
      name: 'Gaming Mouse',
      imageUrl: 'assets/images/3.png',
      price: 39.49,
      description: 'Ergonomic gaming mouse with customizable RGB lighting.',
    ),
    Product(
      id: '4',
      name: 'Bluetooth Speaker',
      imageUrl: 'assets/images/4.png',
      price: 79.99,
      description: 'Portable Bluetooth speaker with deep bass and waterproof design.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<AuthProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                },
                child: const Text(
                  "🛒",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              if (cart.items.isNotEmpty)
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    '${cart.items.length}',
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
     drawer:  Drawer(
        backgroundColor: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${userProvider.userName}"),
              accountEmail: Text("${userProvider.userEmail}"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
              userProvider.logout();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(12.0),
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 0.7,
        children: products.map((product) {
          return Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Image.asset(
                    product.imageUrl,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      cart.addToCart(product);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}