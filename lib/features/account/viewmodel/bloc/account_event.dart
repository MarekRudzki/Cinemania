part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordPressed extends AccountEvent {
  final String currentPassword;
  final String newPassword;

  ChangePasswordPressed({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [
        currentPassword,
        newPassword,
      ];
}

class DeleteAccountPressed extends AccountEvent {
  final String password;

  DeleteAccountPressed({
    required this.password,
  });

  @override
  List<Object> get props => [
        password,
      ];
}
