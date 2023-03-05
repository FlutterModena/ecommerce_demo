import 'package:flutter/material.dart';

/// Modello di un prodotto.
class Product {
  /// Id del prodotto.
  final int id;

  /// Nome del prodotto.
  final String name;

  /// Descrizione del prodotto.
  final String description;

  /// Prezzo del prodotto.
  final int price;

  /// Url dell'immagine del prodotto.
  final String imageUrl;

  /// Costruttore di default.
  /// Richiede un [id], un [name], una [description], un [price] e una [imageUrl].
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => Object.hash(id, name, description, price, imageUrl);
}

/// Modello di un carrello.
class Cart {
  /// Lista dei prodotti nel carrello.
  final List<Product> products = [];

  /// Controlla se il carrello contiene un prodotto.
  bool hasProduct(Product product) {
    return products.contains(product);
  }

  /// Restituisce la quantità di un prodotto nel carrello.
  int quantityOf(Product product) {
    var quantity = 0;
    for (var p in products) {
      if (p == product) {
        quantity++;
      }
    }
    return quantity;
  }

  /// Restituisce il prezzo totale del carrello.
  int get totalPrice {
    var total = 0;
    for (var product in products) {
      total += product.price;
    }
    return total;
  }

  /// Aggiunge un prodotto al carrello.
  operator +(Product product) {
    products.add(product);
  }

  /// Rimuove un prodotto dal carrello.
  operator -(Product product) {
    products.remove(product);
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart && other.products == products;
  }

  @override
  int get hashCode => products.hashCode;
}

/// Classe helper per gestire i [ValueNotifier].
class Observable<T> extends ValueNotifier<T> {
  /// Costruttore di default.
  /// Richiede un [T].
  Observable(T value) : super(value);
}

/// Classe helper per gestire il [Cart].
class CartObservable extends Observable<Cart> {
  /// Costruttore di default.
  /// Richiede un [Cart].
  CartObservable(Cart cart) : super(cart);

  void clear() {
    value = Cart();
    notifyListeners();
  }

  /// Aggiunge un prodotto al carrello.
  operator +(Product product) {
    value + product;
    notifyListeners();
  }

  /// Rimuove un prodotto dal carrello.
  operator -(Product product) {
    value - product;
    notifyListeners();
  }
}
