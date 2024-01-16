import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';
import '../models/product.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  StreamSubscription<List<Product>>? _productsSubscription;
  List<Product> _products = [];

  @override
  void initState() {
    _productsSubscription =
        productRepository.streamProducts(widget.category).listen((products) {
      setState(() {
        _products = products;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _productsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Catalog',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: Badge(
                isLabelVisible: cart.cartItems.isNotEmpty,
                label: Text('${cart.totalQuantity}'),
                child: const Icon(Icons.shopping_cart),
              ),
            )
          ],
        ),
        body: Center(
          child: ListView.builder(
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return ListTile(
                onTap: () {
                  cartRepository.addProductToCart(product, 1);
                  setState(() {});
                },
                leading: Image.network(
                  product.imageUrl,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                title: Text(product.name),
                subtitle: Text(product.category),
                trailing: Text('\$${product.price}'),
              );
            },
          ),
        ));
  }
}
