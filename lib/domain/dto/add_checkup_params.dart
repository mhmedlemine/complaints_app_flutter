class AddCheckupParams {
  String code;
  int entreprise_id;
  String type;
  String status;
  String action_taken;
  String notes;
  DateTime duedate;
  List<Map<String, Object>> infractions;
  List<Map<String, String>> custom_infractions;

  AddCheckupParams({
    required this.code,
    required this.entreprise_id,
    required this.type,
    required this.status,
    required this.action_taken,
    required this.notes,
    required this.duedate,
    required this.infractions,
    required this.custom_infractions,
  });

  Map<String, dynamic> toJson() => {
    "code": code,
    "entreprise_id": entreprise_id,
    "type": type,
    "status": status,
    "action_taken": action_taken,
    "notes": notes,
    "duedate": duedate.toIso8601String(),
    "infractions": infractions,
    "custom_infractions": custom_infractions,
  };
  
}