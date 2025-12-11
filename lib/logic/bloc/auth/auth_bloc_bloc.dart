import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<SignInRequested>(_onAuthSignInRequested);
    on<SignUpRequested>(_onAuthSignUpRequested);
    on<SignOutRequested>(_onSignoutRequested);
  }

  Future<void> _onAuthSignInRequested(
    SignInRequested event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthSignUpRequested(
    SignUpRequested event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      await userCredential.user!.updateDisplayName(event.name);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignoutRequested(
    SignOutRequested event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signOut();
      emit(AuthLogout());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
