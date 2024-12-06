class Infraction {
  int? id;
  String? code;
  String? label;
  String? description;

  Infraction({
    this.id,
    this.code,
    this.label,
    this.description,
  });

  factory Infraction.fromMap(Map<String, dynamic> json) => Infraction(
    id: json['id'],
    code: json['code'],
    label: json['label'],
    description: json['description'],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "label": label,
    "description": description,
  };
}


class InfractionList {
  final List<Infraction>? infractions;

  InfractionList({
    this.infractions,
  });

  factory InfractionList.fromJson(List<dynamic> json) {
    List<Infraction> infractions = <Infraction>[];
    infractions = json.map((infraction) => Infraction.fromMap(infraction)).toList();

    return InfractionList(
      infractions: infractions,
    );
  }
}