import 'package:f25_shopping_app_provider_package/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier { // from language,
  // Cart item state
  Map<String, CartItemModel> _items = {}; // = {"id" : CartItem(...), ...}

  // getter for _items
  Map<String, CartItemModel> get items {
    return {..._items}; // spread operator return all items each by each
  }

  // add item
  // if there exist the item that we are going to add it will be updated using id of the product
  // else we create new one
  void addItems(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        // Overwrite the existing item by same one increasing the quantity
        productId,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
      print("Added existing data");
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItemModel(
          id: productId,
          title: title,
          price: price,
          quantity: 1, // 1 :Since first time we add this to list
        ),
      );
      print("Added new data");
    }
    notifyListeners(); // Call the all registered listeners (Product Page, Cart Page, )
  }
}