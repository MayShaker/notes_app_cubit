class LoginResponseModel {
  final User user;
  final String accessToken;
  final String refreshToken;

  LoginResponseModel({required this.user, required this.accessToken, required this.refreshToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: User.fromJson(json['user']),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  @override
  String toString() {
    return 'LoginResponseModel(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

class User {
  final String firstName;
  final String lastName;
  final String email;
  final bool isVerified;

  User({required this.firstName, required this.lastName, required this.email, required this.isVerified});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      isVerified: json['isVerified'],
    );
  }

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, isVerified: $isVerified)';
  }
}
