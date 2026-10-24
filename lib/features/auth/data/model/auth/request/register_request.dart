class RegisterRequest {
  String? name;
  String? email;
  String? password;
  String? role;
  String? avatar;

  RegisterRequest({
    this.name,
    this.email,
    this.password,
    this.role,
    this.avatar,
  });

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['avatar'] = avatar;
    return data;
  }
}
