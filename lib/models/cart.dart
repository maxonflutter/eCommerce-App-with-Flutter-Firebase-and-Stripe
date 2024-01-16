import 'package:equatable/equatable.dart';

import 'cart_item.dart';

class Cart extends Equatable {
  final String userId;
  final List<CartItem> cartItems;

  const Cart({
    required this.userId,
    required this.cartItems,
  });

  Cart copyWith({
    String? userId,
    List<CartItem>? cartItems,
  }) {
    return Cart(
      userId: userId ?? this.userId,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  int get totalQuantity =>
      cartItems.fold(0, (total, item) => total + item.quantity);

  double get totalPrice =>
      cartItems.fold(0, (total, item) => total + item.subtotal);

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'cartItems': cartItems.map((item) => item.toJson()).toList(),
      };

  @override
  List<Object> get props => [userId, cartItems];
}
