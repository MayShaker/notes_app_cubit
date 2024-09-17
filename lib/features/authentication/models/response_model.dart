class ResponseModel<T> {
  final int statusCode;
  final String message;
  final T? data;

  ResponseModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  /// Factory method to create a ResponseModel from JSON
  factory ResponseModel.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) createData) {
    return ResponseModel<T>(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? createData(json['data']) : null,
    );
  }
}
