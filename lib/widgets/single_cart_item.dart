import 'package:ecommerce_demo/app_bloc.dart';
import 'package:ecommerce_demo/data/models.dart';
import 'package:ecommerce_demo/widgets/cached_image.dart';
import 'package:flutter/material.dart';

/// Widget che mostra un singolo prodotto nel carrello.
class SingleCartItem extends StatelessWidget {
  const SingleCartItem({
    super.key,
    required this.product,
    required this.quantity,
  });

  /// Il prodotto da visualizzare.
  final Product product;

  /// La quantità del prodotto nel carrello.
  final int quantity;

  /// Mostra il menu di opzioni per il prodotto.
  void _showMenuItem(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final left = offset.dx + renderBox.size.width;
    final top = offset.dy + renderBox.size.height;

    showMenu(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(
          child: const Text('Rimuovi'),
          onTap: () {
            AppBLoC.of(context).cart - product;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showMenuItem(context),
      leading: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedImage(
            imageUrl: product.imageUrl,
          ),
        ),
      ),
      title: Text(product.name),
      subtitle: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${quantity}x',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      trailing: Text(
        '€ ${product.price * quantity},00',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
