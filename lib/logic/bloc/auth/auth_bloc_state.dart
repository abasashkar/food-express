part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class AuthSuccess extends AuthBlocState {}

final class AuthFailure extends AuthBlocState {
  final String message;
  AuthFailure(this.message);
}

final class AuthLogout extends AuthBlocState {}
