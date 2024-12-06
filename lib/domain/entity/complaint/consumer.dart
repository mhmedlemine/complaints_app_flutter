class Consumer {
  int? id;
  String? nni;
  String? fname;
  String? lname;
  String? phonenumber;
  String? address;

  Consumer({
    this.id,
    this.nni,
    this.fname,
    this.lname,
    this.phonenumber,
    this.address,
  });

  factory Consumer.fromMap(Map<String, dynamic> json) => Consumer(
    id: json['id'],
    nni: json['nni'],
    fname: json['fname'],
    lname: json['lname'],
    phonenumber: json['phonenumber'],
    address: json['address'],
  );

  Map<String, dynamic> toMap() => {
    "nni": nni,
    "fname": fname,
    "lname": lname,
    "phonenumber": phonenumber,
    "address": address,
  };
}


class ConsumerList {
  final List<Consumer>? consumers;

  ConsumerList({
    this.consumers,
  });

  factory ConsumerList.fromJson(List<dynamic> json) {
    List<Consumer> consumers = <Consumer>[];
    consumers = json.map((consumer) => Consumer.fromMap(consumer)).toList();

    return ConsumerList(
      consumers: consumers,
    );
  }
}