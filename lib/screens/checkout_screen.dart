import 'package:ecommerce_demo/app_bloc.dart';
import 'package:ecommerce_demo/widgets/cart_summary.dart';
import 'package:ecommerce_demo/widgets/observer_builder.dart';
import 'package:ecommerce_demo/widgets/single_cart_item.dart';
import 'package:flutter/material.dart';

/// Pagina di checkout del carrello.
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = AppBLoC.of(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ObserverBuilder(
              observable: cart,
              builder: (context, currentCart, _) {
                if (currentCart.products.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 64,
                        color: Theme.of(context).disabledColor,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Il carrello è vuoto',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text('Aggiungi prodotti al carrello'),
                    ],
                  );
                }

                final products = currentCart.products.toSet().toList();

                return ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final quantity = currentCart.quantityOf(product);

                    return SingleCartItem(
                      product: product,
                      quantity: quantity,
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          const CartSummary(),
        ],
      ),
    );
  }
}
