import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/pages/signup_page.dart';
import 'features/authentication/repositories/signup_repo.dart';
import 'features/authentication/state_mangament/signup/signup_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  final userRepository = UserRepository();

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => SignUpCubit(userRepository),
        child: SignUpPage(),
      ),
    );
  }
}
