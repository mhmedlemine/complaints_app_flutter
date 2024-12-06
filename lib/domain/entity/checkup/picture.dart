import 'package:complaintsapp/domain/entity/complaint/infraction.dart';

class Picture {
  String? file_path;
  String? file_type; // 'image', 'document', 'audio', 'video'
  String? description;

  Picture({
    this.file_path,
    this.file_type,
    this.description,
  });

  factory Picture.fromMap(Map<String, dynamic> json) => Picture(
    file_path: json['file_path'],
    file_type: json['file_type'],
    description: json['description'],
  );

  Map<String, dynamic> toMap() => {
    "file_path": file_path,
    "file_type": file_type,
    "description": description,
  };
}

class PictureList {
  final List<Picture>? evidences;

  PictureList({
    this.evidences,
  });

  factory PictureList.fromJson(List<dynamic> json) {
    List<Picture> evidences = <Picture>[];
    evidences = json.map((evidence) => Picture.fromMap(evidence)).toList();

    return PictureList(
      evidences: evidences,
    );
  }
}
