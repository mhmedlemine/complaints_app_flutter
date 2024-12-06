import 'package:complaintsapp/domain/entity/shop/entreprise.dart';

class Merchant {
  int? id;
  String? nni;
  String? fname;
  String? lname;
  String? phoneNumber;
  List<Entreprise>? entreprises;

  Merchant({
    this.id,
    this.nni,
    this.fname,
    this.lname,
    this.phoneNumber,
    this.entreprises,
  });

  factory Merchant.fromMap(Map<String, dynamic> json) => Merchant(
    id: json['id'],
    nni: json['nni'],
    fname: json['fname'],
    lname: json['lname'],
    phoneNumber: json['phonenumber'],
    entreprises: json['entreprises'] != null
        ? List<Entreprise>.from(json['entreprises'].map((x) => Entreprise.fromMap(x)))
        : null,
  );

  Map<String, dynamic> toMap() => {
    "nni": nni,
    "fname": fname,
    "lname": lname,
    "phonenumber": phoneNumber,
  };
}

class MerchantList {
  final List<Merchant>? merchants;

  MerchantList({
    this.merchants,
  });

  factory MerchantList.fromJson(List<dynamic> json) {
    List<Merchant> merchants = <Merchant>[];
    merchants = json.map((merchant) => Merchant.fromMap(merchant)).toList();

    return MerchantList(
      merchants: merchants,
    );
  }
}
