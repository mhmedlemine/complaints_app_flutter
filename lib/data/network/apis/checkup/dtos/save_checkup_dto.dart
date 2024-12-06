class SaveCheckupDto {
  int checkupId;
  List<Map<String, dynamic>> infractions;
  List<Map<String, dynamic>> custom_infractions;
  List<String> deleted_evidence_files;
  String? notes;

  SaveCheckupDto({
    required this.checkupId,
    required this.infractions,
    required this.custom_infractions,
    required this.deleted_evidence_files,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
    "infractions": infractions,
    "custom_infractions": custom_infractions,
    "deleted_evidence_files": deleted_evidence_files,
    "notes": notes,
  };
}