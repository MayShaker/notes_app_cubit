import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/otp_repo.dart';
import '../state_mangament/otp/otp_cubit.dart';
import '../state_mangament/otp/otp_state.dart';


class OTPPage extends StatelessWidget {
  final String email;

  OTPPage({required this.email});

  @override
  Widget build(BuildContext context) {
    final codeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => OTPCubit(RepositoryProvider.of<OTPRepository>(context)),
        child: BlocConsumer<OTPCubit, OTPState>(
          listener: (context, state) {
            if (state is OTPSuccess) {
              Navigator.pushReplacementNamed(context, '/home'); // Navigate to home after successful verification
            } else if (state is OTPFailure) {
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // OTP Input
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: codeController,
                          decoration: InputDecoration(
                            labelText: 'Enter OTP',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.transparent,
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
                        ),
                      ),
                      SizedBox(height: 16),

                      // Verify Button
                      ElevatedButton(
                        onPressed: () {
                          context.read<OTPCubit>().verifyOTP(email, codeController.text);
                        },
                        child: Text('Verify OTP'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onPrimary: Colors.white,
                          side: BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}
