import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/entity/user/user.dart';

class Complaint {
  int? id;
  String? code;
  String? title;
  String? description;
  String? greenNumber;
  int? consumer_id;
  int? receiving_agent_id;
  int? entreprise_id;
  DateTime? reported_at;
  String? priority; // 'low', 'medium', 'high'
  String? status; // 'pending', 'assigned', 'investigating', 'resolved'
  String? shop_address;
  bool? is_valid;
  DateTime? resolved_at;
  Consumer? consumer;
  User? receiver;
  Checkup? checkup;
  Entreprise? entreprise;

  Complaint({
    this.id,
    this.code,
    this.title,
    this.description,
    this.greenNumber,
    this.consumer_id,
    this.receiving_agent_id,
    this.entreprise_id,
    this.reported_at,
    this.priority,
    this.status,
    this.shop_address,
    this.is_valid,
    this.resolved_at,
    this.consumer,
    this.receiver,
    this.checkup,
    this.entreprise,
  });

  factory Complaint.fromMap(Map<String, dynamic> json) => Complaint(
        id: json['id'],
        code: json['code'],
        title: json['title'],
        description: json['description'],
        greenNumber: json['greenNumber'],
        consumer_id: json['consumer_id'],
        receiving_agent_id: json['receiving_agent_id'],
        entreprise_id: json['entreprise_id'],
        reported_at: json['reported_at'] != null ? DateTime.parse(json['reported_at']) : null,
        priority: json['priority'],
        status: json['status'],
        shop_address: json['shop_address'],
        is_valid: json['is_valid'],
        resolved_at: json['resolved_at'] != null ? DateTime.parse(json['resolved_at']) : null,
        checkup: json['checkup'] != null
            ? Checkup.fromMap(json['checkup'])
            : null,
        consumer: json['consumer'] != null
            ? Consumer.fromMap(json['consumer'])
            : null,
        receiver:
            json['receiver'] != null ? User.fromJson(json['receiver']) : null,
        entreprise: json['entreprise'] != null
            ? Entreprise.fromMap(json['entreprise'])
            : null,
      );

  Map<String, dynamic> toMap() => {
    "code": code,
    "title": title,
    "description": description,
    "greenNumber": greenNumber,
    "consumer_id": consumer_id,
    "receiving_agent_id": receiving_agent_id,
    "entreprise_id": entreprise_id,
    "reported_at": reported_at?.toIso8601String(),
    "priority": priority,
    "status": status,
    "shop_address": shop_address,
    "is_valid": is_valid,
    "resolved_at": resolved_at?.toIso8601String(),
  };
}

class ComplaintList {
  final List<Complaint>? complaints;

  ComplaintList({
    this.complaints,
  });

  factory ComplaintList.fromJson(List<dynamic> json) {
    List<Complaint> complaints = <Complaint>[];
    complaints = json.map((complaint) => Complaint.fromMap(complaint)).toList();

    return ComplaintList(
      complaints: complaints,
    );
  }
}
