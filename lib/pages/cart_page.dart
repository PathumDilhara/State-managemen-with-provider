import 'package:f25_shopping_app_provider_package/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart Page",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder:
            (BuildContext context, CartProvider cartProvider, Widget? child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    // Current index of list of item values i.e CartModel object item builder like loop
                    final CartItemModel cartItemModel =
                        cartProvider.items.values.toList()[index];

                    return Container(
                      color: Colors.orange.withOpacity(0.5),
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(cartItemModel.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItemModel.id),
                            Text(
                                "\$ ${cartItemModel.price} x ${cartItemModel.quantity}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartProvider.removeSingleItem(cartItemModel.id);
                                _customSnackBar(
                                    context,
                                    cartItemModel.quantity ==
                                            1 // obj.attributes
                                        ? "Removed from cart !"
                                        : "One Item Removed");
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            IconButton(
                              onPressed: () {
                                cartProvider.removeItem(
                                    cartItemModel.id); // id of an one obj
                                _customSnackBar(context, "Removed from cart !");
                              },
                              icon: const Icon(Icons.remove_shopping_cart),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Total : \$${cartProvider.totalAMount.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(onPressed: (){
                  cartProvider.clearAll();
                  _customSnackBar(context, "Cart cleared !");
                }, child: const Text("Clear Cart")),
              )
            ],
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
