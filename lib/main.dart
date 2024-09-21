import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; 

import 'core/network/api_client.dart';
import 'features/authentication/pages/forget_password_page.dart';
import 'features/authentication/pages/login_page.dart';
import 'features/authentication/pages/otp_page.dart';
import 'features/authentication/pages/signup_page.dart';
import 'features/authentication/repositories/login_repo.dart';
import 'features/authentication/repositories/signup_repo.dart';
import 'features/authentication/repositories/otp_repo.dart';
import 'features/authentication/state_mangament/login/login_cubit.dart';
import 'features/authentication/state_mangament/otp/otp_cubit.dart';
import 'features/authentication/state_mangament/signup/signup_cubit.dart';
import 'features/notes/pages/home_page.dart';
import 'features/notes/repositories/create_note_repo.dart';
import 'features/notes/repositories/get_note_repo.dart';
import 'features/notes/statemanagement/get/get_cubit.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter(); 

  await Hive.openBox('authBox').catchError((error) {
    print('Error opening Hive box: $error');
  });

  //ApiClient.initDio(); 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => LoginRepository()),
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => OTPRepository()),
        RepositoryProvider(create: (context) => GetNoteRepository()), 
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
          BlocProvider(
            create: (context) => GetNotesCubit(
              RepositoryProvider.of<GetNoteRepository>(context),
            ),
          ), 
        ],
        child: MaterialApp(
          title: 'Notes App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/login',
          routes: {
            '/home': (context) => HomePage(),
            '/otp': (context) => OTPPage(email: ''),
            '/login': (context) => LoginPage(),
            '/signup': (context) => SignUpPage(),
            '/forgot-password': (context) => ForgotPasswordPage(),
          },
        ),
      ),
    );
  }
}
