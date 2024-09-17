

import 'package:notes_app/features/authentication/models/signup_response_model.dart';

import '../../../core/network/api_client.dart';
import '../models/response_model.dart';
import '../models/signup_request_model.dart';


class UserRepository {
  Future <ResponseModel <SignupResponseModel>>signUp (SignupRequestModel signupRequest) async
  {
    final response = await ApiClient.request(
      url:'/auth/signup',
      method: 'POST',
      data: signupRequest.toJson(),
      withToken:false,
    );

     return ResponseModel<SignupResponseModel>.fromJson(
      response.data,
      (data) => SignupResponseModel.fromJson(data),
    );
  }
}