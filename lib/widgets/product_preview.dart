import 'package:ecommerce_demo/app_bloc.dart';
import 'package:ecommerce_demo/data/models.dart';
import 'package:ecommerce_demo/widgets/cached_image.dart';
import 'package:ecommerce_demo/widgets/observer_builder.dart';
import 'package:ecommerce_demo/widgets/product_cart_counter.dart';
import 'package:flutter/material.dart';

/// Widget che mostra una preview di un prodotto.
class ProductPreview extends StatelessWidget {
  const ProductPreview({
    super.key,
    required this.product,
  });

  /// Il prodotto da visualizzare.
  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = AppBLoC.of(context).cart;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 150,
            child: Hero(
              tag: 'image-${product.id}',
              transitionOnUserGestures: true,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: CachedImage(
                  imageUrl: product.imageUrl,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'name-${product.id}',
                      transitionOnUserGestures: true,
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Hero(
                      tag: 'description-${product.id}',
                      transitionOnUserGestures: true,
                      child: Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ObserverBuilder(
                      observable: cart,
                      builder: (context, currentCart, _) {
                        if (currentCart.hasProduct(product)) {
                          return ProductCartCounter(
                            value: currentCart.quantityOf(product),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 8),
                    Hero(
                      tag: 'price-${product.id}',
                      transitionOnUserGestures: true,
                      child: Text(
                        '€ ${product.price},00',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
