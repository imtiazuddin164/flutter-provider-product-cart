import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;
    final cartProvider = context.read<CartProvider>();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product image
            Container(
              width: 65,
              height: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(product.image, style: const TextStyle(fontSize: 36)),
            ),

            const SizedBox(width: 12),

            // Product information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '৳${product.price.toStringAsFixed(0)}',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      // Minus button
                      IconButton(
                        onPressed: () {
                          cartProvider.decreaseQuantity(product);
                        },
                        icon: const Icon(Icons.remove),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${cartItem.quantity}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Plus button
                      IconButton(
                        onPressed: () {
                          cartProvider.increaseQuantity(product);
                        },
                        icon: const Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Remove button
            IconButton(
              onPressed: () {
                cartProvider.removeFromCart(product);
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
