import 'package:flutter/material.dart';
import 'package:responsi_124220140/model/detail_restaurant.dart';
import 'package:responsi_124220140/service/api_service.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final String id;
  final Function(DetailRestaurant) onFavoriteToggle;
  final bool isFavorite;

  const DetailRestaurantScreen({
    super.key,
    required this.id,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  ApiService apiService = ApiService();
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite(DetailRestaurant detailRestaurant) {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteToggle(detailRestaurant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DetailRestaurant>(
        future: apiService.fetchDetailRestaurant(
            'https://restaurant-api.dicoding.dev/detail/${widget.id}'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final detailRestaurant = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/${detailRestaurant.pictureId}',
                        width: 80,
                        fit: BoxFit.cover),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        detailRestaurant.name,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          _toggleFavorite(detailRestaurant);
                        },
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 38,
                        ),
                      )
                    ],
                  ),
                  Text(
                    detailRestaurant.address,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    detailRestaurant.city,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(detailRestaurant.desc),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
