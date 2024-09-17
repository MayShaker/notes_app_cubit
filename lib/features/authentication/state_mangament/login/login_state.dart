import 'package:equatable/equatable.dart';
import '../../models/login_response_model.dart'; // Adjust the import according to your project structure

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel loginResponseModel;

  LoginSuccess(this.loginResponseModel);

  @override
  List<Object?> get props => [loginResponseModel];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
