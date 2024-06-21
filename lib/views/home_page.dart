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
  List<Map<String, String>> _foodItems = [];
  List<Map<String, String>> _favoriteItems = [];
  List<Map<String, String>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadFoodItems();
    _loadFavorites();
  }

  void _loadFoodItems() async {
    List<Map<String, dynamic>> items = await getItems();
    List<Map<String, String>> foodItems = items.map((item) => {
      'name': item['name'] as String,
      'description': item['description'] as String,
      'imageUrl': item['imageUrl'] as String,
      'price': item['price'] as String,
    }).toList();

    setState(() {
      _foodItems = foodItems;
    });
  }

  Future<void> _loadFavorites() async {
    List<Map<String, String>> favoriteItems = await getFavorites();
    setState(() {
      _favoriteItems = favoriteItems;
    });
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MyAppBar(title: 'Sanduba'),
          body: _widgetOptions().elementAt(_selectedIndex),
          bottomNavigationBar: MyBottomNavigation(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
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
