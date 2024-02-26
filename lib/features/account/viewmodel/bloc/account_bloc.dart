import 'package:cinemania/features/account/model/account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  AccountBloc({required this.accountRepository}) : super(AccountInitial()) {
    on<ChangePasswordPressed>(_onChangePasswordPressed);
  }

  Future<void> _onChangePasswordPressed(
    ChangePasswordPressed event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    if (event.currentPassword.trim().isEmpty ||
        event.newPassword.trim().isEmpty) {
      emit(AccountError(errorMessage: 'Please fill in all fields'));
      emit(AccountInitial());
    }

    try {
      // await accountRepository.changePassword(
      //   currentPassword: event.currentPassword,
      //   newPassword: event.newPassword,
      // );
      emit(AccountSuccess());
    } catch (error) {
      emit(AccountError(
          errorMessage: error.toString().replaceFirst('Exception: ', '')));
      emit(AccountInitial());
    }
  }

  Future<void> logout() async {
    await accountRepository.logout();
  }

  Future<void> saveUsernameFromFirebaseToHive() async {
    await accountRepository.saveUsernameFromFirebaseToHive();
  }
}
