class User {
  String? phonenumber;
  String? name;
  String? token;
  List? roles;

  User({
    this.phonenumber,
    this.name,
    this.token,
    this.roles,
  });

  factory User.fromServerJson(Map<String, dynamic> json) => User(
        phonenumber: json["user"]["phonenumber"],
        name: json["user"]["name"],
        token: json["token"],
        roles: json["roles"] ,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        phonenumber: json["phonenumber"],
        name: json["name"],
        token: json["token"],
        roles: json["roles"] ,
      );

  Map<String, dynamic> toJson() => {
        "phonenumber": phonenumber,
        "name": name,
        "token": token,
        "roles": roles,
      };
  
}