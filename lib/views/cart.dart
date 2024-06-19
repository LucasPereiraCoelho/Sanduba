import 'package:app_delivery/services/firebase_connect.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery/components/my_foodCard.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, String>> cartItems;
  final Function(Map<String, String>) onRemove;

  const CartPage({
    required this.cartItems,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 168, 168),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return FoodCard(
            name: item['name'] ?? '',
            description: item['description'] ?? '',
            imageUrl: item['imageUrl'] ?? '',
            price: item['price'] ?? '',
            isFavorite: false,  
            onRemove: () async {
              await removeCart(item);
              onRemove(item);
            },
          );
        },
      ),
    );
  }
}