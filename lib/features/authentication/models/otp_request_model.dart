

class OTPRequestModel {
  final String email;
  final String code;

  OTPRequestModel({
    required this.email,
    required this.code,
  });

  factory OTPRequestModel.fromJson(Map<String, dynamic> json) {
    return OTPRequestModel(
      email: json['email'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}
