import 'package:flutter/material.dart';
import 'package:app_delivery/components/my_appBar.dart';
import 'package:app_delivery/views/cart.dart';

class FoodItemDetailsPage extends StatelessWidget {
  final Map<String, String> foodItem;

  const FoodItemDetailsPage({required this.foodItem});

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
                  Text('Avaliações:'), // Adicione a seção de avaliações aqui
                  SizedBox(height: 16.0),
                  Text('Localização:'), // Adicione a seção de localização aqui
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            cartItems: [foodItem], // Passando o item para o carrinho
                          ),
                        ),
                      );
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
