import 'package:complaintsapp/domain/entity/complaint/complaint.dart';

class SubmitComplaintDto {
  final Complaint complaint;
  final Map<int, bool> selectedInfractions;
  final Map<int, String> infractionNotes;
  final List<Map<String, dynamic>> customInfractions;

  SubmitComplaintDto({
    required this.complaint,
    required this.selectedInfractions,
    required this.infractionNotes,
    required this.customInfractions,
  });

  Map<String, dynamic> toJson() => {
    ...complaint.toMap(),
    'infractions': selectedInfractions.entries
        .where((e) => e.value)
        .map((e) => {
              'infraction_id': e.key,
              'notes': infractionNotes[e.key] ?? '',
            })
        .toList(),
    'custom_infractions': customInfractions
        .where((inf) => inf['text']?.isNotEmpty ?? false)
        .map((inf) => {
              'text': inf['text'],
              'notes': inf['notes'] ?? '',
            })
        .toList(),
  };
}
