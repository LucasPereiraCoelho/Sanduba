import 'package:app_delivery/components/my_BottomNavigation.dart';
import 'package:app_delivery/components/my_appBar.dart';
import 'package:app_delivery/services/firebase_connect.dart';
import 'package:app_delivery/views/cart.dart';
import 'package:app_delivery/views/feedback.dart';
import 'package:app_delivery/views/home_content.dart';
import 'package:app_delivery/views/user.dart';
import 'package:app_delivery/views/wishlist_page.dart.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _foodItems = [
    {
      'name': 'Coca-Cola',
      'description': 'Refrigerante de Cola 350ml',
      'imageUrl': 'https://via.placeholder.com/150',
      'price': 'R\$ 5,00'
    },
    {
      'name': 'Hambúrguer',
      'description': 'Hambúrguer artesanal com queijo e bacon',
      'imageUrl': 'https://via.placeholder.com/150',
      'price': 'R\$ 15,00'
    },
    {
      'name': 'Sorvete',
      'description': 'Sorvete de chocolate 500ml',
      'imageUrl': 'https://via.placeholder.com/150',
      'price': 'R\$ 10,00'
    },
    {
      'name': 'Pizza',
      'description': 'Pizza de mussarela',
      'imageUrl': 'https://via.placeholder.com/150',
      'price': 'R\$ 25,00'
    },
    {
      'name': 'Suco de Laranja',
      'description': 'Suco de laranja natural 500ml',
      'imageUrl': 'https://via.placeholder.com/150',
      'price': 'R\$ 7,00'
    },
  ];

  List<Map<String, String>> _favoriteItems = [];
  List<Map<String, String>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favoriteItems = await getFavorites();
    setState(() {});
  }

  void _toggleFavorite(Map<String, String> foodItem) async {
    setState(() {
      if (_favoriteItems.contains(foodItem)) {
        _favoriteItems.remove(foodItem);
        removeFromFavorites(foodItem);
      } else {
        _favoriteItems.add(foodItem);
        addToFavorites(foodItem);
      }
    });
  }

  void _addToCart(Map<String, String> foodItem) {
    setState(() {
      _cartItems.add(foodItem);
    });
  }

  void _removeFromCart(Map<String, String> foodItem) {
    setState(() {
      _cartItems.remove(foodItem);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 168, 168),
      appBar: MyAppBar(title: 'Sanduba'),
      body: _widgetOptions().elementAt(_selectedIndex),
      bottomNavigationBar: MyBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> _widgetOptions() => [
        HomeContent(
          foodItems: _foodItems,
          favoriteItems: _favoriteItems,
          onFavoriteToggle: _toggleFavorite,
          addToCart: _addToCart,
        ),
        WishlistPage(
          favoriteItems: _favoriteItems,
          onFavoriteToggle: _toggleFavorite,
        ),
        CartPage(
          cartItems: _cartItems,
          onRemove: _removeFromCart,
        ),
        FeedbackPage(),
        UpdateUser(),
      ];
}