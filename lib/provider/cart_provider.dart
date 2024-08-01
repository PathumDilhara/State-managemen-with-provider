import 'package:f25_shopping_app_provider_package/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  // inbuilt class ChangeNotifier
  // Cart item state
  Map<String, CartItemModel> _items = {}; // = {"id" : CartItem(...), ...}

  // getter for _items since it is private
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
      //print("Added existing data");
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
      //print("Added new data");
    }
    notifyListeners(); // Call the all registered listeners (Product Page, Cart Page, )
  }

  // Method to remove entire item using productId
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Method to decrease item count / single item remover
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItemModel(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // clear all in cart page
  void  clearAll(){
    _items = {};
    notifyListeners();
  }

  // calculate total in cart
  double get totalAMount{
    var total = 0.0;
    _items.forEach((key, cartItem){
      total += cartItem.price * cartItem.quantity;
    });

    notifyListeners();
    return total;
  }
}
