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
        id: json['id'] ?? 'NULL',
        name: json['name'] ?? 'NULL',
        pictureId: json['pictureId'] ?? 'NULL',
        city: json['city'] ?? 'NULL');
  }
}
