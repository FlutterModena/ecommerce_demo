import 'package:ecommerce_demo/data/models.dart';
import 'package:flutter/material.dart';

/// Widget che permette di accedere ai bloc dell'applicazione.
class AppBLoC extends InheritedWidget {
  /// Il carrello.
  final CartObservable cart;

  const AppBLoC({
    super.key,
    required this.cart,
    required super.child,
  });

  /// Restituisce l'istanza di [AppBLoC] più vicina.
  static AppBLoC of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppBLoC>()!;
  }

  @override
  bool updateShouldNotify(covariant AppBLoC oldWidget) => true;
}
