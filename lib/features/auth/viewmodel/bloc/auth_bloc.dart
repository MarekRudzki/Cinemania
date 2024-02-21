import 'package:cinemania/features/auth/model/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
    on<PasswordResetPressed>(_onPasswordResetPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(
        AuthError(errorMessage: 'Please fill in all fields'),
      );
      emit(AuthInitial());
    } else {
      emit(AuthLoading());

      try {
        await authRepository.logIn(
          email: event.email,
          password: event.password,
        );
        emit(AuthSuccess());
        emit(AuthInitial());
      } catch (error) {
        emit(AuthError(
            errorMessage: error.toString().replaceFirst('Exception: ', '')));
        emit(AuthInitial());
      }
    }
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(AuthError(errorMessage: 'Please fill in all fields'));
      emit(AuthInitial());
    } else {
      emit(AuthLoading());
      try {
        await authRepository.register(
          email: event.email,
          password: event.password,
        );

        emit(AuthSuccess());
        emit(AuthInitial());
      } catch (error) {
        emit(AuthError(
            errorMessage: error.toString().replaceFirst('Exception: ', '')));
        emit(AuthInitial());
      }
    }
  }

  Future<void> _onPasswordResetPressed(
    PasswordResetPressed event,
    Emitter<AuthState> emit,
  ) async {
    if (event.passwordResetEmail.isEmpty) {
      emit(AuthError(errorMessage: 'Field is empty'));
      emit(AuthInitial());
    } else {
      try {
        emit(AuthLoading());
        await authRepository.resetPassword(
          email: event.passwordResetEmail,
        );
        emit(AuthSuccess());
        emit(AuthInitial());
      } catch (error) {
        emit(AuthError(
            errorMessage: error.toString().replaceFirst('Exception: ', '')));
        emit(AuthInitial());
      }
    }
  }
}
