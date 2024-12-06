class StartCheckupDto {
  int? complaint_id;
  String type;
  double lat;
  double lon;

  StartCheckupDto({
    this.complaint_id,
    required this.type,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toJson() => {
    //"complaint_id": complaint_id,
    "type": type,
    "lat": lat,
    "lon": lon,
  };
}