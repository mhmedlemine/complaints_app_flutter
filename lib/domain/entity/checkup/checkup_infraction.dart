import 'package:complaintsapp/domain/entity/checkup/picture.dart';
import 'package:complaintsapp/domain/entity/complaint/infraction.dart';
import 'package:complaintsapp/domain/entity/user/user.dart';

class CheckupInfraction {
  int? id;
  int? infraction_id;
  String? custom_infraction_text;
  String? notes;
  String? status;         // 'pending', 'confirmed', 'rejected'
  PictureList? evidence_files;
  Infraction? infraction;

  CheckupInfraction({
    this.id,
    this.infraction_id,
    this.custom_infraction_text,
    this.notes,
    this.status,
    this.evidence_files,
    this.infraction,
  });

  factory CheckupInfraction.fromMap(Map<String, dynamic> json) => CheckupInfraction(
    id: json['id'],
    infraction_id: json['infraction_id'],
    custom_infraction_text: json['custom_infraction_text'],
    notes: json['notes'],
    status: json['status'],
    evidence_files: json['evidence_files'] != null ? PictureList.fromJson(json['evidence_files']) : null,
    infraction: json['infraction'] != null ? Infraction.fromMap(json['infraction']) : null,
  );

  Map<String, dynamic> toMap() => {
    "custom_infraction_text": custom_infraction_text,
    "notes": notes,
  };
}

class CheckupInfractionList {
  final List<CheckupInfraction>? checkup_infractions;

  CheckupInfractionList({
    this.checkup_infractions,
  });

  factory CheckupInfractionList.fromJson(List<dynamic> json) {
    List<CheckupInfraction> checkup_infractions = <CheckupInfraction>[];
    checkup_infractions = json.map((checkup_infraction) => CheckupInfraction.fromMap(checkup_infraction)).toList();

    return CheckupInfractionList(
      checkup_infractions: checkup_infractions,
    );
  }
}
