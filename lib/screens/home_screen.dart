import 'package:ecommerce_demo/data/mock.dart';
import 'package:ecommerce_demo/screens/product_detail_screen.dart';
import 'package:ecommerce_demo/widgets/cart_badge.dart';
import 'package:ecommerce_demo/widgets/product_preview.dart';
import 'package:flutter/material.dart';

/// Home dell'ecommerce.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce'),
        centerTitle: false,
        actions: const [
          CartBadge(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cerca',
                contentPadding: const EdgeInsets.only(left: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: 16,
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    product: productList[index],
                  ),
                ),
              );
            },
            child: ProductPreview(
              product: productList[index],
            ),
          );
        },
      ),
    );
  }
}
