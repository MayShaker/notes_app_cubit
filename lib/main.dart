import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/pages/signup_page.dart';
import 'features/authentication/repositories/signup_repo.dart';
import 'features/authentication/state_mangament/login/login_cubit.dart';
import 'features/authentication/state_mangament/signup/signup_cubit.dart';
import 'features/authentication/pages/login_page.dart'; 
import 'features/authentication/repositories/login_repo.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final userRepository = UserRepository();
  final loginRepository = LoginRepository(); 

  runApp(MyApp(
    userRepository: userRepository,
    loginRepository: loginRepository, 
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final LoginRepository loginRepository; 

  MyApp({
    required this.userRepository,
    required this.loginRepository,
  });

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
        child: SignUpPage(), // Set the SignUpPage as default
      ),
      routes: {
        '/login': (context) => BlocProvider(
              create: (context) => LoginCubit(
                RepositoryProvider.of<LoginRepository>(context),
              ),
              child: LoginPage(),
            ),
        // Define other routes here
      },
    );
  }
}
