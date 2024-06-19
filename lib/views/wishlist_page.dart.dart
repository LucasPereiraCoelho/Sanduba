import 'package:flutter/material.dart';
import 'package:app_delivery/components/my_foodCard.dart';


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
      backgroundColor: Color.fromARGB(255, 168, 168, 168),
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
