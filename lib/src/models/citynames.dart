class CityName {
  final String name;
  final String lang;
  final int cityposrowid;

  CityName({this.name = 'noname', this.lang = 'nolang', this.cityposrowid = 0});

  factory CityName.fromJson(Map<dynamic, dynamic> json) {
    return CityName(
        name: json['name'],
        lang: json['lang'],
        cityposrowid: json['cityposrowid']);
  }
}
