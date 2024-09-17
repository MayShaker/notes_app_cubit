import '../../../core/network/api_client.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/response_model.dart';

class LoginRepository {
  Future<ResponseModel<LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiClient.request(
        url: '/auth/signin',
        method: 'POST',
        data: LoginRequestModel(email: email, password: password).toJson(),
      );

      // Parse the response using the ResponseModel with custom data parsing
      var responseModel = ResponseModel<LoginResponseModel>.fromJson(
        response.toJson(),
        createData: (data) => LoginResponseModel.fromJson(data),
      );

      return responseModel;
    } catch (e) {
      return ResponseModel<LoginResponseModel>(
        statusCode: 500,
        message: 'An unexpected error occurred',
      );
    }
  }
}
