import 'package:flutter/material.dart';

/// Widget che mostra la quantità di un prodotto nel carrello.
class ProductCartCounter extends StatelessWidget {
  const ProductCartCounter({
    super.key,
    required this.value,
  });

  /// Quantità del prodotto nel carrello.
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Row(
          children: [
            const Icon(Icons.shopping_cart_outlined,
                color: Colors.white, size: 10),
            const SizedBox(width: 3),
            Text(
              'x $value',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
