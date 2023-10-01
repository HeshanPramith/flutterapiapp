class Data {
  late final String title;
  late final String userName;
  late final String numViews;
  // late final String stages;
  // late final String boosters;
  // late final String firstFlight;
  // late final String company;
  // late final String description;
  late final String image;
  late final String badge;
  late final String date;

  Data({
    required this.title,
    required this.userName,
    required this.numViews,
    // required this.stages,
    // required this.boosters,
    // required this.firstFlight,
    // required this.company,
    // required this.description,
    required this.image,
    required this.badge,
    required this.date,
  });

  factory Data.fromJSON(Map<String, dynamic> data) {
    return Data(
      title: data['title'],
      userName: data['userName'] ?? '',
      numViews: data['numViews'].toString(),
      // stages: data['stages']?.toString() ?? '',
      // boosters: data['boosters']?.toString() ?? '',
      // firstFlight: data['first_flight']?.toString() ?? '',
      // company: data['company'] ?? '',
      // description: data['description'] ?? '',
      image: data['imageUrl']?.replaceAll("http://", "https://") ?? '',
      badge: data['badgeUrl']?.replaceAll("http://", "https://") ?? '',
      date: data['dateCreated'].toString(),
    );
  }
}
