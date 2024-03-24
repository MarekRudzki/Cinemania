// Package imports:
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:cinemania/features/auth/model/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
    on<PasswordResetPressed>(_onPasswordResetPressed);
    on<LoginWithGooglePressed>(_onLoginWithGooglePressed);
    on<LoginWithFacebookPressed>(_onLoginWithFacebookPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(
        AuthError(errorMessage: 'Please fill in all fields'),
      );
      emit(AuthInitial());
    } else {
      try {
        await authRepository.logInWithEmailPassword(
          email: event.email,
          password: event.password,
        );
        emit(AuthSuccess());
        emit(AuthInitial());
      } catch (error) {
        emit(AuthError(errorMessage: error.toString()));
        emit(AuthInitial());
      }
    }
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(AuthError(errorMessage: 'Please fill in all fields'));
      emit(AuthInitial());
    } else {
      try {
        await authRepository.registerWithEmailPassword(
          email: event.email,
          password: event.password,
        );

        emit(AuthSuccess());
        emit(AuthInitial());
      } catch (error) {
        emit(AuthError(errorMessage: error.toString()));
        emit(AuthInitial());
      }
    }
  }

  Future<void> _onPasswordResetPressed(
    PasswordResetPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    if (event.passwordResetEmail.isEmpty) {
      emit(AuthError(errorMessage: 'Field is empty'));
      emit(AuthInitial());
    } else {
      try {
        await authRepository.resetPassword(
          email: event.passwordResetEmail,
        );
        emit(AuthSuccess());
        emit(AuthInitial());
      } catch (error) {
        emit(AuthError(errorMessage: error.toString()));
        emit(AuthInitial());
      }
    }
  }

  Future<void> _onLoginWithGooglePressed(
    LoginWithGooglePressed event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await authRepository.signInWithCredential(
        credential: credential,
        username: googleUser!.email.substring(0, googleUser.email.indexOf('@')),
      );

      emit(AuthSuccess());
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(
          errorMessage: 'Signing in with a Google account has failed'));
      emit(AuthInitial());
    }
  }

  Future<void> _onLoginWithFacebookPressed(
    LoginWithFacebookPressed event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final userData = await FacebookAuth.instance.getUserData();

      await authRepository.signInWithCredential(
        credential: facebookAuthCredential,
        username: userData['name'] as String,
      );

      emit(AuthSuccess());
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(
          errorMessage: 'Signing in with a Facebook account has failed'));
      emit(AuthInitial());
    }
  }

  bool isUserLogged() {
    return authRepository.isUserLogged();
  }
}
