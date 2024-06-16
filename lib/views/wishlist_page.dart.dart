import 'package:flutter/material.dart';
import 'package:app_delivery/components/my_appBar.dart';
import 'package:app_delivery/components/my_BottomNavigation.dart';

class WishlistPage extends StatelessWidget {
  final List<Map<String, String>> favoriteItems;
  final Function(Map<String, String>) onFavoriteToggle;

  const WishlistPage({
    required this.favoriteItems,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return FoodCard(
            name: item['name']!,
            description: item['description']!,
            imageUrl: item['imageUrl']!,
            price: item['price']!,
            isFavorite: true,
            onFavoriteToggle: () => onFavoriteToggle(item),
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
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const FoodCard({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
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
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
