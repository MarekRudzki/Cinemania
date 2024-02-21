part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthError extends AuthState {
  final String errorMessage;

  AuthError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
