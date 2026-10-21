class LoginRequest {
  String? email;
  String? password;
  String? name;
  String? phone;

  LoginRequest({
    required this.email,
    required this.password,
    this.name,
    this.phone,
  });

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    return data;
  }
}
