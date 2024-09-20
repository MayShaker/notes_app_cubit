import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/login_repo.dart';
import 'login_state.dart';
import '../../models/login_response_model.dart'; 

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit(this.loginRepository) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await loginRepository.login(email: email, password: password);
         print('Login Response: ${response.toString()}');

      if (response.statusCode == 200 && response.data != null) {
        emit(LoginSuccess(response.data!));
         print('Error Response: ${response.message}');
      } else {
        emit(LoginFailure(response.message)); //  in case message is null
      }
    } catch (e) {
      print('Login Exception: $e');
      emit(LoginFailure('An unexpected error occurred')); 
    }
  }
}
