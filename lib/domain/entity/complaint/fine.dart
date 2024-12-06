import 'package:complaintsapp/domain/entity/user/user.dart';

class Fine {
  String? code;
  double? amount;
  String? filledon;
  String? filledby;
  String? status;
  String? duedate;
  String? paidon;
  User? filledBy;

  Fine({
    this.code,
    this.amount,
    this.filledon,
    this.filledby,
    this.status,
    this.duedate,
    this.paidon,
    this.filledBy,
  });

  factory Fine.fromMap(Map<String, dynamic> json) => Fine(
    code: json['code'],
    amount: json['amount']?.toDouble(),
    filledon: json['filledon'],
    filledby: json['filledby'],
    status: json['status'],
    duedate: json['duedate'],
    paidon: json['paidon'],
    filledBy: json['filledBy'] != null ? User.fromJson(json['filledBy']) : null,
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "amount": amount,
    "filledon": filledon,
    "filledby": filledby,
    "status": status,
    "duedate": duedate,
    "paidon": paidon,
  };
}


class FineList {
  final List<Fine>? fines;

  FineList({
    this.fines,
  });

  factory FineList.fromJson(List<dynamic> json) {
    List<Fine> fines = <Fine>[];
    fines = json.map((fine) => Fine.fromMap(fine)).toList();

    return FineList(
      fines: fines,
    );
  }
}