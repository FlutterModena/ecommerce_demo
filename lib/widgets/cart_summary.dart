import 'package:ecommerce_demo/app_bloc.dart';
import 'package:ecommerce_demo/widgets/observer_builder.dart';
import 'package:flutter/material.dart';

/// Mostra il totale del carrello.
class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  /// Esegue il checkout, svuotando il carrello e mostrando un messaggio.
  /// Torna alla schermata precedente dopo 300ms.
  void _doCheckout(BuildContext context) {
    AppBLoC.of(context).cart.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Grazie per aver acquistato!',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 300),
      () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = AppBLoC.of(context).cart;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 32,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Totale',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              ObserverBuilder(
                observable: cart,
                builder: (context, currentCart, _) {
                  return Text(
                    '€ ${currentCart.totalPrice},00',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.maxFinite,
            height: 48,
            child: ObserverBuilder(
              observable: cart,
              builder: (context, currentCart, _) {
                return ElevatedButton(
                  onPressed: currentCart.products.isEmpty
                      ? null
                      : () => _doCheckout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Conferma',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
