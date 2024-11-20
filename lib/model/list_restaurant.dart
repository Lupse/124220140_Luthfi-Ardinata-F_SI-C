class ListRestaurant {
  final String id;
  final String name;
  final String pictureId;
  final String city;

  ListRestaurant(
      {required this.id,
      required this.name,
      required this.pictureId,
      required this.city});

  factory ListRestaurant.fromJson(Map<String, dynamic> json) {
    return ListRestaurant(
        id: json['id'] as String,
        name: json['name'] as String,
        pictureId: json['picture_id'] as String,
        city: json['city'] as String);
  }
}
