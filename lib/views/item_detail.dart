import 'package:flutter/material.dart';
import 'package:app_delivery/services/firebase_connect.dart';
import 'package:app_delivery/components/my_appBar.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, String> foodItem;
  final Function(Map<String, String>) addToCart;

  const DetailsPage({
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
                  Text('Descrição: ${foodItem['description'] ?? ''}'),
                  SizedBox(height: 16.0),
                  Text('Preço: R\$ ${foodItem['price'] ?? ''}'),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: () async {
                      await addToCart(foodItem);
                      addCart(foodItem);
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
