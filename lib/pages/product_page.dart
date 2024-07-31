import 'package:f25_shopping_app_provider_package/data/product_data.dart';
import 'package:f25_shopping_app_provider_package/models/product_model.dart';
import 'package:f25_shopping_app_provider_package/pages/cart_page.dart';
import 'package:f25_shopping_app_provider_package/pages/favourite_page.dart';
import 'package:f25_shopping_app_provider_package/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            child: Consumer<CartProvider>(   // Wrap the smallest widget
              // Consumer means what do the changes
              // Cart provider is already defined
              builder: (BuildContext context, CartProvider cartProvider,
                  Widget? child) {
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
                      // todo :fill this
                      const Text("0"),
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
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.addItems(
                            product.id,
                            product.price,
                            product.title,
                          );
                        },
                        icon: const Icon(Icons.shopping_cart),
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
}
