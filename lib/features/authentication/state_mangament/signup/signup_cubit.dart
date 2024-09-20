import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/response_model.dart';
import '../../models/signup_request_model.dart';
import '../../models/signup_response_model.dart';
import '../../repositories/signup_repo.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final UserRepository userRepository;

  SignUpCubit(this.userRepository) : super(SignUpInitial());
  
  Future<void> signUp(String firstName, String lastName, String email, String password) async {
    emit(SignUpLoading());
    SignupRequestModel signupRequest = SignupRequestModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
    try {
      ResponseModel<SignupResponseModel> response = await userRepository.signUp(signupRequest);
      if (response.statusCode == 200) {
        emit(SignUpSuccess(response.data!)); 
      } else {
        emit(SignUpError(response.message)); 
      }
    } catch (e) {
      emit(SignUpError("An error occurred during sign-up.")); 
    }
  }
}
