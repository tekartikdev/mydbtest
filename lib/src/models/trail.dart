class Trail {
  final String name;
  final double distance;
  final String difficulty;

  Trail({this.name = 'noname', this.difficulty = 'nodif', this.distance = 0});

  factory Trail.fromJson(Map<dynamic, dynamic> json) {
    return Trail(
        name: json['name'],
        difficulty: json['difficulty'],
        distance: json['distance']);
  }
}
