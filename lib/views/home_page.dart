import 'package:flutter/material.dart';
import 'package:app_delivery/views/feedback.dart';
import 'package:app_delivery/views/wishlist_page.dart.dart';
import 'package:app_delivery/views/item_detail.dart';
import 'package:app_delivery/components/my_BottomNavigation.dart';
import 'package:app_delivery/components/my_appBar.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

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

  void _toggleFavorite(Map<String, String> foodItem) {
    setState(() {
      if (_favoriteItems.contains(foodItem)) {
        _favoriteItems.remove(foodItem);
      } else {
        _favoriteItems.add(foodItem);
      }
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
        ),
        WishlistPage(
          favoriteItems: _favoriteItems,
          onFavoriteToggle: _toggleFavorite, // Passando a função correta aqui
        ),
        Text('Cart Page Content'),
        FeedbackPage(),
        Text('User Page Content'),
      ];
}

class HomeContent extends StatelessWidget {
  final List<Map<String, String>> foodItems;
  final List<Map<String, String>> favoriteItems;
  final Function(Map<String, String>) onFavoriteToggle;

  const HomeContent({
    required this.foodItems,
    required this.favoriteItems,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CategoryButton(
                label: 'Bebida',
                isSelected: false,
                onTap: () {},
              ),
              CategoryButton(
                label: 'Lanches',
                isSelected: false,
                onTap: () {},
              ),
              CategoryButton(
                label: 'Sobremesa',
                isSelected: false,
                onTap: () {},
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              final item = foodItems[index];
              final isFavorite = favoriteItems.contains(item);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodItemDetailsPage(foodItem: item),
                    ),
                  );
                },
                child: FoodCard(
                  name: item['name']!,
                  description: item['description']!,
                  imageUrl: item['imageUrl']!,
                  price: item['price']!,
                  isFavorite: isFavorite,
                  onFavoriteToggle: () => onFavoriteToggle(item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isSelected ? Colors.red : Colors.grey[300],
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
