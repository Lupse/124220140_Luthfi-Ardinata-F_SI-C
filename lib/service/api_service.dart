import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:responsi_124220140/model/list_restaurant.dart';

class ApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev/list';

  Future<List<ListRestaurant>> fetchRestaurant() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> restaurants = data['restaurants'];
        return restaurants
            .map((item) => ListRestaurant.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
