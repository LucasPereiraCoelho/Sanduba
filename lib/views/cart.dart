import 'package:flutter/material.dart';
import 'package:app_delivery/components/my_appBar.dart';
import 'package:app_delivery/components/my_BottomNavigation.dart';
import 'package:app_delivery/views/home_page.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, String>> cartItems;

  const CartPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Carrinho'),
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
              // Implemente a lógica para remover o item do carrinho
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
