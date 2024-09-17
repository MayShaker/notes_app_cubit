import '../../../core/network/api_client.dart';
import '../models/forget_password_request_model.dart';
import '../models/forget_password_response_model.dart';
import '../models/response_model.dart';

class ForgotPasswordRepository {
  Future<ResponseModel<ForgotPasswordResponseModel>> requestPasswordReset({
    required ForgotPasswordRequestModel forgotPasswordRequest,
  }) async {
    try {
      final response = await ApiClient.request(
        url: '/auth/request-password-reset',
        method: 'POST',
        data: forgotPasswordRequest.toJson(),
        withToken: false, 
      );

      
      var responseModel = ResponseModel<ForgotPasswordResponseModel>.fromJson(
        response.toJson(),
        createData: (data) => ForgotPasswordResponseModel.fromJson(data),
      );

      return responseModel;
    } catch (e) {
      return ResponseModel<ForgotPasswordResponseModel>(
        statusCode: 500,
        message: 'An unexpected error occurred',
      );
    }
  }
}
