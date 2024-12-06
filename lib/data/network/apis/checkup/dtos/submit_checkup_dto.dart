class SubmitCheckupDto {
  int checkupId;
  List<Map<String, dynamic>> infractions;
  List<Map<String, dynamic>> custom_infractions;
  List<String> deleted_evidence_files;
  String? notes;
  DateTime? duedate;
  String action_taken;

  SubmitCheckupDto({
    required this.checkupId,
    required this.infractions,
    required this.custom_infractions,
    required this.deleted_evidence_files,
    required this.action_taken,
    this.notes,
    this.duedate,
  });

  Map<String, dynamic> toJson() => {
    "infractions": infractions,
    "custom_infractions": custom_infractions,
    "deleted_evidence_files": deleted_evidence_files,
    "notes": notes,
    "action_taken": action_taken,
    "duedate": duedate?.toIso8601String(),
  };
}