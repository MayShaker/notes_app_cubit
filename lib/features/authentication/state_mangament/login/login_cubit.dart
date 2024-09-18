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

      // Check for a successful response and ensure that data is not null
      if (response.statusCode == 200 && response.data != null) {
        emit(LoginSuccess(response.data!));
      } else {
        emit(LoginFailure(response.message ?? 'Unknown error occurred')); // Safeguard in case message is null
      }
    } catch (e) {
      emit(LoginFailure('An unexpected error occurred')); // Optionally, you could log `e` to see details
    }
  }
}
