import 'package:ecomerce_bloc_new/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:ecomerce_bloc_new/presentation/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/home'); // ✅ Redirect to home
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: AuthForm(
                title: "Create Account ✨",
                buttonLabel: "Sign Up",
                showNameField: true,
                isLoading: isLoading,

                // ✅ FIX IS HERE
                onSubmit: ({required email, required password, String? name}) {
                  print("SIGN UP → $name | $email | $password");

                  context.read<AuthBlocBloc>().add(
                    SignUpRequested(
                      name: name!.trim(), // ✅ SEND NAME
                      email: email.trim(),
                      password: password.trim(),
                    ),
                  );
                },

                onNavigate: () {
                  context.push('/signin');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
