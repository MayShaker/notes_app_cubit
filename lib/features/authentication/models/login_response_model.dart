import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final int statusCode;
  final String message;
  final LoginData? data;

  LoginResponseModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }

  @override
  List<Object?> get props => [statusCode, message, data];
}

class LoginData extends Equatable {
  final User user;
  final String accessToken;
  final String refreshToken;

  LoginData({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: User.fromJson(json['user']),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}

class User extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final bool isVerified;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      isVerified: json['isVerified'],
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, email, isVerified];
}
