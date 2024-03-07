part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountSuccess extends AccountState {
  final List<Favorite>? favorites;

  AccountSuccess({
    this.favorites,
  });

  @override
  List<Object> get props => [
        favorites ?? Object(),
      ];
}

final class AccountError extends AccountState {
  final String errorMessage;

  AccountError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
