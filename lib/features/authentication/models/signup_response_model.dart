
class SignupResponseModel {
  final String firstName;
  final String lastName;
  final String email;

  SignupResponseModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  
  factory SignupResponseModel.fromJson (Map<String, dynamic> json){
    return SignupResponseModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
  }