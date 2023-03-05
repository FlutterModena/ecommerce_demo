import 'package:ecommerce_demo/app_bloc.dart';
import 'package:ecommerce_demo/data/models.dart';
import 'package:ecommerce_demo/screens/checkout_screen.dart';
import 'package:ecommerce_demo/widgets/observer_builder.dart';
import 'package:flutter/material.dart';

/// Widget che mostra il numero di prodotti con l'icon del carrello.
class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = AppBLoC.of(context).cart;

    return ObserverBuilder<Cart>(
      observable: cart,
      builder: (context, currentCart, _) {
        return IconButton(
          icon: Badge(
            isLabelVisible: currentCart.products.isNotEmpty,
            label: Text(
              currentCart.products.length.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            child: const Icon(
              Icons.shopping_cart,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CheckoutScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
