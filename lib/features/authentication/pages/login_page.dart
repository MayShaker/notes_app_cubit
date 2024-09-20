import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/login_repo.dart';
import '../state_mangament/login/login_cubit.dart';
import '../state_mangament/login/login_state.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => LoginCubit(
            RepositoryProvider.of<LoginRepository>(context),
          ),
          child: LoginForm(),
        ),
      ),
      backgroundColor: Colors.transparent, 
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamed(context, '/home'); 
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background1.jfif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16),

                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, 
                        onPrimary: Colors.white,
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Don\'t have an account? Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/forgot-password');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
