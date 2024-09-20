

import '../models/otp_reponse_model.dart';  
import '../models/otp_request_model.dart';

class OTPResponseModel {
  final int statusCode;
  final String message;
  final OTPData data;  

  OTPResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory OTPResponseModel.fromJson(Map<String, dynamic> json) {
    return OTPResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      data: OTPData.fromJson(json['data']), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),  
    };
  }
}


class OTPData {
  final String userId;  
  final bool isVerified;  

  OTPData({
    required this.userId,
    required this.isVerified,
  });

  factory OTPData.fromJson(Map<String, dynamic> json) {
    return OTPData(
      userId: json['userId'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'isVerified': isVerified,
    };
  }
}
