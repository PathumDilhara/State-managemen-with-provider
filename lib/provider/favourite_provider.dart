import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  // State
  final Map<String, bool> _favourites = {};

  // Getter
  Map<String, bool> get favourites => _favourites;

  // toggle favourites
  void toggleFavourites(String productId) {
    if (_favourites.containsKey(productId)) {
      _favourites[productId] = !_favourites[
          productId]!; // if tree then false, if false then true / non nullable
    } else {
      _favourites[productId] = true;
    }
    notifyListeners();
  }

  // Method to check whether a fav  or not
  bool isFavourite(String productId) {
    return _favourites[productId] ??
        false; // if there is a productId true other wise false
  }
}
