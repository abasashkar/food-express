part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent {}

class SignInRequested extends AuthBlocEvent {
  final String email;
  final String password;
  SignInRequested({required this.email, required this.password});
}

class SignUpRequested extends AuthBlocEvent {
  final String name;
  final String email;
  final String password;

  SignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignOutRequested extends AuthBlocEvent {}
