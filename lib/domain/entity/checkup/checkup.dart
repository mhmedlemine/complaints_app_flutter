import 'package:complaintsapp/domain/entity/checkup/checkup_infraction.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/entity/user/user.dart';

class Checkup {
  int? id;
  String? code;
  int? agent_id;
  int? entreprise_id;
  int? complaint_id;
  DateTime? started_at;
  DateTime? completed_at;
  DateTime? canceled_at;
  String? type; // 'regular', 'complaint'
  String? status; // 'pending', 'in_progress', 'clean', 'with_infractions', 'canceled_at'
  String? investigation_result; // 'all_confirmed', 'all_false', 'partially_confirmed'
  String? action_taken; // 'none', 'closed', 'summon_issued'
  String? notes;
  User? agent;
  Entreprise? entreprise;
  Complaint? complaint;
  Summon? summon;
  CheckupInfractionList? checkupInfractions;

  Checkup({
    this.id,
    this.code,
    this.agent_id,
    this.entreprise_id,
    this.complaint_id,
    this.started_at,
    this.completed_at,
    this.canceled_at,
    this.type,
    this.status,
    this.investigation_result,
    this.action_taken,
    this.notes,
    this.agent,
    this.entreprise,
    this.complaint,
    this.summon,
    this.checkupInfractions,
  });

  factory Checkup.fromMap(Map<String, dynamic> json) => Checkup(
    id: json['id'],
    code: json['code'],
    agent_id: json['agent_id'],
    entreprise_id: json['entreprise_id'],
    complaint_id: json['complaint_id'],
    started_at: json['started_at'] != null ? DateTime.parse(json['started_at']) : null,
    completed_at: json['completed_at'] != null ? DateTime.parse(json['completed_at']) : null,
    canceled_at: json['canceled_at'] != null ? DateTime.parse(json['canceled_at']) : null,
    type: json['type'],
    status: json['status'],
    investigation_result: json['investigation_result'],
    action_taken: json['action_taken'],
    notes: json['notes'],
    agent: json['agent'] != null ? User.fromJson(json['agent']) : null,
    entreprise: json['entreprise'] != null ? Entreprise.fromMap(json['entreprise']) : null,
    complaint: json['complaint'] != null ? Complaint.fromMap(json['complaint']) : null,
    summon: json['summon'] != null ? Summon.fromMap(json['summon']) : null,
    checkupInfractions: json['checkup_infractions'] != null ? CheckupInfractionList.fromJson(json['checkup_infractions']) : null,
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "agent_id": agent_id,
    "entreprise_id": entreprise_id,
    "complaint_id": complaint_id,
    "started_at": started_at,
    "completed_at": completed_at,
    "type": type,
    "status": status,
    "action_taken": action_taken,
    "notes": notes,
  };
}

class CheckupList {
  final List<Checkup>? checkups;

  CheckupList({
    this.checkups,
  });

  factory CheckupList.fromJson(List<dynamic> json) {
    List<Checkup> checkups = <Checkup>[];
    checkups = json.map((checkup) => Checkup.fromMap(checkup)).toList();

    return CheckupList(
      checkups: checkups,
    );
  }
}
