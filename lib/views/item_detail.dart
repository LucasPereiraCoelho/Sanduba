import 'package:flutter/material.dart';
import 'package:app_delivery/components/my_appBar.dart';
import 'package:app_delivery/views/cart.dart';

class FoodItemDetailsPage extends StatelessWidget {
  final Map<String, String> foodItem;
  final Function(Map<String, String>) addToCart;

  const FoodItemDetailsPage({
    required this.foodItem,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: foodItem['name'] ?? 'Detalhes'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              foodItem['imageUrl'] ?? '',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(foodItem['description'] ?? ''),
                  SizedBox(height: 16.0),
                  Text(foodItem['price'] ?? ''),
                  SizedBox(height: 16.0),
                  Text('Avaliações:'), 
                  SizedBox(height: 16.0),
                  Text('Localização:'), 
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      addToCart(foodItem);
                      Navigator.pop(context); 
                    },
                    child: Text('Adicionar ao Carrinho'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
