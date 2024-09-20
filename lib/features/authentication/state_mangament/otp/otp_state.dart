

import '../../models/otp_reponse_model.dart';

abstract class OTPState {}

class OTPInitial extends OTPState {}

class OTPLoading extends OTPState {}

class OTPSuccess extends OTPState {
  final OTPData otpData;  

  OTPSuccess(this.otpData);
}

class OTPFailure extends OTPState {
  final String errorMessage;

  OTPFailure(this.errorMessage);
}
