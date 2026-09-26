import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
      body: cartProvider.cartItems.isEmpty
          ? _buildEmptyCart(context)
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...cartProvider.cartItems.map((cartItem) {
                  return CartItemWidget(cartItem: cartItem);
                }),
              ],
            ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),

            const SizedBox(height: 20),

            const Text(
              'Your Cart is Empty',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Add some products to your cart.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
