import 'package:equatable/equatable.dart';

import '../../models/signup_response_model.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}
class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {
  final SignupResponseModel user;
  SignUpSuccess(this.user);

  @override
  List<Object> get props => [user];
}
class SignUpRequiresOtp extends SignUpState {
  final SignupResponseModel user;
  SignUpRequiresOtp(this.user);

  @override
  List<Object> get props => [user];
}
class SignUpError extends SignUpState {
  final String message;

  SignUpError(this.message);

  @override
  List<Object> get props => [message];
}
