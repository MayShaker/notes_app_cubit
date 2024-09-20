import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state_mangament/signup/signup_cubit.dart';
import '../state_mangament/signup/signup_state.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            // Navigate to OTP page on successful sign-up
            Navigator.pushReplacementNamed(context, '/otp', arguments: state.user.email);
          } else if (state is SignUpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background1.jfif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create an Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: firstNameController,
                                    labelText: 'First Name',
                                    icon: Icons.person,
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextField(
                                    controller: lastNameController,
                                    labelText: 'Last Name',
                                    icon: Icons.person_outline,
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextField(
                                    controller: emailController,
                                    labelText: 'Email',
                                    icon: Icons.email,
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextField(
                                    controller: passwordController,
                                    labelText: 'Password',
                                    icon: Icons.lock,
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 30),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<SignUpCubit>().signUp(
                                        firstNameController.text,
                                        lastNameController.text,
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    },
                                    child: Text('Sign Up'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      onPrimary: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      side: BorderSide(color: Colors.white, width: 2),
                                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: Text(
                                      'Already have an account? ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscureText;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
