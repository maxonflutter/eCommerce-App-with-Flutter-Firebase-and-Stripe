import 'package:ecommerce_with_flutter_firebase_and_stripe/models/cart_item.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Cart', style: textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${cart.totalQuantity} Items in the Cart',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: 16.0),
              (cart.cartItems.isEmpty)
                  ? const Text('No items in the cart')
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cart.cartItems.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final cartItem = cart.cartItems[index];
                        return CartItemCard(cartItem: cartItem);
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(child: Text('Total: \$${cart.totalPrice}')),
            const SizedBox(width: 16.0),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                child: const Text('Pay Now'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
