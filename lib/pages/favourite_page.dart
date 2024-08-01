import 'package:f25_shopping_app_provider_package/data/product_data.dart';
import 'package:f25_shopping_app_provider_package/models/product_model.dart';
import 'package:f25_shopping_app_provider_package/provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourite Page",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Consumer<FavouriteProvider>(
        builder: (BuildContext context, FavouriteProvider favouriteProvider,
            Widget? child) {
          // we need to pass a list to ListViewBuilder, so w get all entries from "favorites" getter
          // it is in key value pairs
          final favouriteItems = favouriteProvider.favourites.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList(); // entry means one key value pair

          if (favouriteItems.isEmpty) {
            return const Center(
              child: Text(
                "No favourite added yet",
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            itemCount: favouriteItems.length,
            itemBuilder: (context, index) {
              final productId = favouriteItems[
                  index]; //  contain productId, current index productId
              // get the first product that match to product id of current index
              final ProductModel productModel = ProductData()
                  .products
                  .firstWhere((product) => product.id == productId);

              return Card(
                child: ListTile(
                  title: Text(productModel.title),
                  subtitle: Text("\$${productModel.price}"),
                  trailing: IconButton(
                    onPressed: () {
                      favouriteProvider.toggleFavourites(productModel.id);
                      _customSnackBar(context, "Removed from favourite");
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _customSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
