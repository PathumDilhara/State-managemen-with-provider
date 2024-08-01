import 'package:f25_shopping_app_provider_package/data/product_data.dart';
import 'package:f25_shopping_app_provider_package/models/product_model.dart';
import 'package:f25_shopping_app_provider_package/pages/cart_page.dart';
import 'package:f25_shopping_app_provider_package/pages/favourite_page.dart';
import 'package:f25_shopping_app_provider_package/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favourite_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Shop",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavouritePage(),
                  ));
            },
            backgroundColor: Colors.deepOrange,
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ));
            },
            backgroundColor: Colors.deepOrange,
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) {
          final ProductModel product = products[index];
          return Card(
            // child: Consumer<CartProvider>( // for single consumer
            child: Consumer2<CartProvider, FavouriteProvider>(
              // Wrap the smallest widget
              // Consumer means what do the changes
              // Cart provider is already defined
              builder: (BuildContext context, CartProvider cartProvider,
                  FavouriteProvider favouriteProvider, Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        cartProvider.items.containsKey(product.id)
                            ? cartProvider.items[product.id]!.quantity
                                .toString()
                            : "0",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // tileColor: Colors.orangeAccent,
                  subtitle: Text(
                    "\$ ${product.price.toString()}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          favouriteProvider.toggleFavourites(product.id);
                          _customSnackBar(
                              context,
                              favouriteProvider.isFavourite(product.id)
                                  ? "Added to favourite"
                                  : "Removed from favourite");
                        },
                        icon: Icon(
                          favouriteProvider.isFavourite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favouriteProvider.isFavourite(product.id)
                              ? Colors.pinkAccent
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.addItems(
                            product.id,
                            product.price,
                            product.title,
                          );
                          // Snack bar for display
                          _customSnackBar(context, "Item added to cart");
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: cartProvider.items.containsKey(product.id)
                              ? Colors.deepOrange
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
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
          style: TextStyle(fontSize: 18),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
