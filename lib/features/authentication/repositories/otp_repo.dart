import 'package:dio/dio.dart';
import 'package:notes_app/core/network/api_client.dart';
import 'package:notes_app/features/authentication/models/otp_reponse_model.dart';
import '../models/otp_request_model.dart';

class OTPRepository {
  
  OTPRepository();

  Future<OTPResponseModel> verifyOTP(OTPRequestModel otpRequest) async {
    try {
      final response = await ApiClient.request(
        url: '/auth/verify-otp',
        method: 'POST',
        data: otpRequest.toJson(),
      );
      return OTPResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      throw e.response?.data['message'] ?? 'An error occurred';
    }
  }
}
