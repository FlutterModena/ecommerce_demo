import 'package:ecommerce_demo/app_bloc.dart';
import 'package:ecommerce_demo/data/models.dart';
import 'package:ecommerce_demo/widgets/cached_image.dart';
import 'package:ecommerce_demo/widgets/detail_section_title.dart';
import 'package:ecommerce_demo/widgets/observer_builder.dart';
import 'package:flutter/material.dart';

/// Pagina del dettaglio di un prodotto.
/// Da qui è possibile aggiungere il prodotto al carrello.
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  /// Il prodotto da visualizzare.
  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = AppBLoC.of(context).cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettaglio'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: 'image-${product.id}',
              transitionOnUserGestures: true,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(0),
                ),
                child: CachedImage(
                  imageUrl: product.imageUrl,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DetailSectionTitle(title: 'Nome'),
                    Hero(
                      tag: 'name-${product.id}',
                      transitionOnUserGestures: true,
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const DetailSectionTitle(title: 'Descrizione'),
                    Hero(
                      tag: 'description-${product.id}',
                      transitionOnUserGestures: true,
                      child: Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const DetailSectionTitle(
                              title: 'Prezzo',
                              fontSize: 12,
                            ),
                            Hero(
                              tag: 'price-${product.id}',
                              transitionOnUserGestures: true,
                              child: Text(
                                '€ ${product.price},00',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart_outlined),
                      const SizedBox(width: 4),
                      ObserverBuilder(
                        observable: cart,
                        builder: (context, currentCart, _) {
                          final quantity = currentCart.quantityOf(product);
                          return Text('$quantity');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    final cart = AppBLoC.of(context).cart;
                    cart + product;
                  },
                  child: const Text('AGGIUNGI AL CARRELLO'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
