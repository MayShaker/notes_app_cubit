import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/pages/forget_password_page.dart';
import 'features/authentication/pages/login_page.dart';
import 'features/authentication/pages/otp_page.dart';
import 'features/authentication/pages/signup_page.dart';
import 'features/authentication/repositories/login_repo.dart';
import 'features/authentication/repositories/signup_repo.dart';
import 'features/authentication/repositories/otp_repo.dart'; // Add import for OTPRepository
import 'features/authentication/state_mangament/login/login_cubit.dart';
import 'features/authentication/state_mangament/signup/signup_cubit.dart';
import 'features/authentication/state_mangament/otp/otp_cubit.dart'; // Add import for OTPCubit

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => LoginRepository()),
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => OTPRepository()), // Add OTPRepository
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(
              RepositoryProvider.of<LoginRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(
              RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => OTPCubit(
              RepositoryProvider.of<OTPRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Your App Title',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/login',
          routes: {
            '/login': (context) => LoginPage(),
            '/signup': (context) => SignUpPage(),
            '/forgot-password': (context) => ForgotPasswordPage(),
            '/otp': (context) => OTPPage(email: ''), // Adjust if needed
          },
        ),
      ),
    );
  }
}
