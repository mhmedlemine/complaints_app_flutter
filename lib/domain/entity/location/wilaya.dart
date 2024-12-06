class Wilaya {
  String? code;
  String? name;
  String? name_ar;
  String? lat;
  String? lon;
  
  Wilaya({
    this.code,
    this.name,
    this.name_ar,
    this.lat,
    this.lon,
  });

  factory Wilaya.fromMap(Map<String, dynamic> json) => Wilaya(
    code: json['code'],
    name: json['name'],
    name_ar: json['name_ar'],
    lat: json['lat'],
    lon: json['lon'],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "name": name,
    "name_ar": name_ar,
    "lat": lat,
    "lon": lon,
  };

}
