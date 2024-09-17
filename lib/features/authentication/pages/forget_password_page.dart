import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/forget_password_repo.dart';
import '../state_mangament/forget/forget_password_cubit.dart';
import '../state_mangament/forget/forget_password_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => ForgotPasswordCubit(
            RepositoryProvider.of<ForgotPasswordRepository>(context), // Inject ForgotPasswordRepository
          ),
          child: ForgotPasswordForm(),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password reset email sent successfully')),
          );
          Navigator.pop(context); // Navigate back to previous page
        } else if (state is ForgotPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<ForgotPasswordCubit>().requestPasswordReset(
                      email: emailController.text,
                    );
              },
              child: Text('Send Reset Email'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Back to Login'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
