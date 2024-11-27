class City {
  final String name;
  final String countryCode;
  final double latitude;
  final double longitude;

  City({
    required this.name,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
  });
}

final List<City> cities = [
  City(name: "Dallol", countryCode: "NG", latitude: 14.1043, longitude: 40.3188),
  City(name: "Fairbanks", countryCode: "US", latitude: 64.8378, longitude: -147.7164),
  City(name: "Londres", countryCode: "GB", latitude: 51.5072, longitude: -0.1275),
  City(name: "Recife", countryCode: "BR", latitude: -8.0476, longitude: -34.8770),
  City(name: "Vancouver", countryCode: "CA", latitude: 49.2827, longitude: -123.1207),
  City(name: "Yakutsk", countryCode: "RU", latitude: 62.0355, longitude: 129.6755),
];