import 'package:flutter/material.dart';
import 'package:responsi_124220140/auth/login.dart';
import 'package:responsi_124220140/model/detail_restaurant.dart';
import 'package:responsi_124220140/model/list_restaurant.dart';
import 'package:responsi_124220140/screen/detailrestaurant.dart';
import 'package:responsi_124220140/screen/favorite_screen.dart';
import 'package:responsi_124220140/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  String? username;
  Set<DetailRestaurant> favorites = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void toggleFavorite(DetailRestaurant restaurant) {
    setState(() {
      if (favorites.contains(restaurant)) {
        favorites.remove(restaurant);
      } else {
        favorites.add(restaurant);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoriteScreen(favorites: favorites.toList()),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            clearData();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          icon: const Icon(Icons.logout),
        ),
        title: Text('Hai, ${username!}'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ListRestaurant>>(
        future: apiService.fetchRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final listRestaurants = snapshot.data!;
            return ListView.builder(
              itemCount: listRestaurants.length,
              itemBuilder: (context, index) {
                final listRestaurant = listRestaurants[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${listRestaurant.pictureId}',
                        width: 80,
                        fit: BoxFit.cover),
                    title: Text(listRestaurant.name),
                    subtitle: Text(listRestaurant.city),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailRestaurantScreen(
                            id: listRestaurant.id,
                            isFavorite: favorites.any((fav) =>
                                fav.name ==
                                listRestaurant.name), // Check favorit
                            onFavoriteToggle: toggleFavorite,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
