import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/forget_password_request_model.dart';
import '../../repositories/forget_password_repo.dart';
import 'forget_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordCubit(this.forgotPasswordRepository) : super(ForgotPasswordInitial());

  Future<void> requestPasswordReset({required String email}) async {
    emit(ForgotPasswordLoading());
    try {
      final forgotPasswordRequest = ForgotPasswordRequestModel(email: email);
      final response = await forgotPasswordRepository.requestPasswordReset(
        forgotPasswordRequest: forgotPasswordRequest,
      );
      if (response.statusCode == 200) {
        emit(ForgotPasswordSuccess());
      } else {
        emit(ForgotPasswordFailure(response.message));
      }
    } catch (e) {
      emit(ForgotPasswordFailure('An unexpected error occurred'));
    }
  }
}
