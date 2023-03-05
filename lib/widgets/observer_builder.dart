import 'package:ecommerce_demo/data/models.dart';
import 'package:flutter/material.dart';

/// Widget che permette di osservare un [Observable] e di aggiornare la UI.
class ObserverBuilder<T> extends StatelessWidget {
  const ObserverBuilder({
    super.key,
    required this.observable,
    required this.builder,
  });

  /// L'observable da osservare.
  final Observable<T> observable;

  /// La funzione che permette di costruire il widget.
  final Widget Function(BuildContext, T, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: observable,
      builder: builder,
    );
  }
}
