import 'package:ecomerce_bloc_new/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:ecomerce_bloc_new/presentation/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/home');
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
                title: "Welcome Back 👋",
                buttonLabel: "Sign In",
                showNameField: false,
                isLoading: isLoading,
                onSubmit: ({required email, required password, String? name}) {
                  print("SIGN IN → $email | $password");
                  context.read<AuthBlocBloc>().add(
                    SignInRequested(email: email, password: password),
                  );
                },
                onNavigate: () {
                  context.go('/signup'); // go = remove previous
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
