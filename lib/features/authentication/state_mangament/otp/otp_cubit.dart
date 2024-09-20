import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/otp_reponse_model.dart';
import '../../models/otp_request_model.dart';

import '../../repositories/otp_repo.dart';
import 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  final OTPRepository otpRepository;

  OTPCubit(this.otpRepository) : super(OTPInitial());

  Future<void> verifyOTP(String email, String code) async {
    emit(OTPLoading());
    try {
      final response = await otpRepository.verifyOTP(OTPRequestModel(email: email, code: code));
      if (response.statusCode == 200) {
        // Assuming response.data is of type OTPData
        emit(OTPSuccess(response.data!));
      } else {
        emit(OTPFailure(response.message));
      }
    } catch (e) {
      emit(OTPFailure("An error occurred during OTP verification."));
    }
  }
}
