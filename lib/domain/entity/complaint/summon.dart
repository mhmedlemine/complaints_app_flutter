import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/entity/complaint/infraction.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/entity/user/user.dart';

class Summon {
  int? id;
  String? code;
  String? status;
  String? action;
  DateTime? dueDate;
  DateTime? filledOn;
  int? agentId;
  User? agent;
  int? entrepriseId;
  Entreprise? entreprise;
  int? checkupId;
  Checkup? checkup;

  Summon({
    this.id,
    this.code,
    this.action,
    this.status,
    this.filledOn,
    this.dueDate,
    this.agentId,
    this.agent,
    this.entrepriseId,
    this.entreprise,
    this.checkupId,
    this.checkup,
  });

  factory Summon.fromMap(Map<String, dynamic> json) => Summon(
    id: json['id'],
    code: json['code'],
    action: json['action'],
    status: json['status'],
    dueDate: json['duedate'] != null ? DateTime.parse(json['duedate']) : null,
    filledOn: json['filledon'] != null ? DateTime.parse(json['filledon']) : null,
    agentId: json['agent_id'],
    agent: json['agent'] != null ? User.fromJson(json['agent']) : null,
    entrepriseId: json['entreprise_id'],
    entreprise: json['entreprise'] != null ? Entreprise.fromMap(json['entreprise']) : null,
    checkupId: json['checkup_id'],
    checkup: json['checkup'] != null ? Checkup.fromMap(json['checkup']) : null,
  );

  Map<String, dynamic> toMap() => {};
}

class SummonList {
  final List<Summon>? summons;

  SummonList({
    this.summons,
  });

  factory SummonList.fromJson(List<dynamic> json) {
    List<Summon> summons = <Summon>[];
    summons = json.map((summon) => Summon.fromMap(summon)).toList();

    return SummonList(
      summons: summons,
    );
  }
}
