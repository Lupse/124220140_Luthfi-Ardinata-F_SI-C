import 'package:http/http.dart' as http;
import 'package:responsi_124220140/model/detail_restaurant.dart';
import 'dart:convert';

import 'package:responsi_124220140/model/list_restaurant.dart';

class ApiService {
  final String restaurantUrl = 'https://restaurant-api.dicoding.dev/list';

  Future<List<ListRestaurant>> fetchRestaurant() async {
    try {
      final response = await http.get(Uri.parse(restaurantUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> restaurants = data['restaurants'];
        return restaurants
            .map((item) => ListRestaurant.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load Restaurant');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<DetailRestaurant> fetchDetailRestaurant(
      String restaurantDetailUrl) async {
    try {
      final response = await http.get(Uri.parse(restaurantDetailUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Map<String, dynamic> restaurant = data['restaurant'];
        return DetailRestaurant.fromJson(restaurant);
      } else {
        throw Exception('Failed to load restaurant details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
