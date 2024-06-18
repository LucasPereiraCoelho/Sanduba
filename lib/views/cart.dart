import 'package:flutter/material.dart';


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
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return FoodCard(
            name: item['name'] ?? '',
            description: item['description'] ?? '',
            imageUrl: item['imageUrl'] ?? '',
            price: item['price'] ?? '',
            onRemove: () {
              onRemove(item);
            },
          );
        },
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String price;
  final VoidCallback onRemove;

  const FoodCard({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            SizedBox(height: 4.0),
            Text(
              price,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
