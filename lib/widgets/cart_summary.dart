import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Cart Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _buildRow('Total Items', '${cartProvider.totalItems}'),

            const SizedBox(height: 10),

            _buildRow(
              'Subtotal',
              '৳${cartProvider.subtotal.toStringAsFixed(0)}',
            ),

            const SizedBox(height: 10),

            _buildRow(
              'Discount (10%)',
              '- ৳${cartProvider.discount.toStringAsFixed(0)}',
            ),

            const Divider(height: 24),

            _buildRow(
              'Final Total',
              '৳${cartProvider.finalTotal.toStringAsFixed(0)}',
              isTotal: true,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showClearCartDialog(context);
                },
                icon: const Icon(Icons.delete_sweep),
                label: const Text('Clear Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Clear Cart?'),
          content: const Text(
            'Are you sure you want to remove all products from the cart?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CartProvider>().clearCart();
                Navigator.pop(dialogContext);
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }
}
