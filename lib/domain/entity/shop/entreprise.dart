import 'dart:io';

import 'package:complaintsapp/domain/entity/checkup/picture.dart';
import 'package:complaintsapp/domain/entity/location/moughataa.dart';
import 'package:complaintsapp/domain/entity/shop/merchant.dart';
import 'package:complaintsapp/domain/entity/user/user.dart';

class Entreprise {
  int? id;
  String? code;
  String? name;
  String? name_ar;
  int? moughataa_id;
  int? owner_id;
  String? contact_number;
  String? status;
  String? type;
  String? registeredon;
  int? agent_id;
  double? lat;
  double? lon;
  String? rg;
  String? notes;
  String? address;
  String? neighbourhood;
  String? agentname;
  Picture? picture;
  Moughataa? moughataa;
  Merchant? owner;
  User? agent;
  File? picture_file;

  Entreprise({
    this.id,
    this.code,
    this.name,
    this.contact_number,
    this.name_ar,
    this.moughataa_id,
    this.owner_id,
    this.status,
    this.type,
    this.registeredon,
    this.agent_id,
    this.lat,
    this.lon,
    this.rg,
    this.notes,
    this.address,
    this.neighbourhood,
    this.picture,
    this.agentname,
    this.moughataa,
    this.owner,
    this.agent,
    this.picture_file,
  });

  factory Entreprise.fromMap(Map<String, dynamic> json) => Entreprise(
    id: json['id'],
    code: json['code'],
    name: json['name'],
    contact_number: json['contact_number'],
    name_ar: json['name_ar'],
    moughataa_id: json['moughataa_id'],
    owner_id: json['owner_id'],
    status: json['status'],
    type: json['type'],
    registeredon: json['registeredon'],
    agent_id: json['agent_id'],
    lat: double.parse(json['lat']),
    lon: double.parse(json['lon']),
    rg: json['rg'],
    notes: json['notes'],
    address: json['address'],
    picture: json['picture'] != null ? Picture.fromMap(json['picture']) : null,
    neighbourhood: json['neighbourhood'],
    agentname: json['agentname'],
    moughataa: json['moughataa'] != null ? Moughataa.fromMap(json['moughataa']) : null,
    owner: json['owner'] != null ? Merchant.fromMap(json['owner']) : null,
    agent: json['agent'] != null ? User.fromJson(json['agent']) : null,
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "name": name,
    "contact_number": contact_number,
    "name_ar": name_ar,
    "moughataa_id": moughataa_id,
    "owner_id": owner_id,
    "status": status,
    "type": type,
    "registeredon": registeredon,
    "agent_id": agent_id,
    "lat": lat,
    "lon": lon,
    "rg": rg,
    "notes": notes,
    "address": address,
    "neighbourhood": neighbourhood,
    "agentname": agentname,
  };
}

class EntrepriseList {
  final List<Entreprise>? entreprises;

  EntrepriseList({
    this.entreprises,
  });

  factory EntrepriseList.fromJson(List<dynamic> json) {
    List<Entreprise> entreprises = <Entreprise>[];
    entreprises = json.map((entreprise) => Entreprise.fromMap(entreprise)).toList();

    return EntrepriseList(
      entreprises: entreprises,
    );
  }
}
