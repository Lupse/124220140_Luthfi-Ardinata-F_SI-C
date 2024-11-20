class DetailRestaurant {
  final String name;
  final String desc;
  final String pictureId;
  final String city;
  final String address;

  DetailRestaurant(
      {required this.address,
      required this.desc,
      required this.name,
      required this.pictureId,
      required this.city});

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) {
    return DetailRestaurant(
        desc: json['description'] ?? 'NULL',
        address: json['address'] ?? 'NULL',
        name: json['name'] ?? 'NULL',
        pictureId: json['pictureId'] ?? 'NULL',
        city: json['city'] ?? 'NULL');
  }
}
