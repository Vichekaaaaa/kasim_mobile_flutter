import 'package:flutter/material.dart';
import 'package:kasim/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          'Cart is empty',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              leading: Image.asset(
                item.product.imageUrl,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                item.product.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                'Qty: ${item.quantity}  |  \$${item.product.price * item.quantity}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      cart.updateQuantity(item.product.id, item.quantity - 1);
                    },
                    child: const Text(
                      "-",
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cart.updateQuantity(item.product.id, item.quantity + 1);
                    },
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cart.removeFromCart(item.product.id);
                    },
                    child: const Text(
                      "✖",
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: cart.items.isEmpty
              ? null
              : () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Checkout Confirmation'),
                content: Text(
                  'Total: \$${cart.totalPrice.toStringAsFixed(2)}\nProceed with checkout?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cart.clearCart();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Checkout successful! Cart cleared.'),
                          backgroundColor: Colors.greenAccent,
                        ),
                      );
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Text(
            'Checkout & Clear Cart (\$${cart.totalPrice.toStringAsFixed(2)})',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}