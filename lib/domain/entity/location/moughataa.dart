import 'package:complaintsapp/domain/entity/location/wilaya.dart';

class Moughataa {
  int? id;
  String? code;
  String? name;
  String? name_ar;
  String? lat;
  String? lon;
  Wilaya? wilaya;
  
  Moughataa({
    this.id,
    this.code,
    this.name,
    this.name_ar,
    this.lat,
    this.lon,
    this.wilaya,
  });

  factory Moughataa.fromMap(Map<String, dynamic> json) => Moughataa(
    id: json['id'],
    code: json['code'],
    name: json['name'],
    name_ar: json['name_ar'],
    lat: json['lat'],
    lon: json['lon'],
    wilaya: json['wilaya'] != null ? Wilaya.fromMap(json['wilaya']) : null,
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "name": name,
    "name_ar": name_ar,
    "lat": lat,
    "lon": lon,
  };

}

class MoughataaList {
  final List<Moughataa>? moughataas;

  MoughataaList({
    this.moughataas,
  });

  factory MoughataaList.fromJson(List<dynamic> json) {
    List<Moughataa> moughataas = <Moughataa>[];
    moughataas = json.map((moughataa) => Moughataa.fromMap(moughataa)).toList();

    return MoughataaList(
      moughataas: moughataas,
    );
  }
}
