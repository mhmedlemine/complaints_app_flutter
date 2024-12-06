class LocationParams {
  final double lat;
  final double lon;

  LocationParams({
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toJson() => {
    "lat": this.lat,
    "lon": this.lon,
  };
}
