class ForgotPasswordResponseModel {
  final int statusCode;
  final String message;

  ForgotPasswordResponseModel({required this.statusCode, required this.message});

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
