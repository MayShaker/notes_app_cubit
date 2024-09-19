import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/pages/login_page.dart'; 
import 'features/authentication/repositories/login_repo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final loginRepository = LoginRepository();

  runApp(MyApp(
    loginRepository: loginRepository,
  ));
}

class MyApp extends StatelessWidget {
  final LoginRepository loginRepository;

  MyApp({required this.loginRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: loginRepository, 
      child: MaterialApp(
        title: 'Notes App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(), 
        routes: {
          '/login': (context) => LoginPage(),
          // Define other routes
        },
      ),
    );
  }
}
