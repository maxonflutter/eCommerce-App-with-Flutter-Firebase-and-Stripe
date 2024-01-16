import 'package:db_client/db_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_client/payment_client.dart';

import 'firebase_options.dart';
import 'models/cart.dart';
import 'repositories/cart_repository.dart';
import 'repositories/category_repository.dart';
import 'repositories/product_repository.dart';
import 'screens/cart_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/category_screen.dart';
import 'screens/checkout_screen.dart';

final dbClient = DbClient();
final paymentClient = PaymentClient();
final categoryRepository = CategoryRepository(dbClient: dbClient);
final productRepository = ProductRepository(dbClient: dbClient);
const cartRepository = CartRepository();

const userId = 'user_1234';
var cart = const Cart(
  userId: userId,
  cartItems: [],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TODO: Add your Stripe publishable key here
  Stripe.publishableKey =
      'pk_test_51L7cFkBAloH97gpnJnFBulAdxQ5IcE3C2LXUAVAQSe9c0iFh96N3EwndUU4Qdh7D2i20NnlMxevzWYN2iasrRcwJ00Ipz5b6sL';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CategoriesScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/categories') {
          return MaterialPageRoute(
            builder: (context) => const CategoriesScreen(),
          );
        }
        if (settings.name == '/cart') {
          return MaterialPageRoute(
            builder: (context) => const CartScreen(),
          );
        }
        if (settings.name == '/checkout') {
          return MaterialPageRoute(
            builder: (context) => const CheckoutScreen(),
          );
        }
        if (settings.name == '/catalog') {
          return MaterialPageRoute(
            builder: (context) => CatalogScreen(
              category: settings.arguments as String,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const CategoriesScreen(),
          );
        }
      },
    );
  }
}
