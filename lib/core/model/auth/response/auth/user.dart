class User {
  String? name;
  String? email;
  String? role;
  String? phone;

  User({this.name, this.email, this.role, this.phone});

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    if (phone != null) map['phone'] = phone;
    return map;
  }
}
