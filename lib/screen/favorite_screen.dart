import 'package:flutter/material.dart';
import 'package:responsi_124220140/model/detail_restaurant.dart';

class FavoriteScreen extends StatelessWidget {
  final List<DetailRestaurant> favorites;

  const FavoriteScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text('No favorites added yet'),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${favorite.pictureId}',
                        width: 80,
                        fit: BoxFit.cover),
                    title: Text(favorite.name),
                    subtitle: Text(favorite.city),
                  ),
                );
              },
            ),
    );
  }
}
