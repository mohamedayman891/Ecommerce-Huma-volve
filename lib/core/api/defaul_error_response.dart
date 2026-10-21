class DefaulErrorResponse {
  String? statusMsg;
  String? message;

  DefaulErrorResponse({this.statusMsg, this.message});

  DefaulErrorResponse.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    return map;
  }
}
