class Rocket {
  late final String name;
  late final String type;
  late final String active;
  late final String stages;
  late final String boosters;
  late final String firstFlight;
  late final String company;
  late final String description;
  late final String image;

  Rocket({
    required this.name,
    required this.type,
    required this.active,
    required this.stages,
    required this.boosters,
    required this.firstFlight,
    required this.company,
    required this.description,
    required this.image,
  });

  factory Rocket.fromJSON(Map<String, dynamic> data) {
    return Rocket(
      name: data['name'],
      type: data['type'] ?? '',
      active: data['active'].toString(),
      stages: data['stages']?.toString() ?? '',
      boosters: data['boosters']?.toString() ?? '',
      firstFlight: data['first_flight']?.toString() ?? '',
      company: data['company'] ?? '',
      description: data['description'] ?? '',
      image: data['flickr_images'] != null && data['flickr_images'].isNotEmpty
          ? data['flickr_images'][0]
          : '',
    );
  }
}
