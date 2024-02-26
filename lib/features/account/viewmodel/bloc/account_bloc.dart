import 'package:cinemania/features/account/model/account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  AccountBloc({required this.accountRepository}) : super(AccountInitial()) {}

  Future<void> logout() async {
    await accountRepository.logout();
  }

  String getUsername() {
    return accountRepository.getUsername();
  }
}
