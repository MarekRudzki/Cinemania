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

class ChangeUsernamePressed extends AccountEvent {
  final String username;

  ChangeUsernamePressed({
    required this.username,
  });

  @override
  List<Object> get props => [
        username,
      ];
}

class UserFavoritesRequested extends AccountEvent {}

class AddFavoritePressed extends AccountEvent {
  final Category category;
  final int id;
  final String name;
  final String url;
  final int? gender;

  AddFavoritePressed({
    required this.category,
    required this.id,
    required this.name,
    required this.url,
    this.gender,
  });

  @override
  List<Object> get props => [
        category,
        id,
        name,
        url,
        gender ?? Object(),
      ];
}

class DeleteFavoritePressed extends AccountEvent {
  final int id;

  DeleteFavoritePressed({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}

class PhotoValidationPressed extends AccountEvent {
  final String url;
  final int id;

  PhotoValidationPressed({
    required this.url,
    required this.id,
  });

  @override
  List<Object> get props => [
        url,
        id,
      ];
}
