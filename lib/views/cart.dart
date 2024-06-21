import 'package:flutter/material.dart';
import 'package:app_delivery/services/firebase_connect.dart';
import 'package:app_delivery/components/my_foodCard.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, String>> cartItems;
  final Function(Map<String, String>) onRemove;

  const CartPage({
    required this.cartItems,
    required this.onRemove,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, String>> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = List.from(widget.cartItems);
  }

  Future<void> _finalizePurchase(BuildContext context) async {
    await finalizePurchase(_cartItems);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Compra finalizada com sucesso!')),
    );

    setState(() {
      _cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.redAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _cartItems.length,
                          itemBuilder: (context, index) {
                            final item = _cartItems[index];
                            return FoodCard(
                              name: item['name'] ?? '',
                              description: item['description'] ?? '',
                              imageUrl: item['imageUrl'] ?? '',
                              price: item['price'] ?? '',
                              isFavorite: false,
                              onRemove: () async {
                                await removeCart(item);
                                widget.onRemove(item);

                                setState(() {
                                  _cartItems.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Center(
              child: ElevatedButton(
                onPressed: () => _finalizePurchase(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fixedSize: Size(190, 40),
                ),
                child: Text(
                  'Finalizar Compra',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}