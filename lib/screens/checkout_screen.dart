import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../main.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CardFieldInputDetails? _card;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Checkout', style: textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Insert your card details',
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              CardFormField(
                onCardChanged: (card) {
                  setState(() {
                    _card = card;
                  });
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
                onPressed: loading ? null : () => handlePayment(),
                child: const Text('Pay Now'),
              ),
            )
          ],
        ),
      ),
    );
  }

  handlePayment() async {
    if (_card?.complete != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in your card details'),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await processPayment();
    } catch (err) {
      throw Exception(err.toString());
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  processPayment() async {
    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(),
      ),
    );

    final response = await paymentClient.processPayment(
      paymentMethodId: paymentMethod.id,
      items: cart.cartItems.map((cartItem) => cartItem.toJson()).toList(),
    );

    print(response);
    if (response['requiresAction'] == true &&
        response['clientSecret'] != null) {
      // final paymentIntent =
      //     await Stripe.instance.handleNextAction(response['clientSecret']);

      // print(paymentIntent);
      // if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
      // final response = await paymentClient.confirmPayment(
      //   paymentIntentId: paymentIntent.id,
      // );

      // print(response);
      // }
    }
  }
}
