part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class RegisterButtonPressed extends AuthEvent {
  final String email;
  final String password;

  RegisterButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class PasswordResetPressed extends AuthEvent {
  final String passwordResetEmail;

  PasswordResetPressed({
    required this.passwordResetEmail,
  });

  @override
  List<Object> get props => [
        passwordResetEmail,
      ];
}
