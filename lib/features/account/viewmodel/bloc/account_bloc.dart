import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/model/account_repository.dart';
import 'package:cinemania/features/account/model/models/favorite_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'account_event.dart';
part 'account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  AccountBloc({required this.accountRepository}) : super(AccountInitial()) {
    on<AddFavoritePressed>(_onAddFavoritePressed);
    on<UserFavoritesRequested>(_onUserFavoritesRequested);
    on<DeleteFavoritePressed>(_onDeleteFavoritePressed);
    on<ChangePasswordPressed>(_onChangePasswordPressed);
    on<DeleteAccountPressed>(_onDeleteAccountPressed);
    on<ChangeUsernamePressed>(_onChangeUsernamePressed);
  }

  List<Favorite> favorites = [];
  late bool isCategoryScrollable;

  void addListToLocalFavorites({
    required List<Favorite> allFavorites,
  }) {
    favorites = List.from(allFavorites);
  }

  bool checkIfLocalFavoritesContains({required int id}) {
    return favorites.any((favorite) => favorite.id == id);
  }

  void addSingleFavToLocalFavorites({required Favorite favorite}) {
    favorites.add(favorite);
  }

  void deleteSingleFavFromLocalFavorites({required int id}) {
    favorites.removeWhere((favorite) => favorite.id == id);
  }

  int getCurrentCategoryLength({required String category}) {
    final Category inputCategory;
    if (category == 'movies') {
      inputCategory = Category.movies;
    } else if (category == 'tv_shows') {
      inputCategory = Category.tvShows;
    } else {
      inputCategory = Category.cast;
    }
    final int categoryLength = favorites
        .where((favorite) => favorite.category == inputCategory)
        .length;

    return categoryLength;
  }

  void checkIfCategoryIsScrollable({required String category}) {
    final Category inputCategory;
    if (category == 'movies') {
      inputCategory = Category.movies;
    } else if (category == 'tv_shows') {
      inputCategory = Category.tvShows;
    } else {
      inputCategory = Category.cast;
    }

    final categoryFavorites =
        favorites.where((favorite) => favorite.category == inputCategory);
    final categoryCount = categoryFavorites.length;

    if (categoryCount > 2) {
      isCategoryScrollable = true;
    } else {
      isCategoryScrollable = false;
    }
  }

  // List<int> favoritesId = [];

  // void addListToLocalFavorites({
  //   required List<Favorite> allFavorites,
  // }) {
  //   final List<int> newList = [];
  //   for (final favorite in allFavorites) {
  //     newList.add(favorite.id);
  //   }
  //   favoritesId = newList;
  // }

  // bool checkIfLocalFavoritesContains({required int id}) {
  //   return favoritesId.contains(id);
  // }

  // void addSingleFavToLocalFavorites({required int id}) {
  //   favoritesId.add(id);
  // }

  // void deleteSingleFavFromLocalFavorites({required int id}) {
  //   favoritesId.remove(id);
  // }

  Future<void> _onUserFavoritesRequested(
    UserFavoritesRequested event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      final List<Favorite> favorites = await accountRepository.getFavorites();
      addListToLocalFavorites(allFavorites: favorites);

      emit(AccountSuccess(
        favorites: favorites,
      ));
    } catch (error) {
      emit(AccountError(errorMessage: error.toString()));
    }
  }

  Future<void> _onAddFavoritePressed(
    AddFavoritePressed event,
    Emitter<AccountState> emit,
  ) async {
    await accountRepository.addFavorite(
      favorite: Favorite(
        category: event.category,
        id: event.id,
        name: event.name,
        url: event.url,
        gender: event.gender,
      ),
    );
  }

  Future<void> _onDeleteFavoritePressed(
    DeleteFavoritePressed event,
    Emitter<AccountState> emit,
  ) async {
    await accountRepository.deleteFavorite(id: event.id);
  }

  List<Favorite> pickFavoritesByCategory({
    required List<Favorite> favorites,
    required String currentCategory,
  }) {
    return favorites.where((favorite) {
      if (currentCategory == 'movies') {
        return favorite.category == Category.movies;
      } else if (currentCategory == 'tv_shows') {
        return favorite.category == Category.tvShows;
      } else {
        return favorite.category == Category.cast;
      }
    }).toList();
  }

  Future<void> _onChangePasswordPressed(
    ChangePasswordPressed event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    if (event.currentPassword.isEmpty || event.newPassword.isEmpty) {
      emit(AccountError(errorMessage: 'Please fill in all fields'));
      emit(AccountInitial());
    }

    try {
      await accountRepository.changePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      emit(AccountSuccess());
    } catch (error) {
      emit(AccountError(errorMessage: error.toString()));
      emit(AccountInitial());
    }
  }

  Future<void> _onDeleteAccountPressed(
    DeleteAccountPressed event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    if (event.password.isEmpty) {
      emit(AccountError(errorMessage: 'Password field cannot be empty'));
      emit(AccountInitial());
    }

    try {
      await accountRepository.validateUserPassword(password: event.password);
      await accountRepository.deleteUser();
      emit(AccountSuccess());
    } catch (error) {
      emit(AccountError(errorMessage: error.toString()));
      emit(AccountInitial());
    }
  }

  Future<void> _onChangeUsernamePressed(
    ChangeUsernamePressed event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    if (event.username.isEmpty) {
      emit(AccountError(errorMessage: 'Username field cannot be empty'));
      emit(AccountInitial());
    }

    try {
      await accountRepository.changeUsername(username: event.username);
      emit(AccountSuccess());
    } catch (error) {
      emit(AccountError(errorMessage: error.toString()));
      emit(AccountInitial());
    }
  }

  Future<void> logout() async {
    await accountRepository.logout();
  }

  Future<void> saveUsernameFromFirebaseToHive() async {
    await accountRepository.saveUsernameFromFirebaseToHive();
  }

  String getUsername() {
    return accountRepository.getUsername();
  }

  bool passwordChangePossible() {
    final String loginMethod = accountRepository.getLoginMethod();
    if (loginMethod == 'email_password') {
      return true;
    } else {
      return false;
    }
  }

  String getNoFavoriteText({
    required String category,
  }) {
    if (category == 'movies') {
      return 'movies';
    } else if (category == 'tv_shows') {
      return 'TV Shows';
    } else {
      return 'Actor';
    }
  }
}
