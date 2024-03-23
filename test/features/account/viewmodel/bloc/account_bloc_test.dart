import 'package:bloc_test/bloc_test.dart';
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/model/account_repository.dart';
import 'package:cinemania/features/account/model/models/favorite_model.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  late AccountBloc sut;
  late AccountRepository accountRepository;

  setUp(() {
    accountRepository = MockAccountRepository();
    sut = AccountBloc(accountRepository: accountRepository);
  });

  final Favorite favoriteTest = Favorite(
    category: Category.movies,
    id: 1,
    gender: 0,
    name: 'Test',
    url: 'url',
  );

  test(
    'should add favorite list to local bloc favorites list',
    () {
      sut.addListToLocalFavorites(allFavorites: [favoriteTest]);

      expect(sut.favorites, [favoriteTest]);
    },
  );

  test(
    'should add single favorite to local bloc favorites list',
    () {
      sut.addSingleFavToLocalFavorites(favorite: favoriteTest);

      expect(sut.favorites, [favoriteTest]);
    },
  );

  test(
    'should check if local bloc favorites list contains given id',
    () async {
      sut.addSingleFavToLocalFavorites(favorite: favoriteTest);

      final bool shouldContain = sut.checkIfLocalFavoritesContains(id: 1);
      final bool shouldNotContain = sut.checkIfLocalFavoritesContains(id: 2);

      expect(shouldContain, true);
      expect(shouldNotContain, false);
    },
  );

  test(
    'should delete single favorite from local bloc favorites list',
    () {
      sut.favorites = [favoriteTest];
      sut.deleteSingleFavFromLocalFavorites(id: 1);

      expect(sut.favorites.isEmpty, true);
    },
  );

  group('should get category length', () {
    final List<Map<String, dynamic>> testCases = [
      {'category': 'movies', 'expectedLength': 2},
      {'category': 'tv_shows', 'expectedLength': 1},
      {'category': 'cast', 'expectedLength': 0},
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['category']}',
        () {
          sut.addSingleFavToLocalFavorites(favorite: favoriteTest);
          sut.addSingleFavToLocalFavorites(favorite: favoriteTest);
          sut.addSingleFavToLocalFavorites(
              favorite: Favorite(
                  category: Category.tvShows, id: 2, name: 'name', url: 'url'));
          final int outcome = sut.getCurrentCategoryLength(
            category: testCase['category']! as String,
          );
          expect(outcome, testCase['expectedLength']);
        },
      );
    }
  });

  group('should check if category is scrollable', () {
    final List<Map<String, dynamic>> testCases = [
      {'category': 'movies', 'isScrollable': true},
      {'category': 'tv_shows', 'isScrollable': false},
      {'category': 'cast', 'isScrollable': false},
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['category']}',
        () {
          sut.addSingleFavToLocalFavorites(favorite: favoriteTest);
          sut.addSingleFavToLocalFavorites(favorite: favoriteTest);
          sut.addSingleFavToLocalFavorites(favorite: favoriteTest);
          sut.addSingleFavToLocalFavorites(
              favorite: Favorite(
                  category: Category.tvShows, id: 2, name: 'name', url: 'url'));
          sut.addSingleFavToLocalFavorites(
              favorite: Favorite(
                  category: Category.tvShows, id: 2, name: 'name', url: 'url'));
          sut.addSingleFavToLocalFavorites(
              favorite: Favorite(
                  category: Category.cast, id: 2, name: 'name', url: 'url'));
          sut.checkIfCategoryIsScrollable(
            category: testCase['category']! as String,
          );
          expect(sut.isCategoryScrollable, testCase['isScrollable']);
        },
      );
    }
  });

  blocTest<AccountBloc, AccountState>(
    'emits [AccountLoading] and [AccountSuccess] when UserFavoritesRequested is added.',
    build: () {
      when(() => accountRepository.getFavorites())
          .thenAnswer((_) async => [favoriteTest]);
      return sut;
    },
    act: (bloc) => bloc.add(UserFavoritesRequested()),
    expect: () => [
      AccountLoading(),
      AccountSuccess(
        favorites: [favoriteTest],
      ),
    ],
  );

  blocTest<AccountBloc, AccountState>(
    'triggers AddFavoritePressed event.',
    build: () {
      when(() => accountRepository.addFavorite(favorite: favoriteTest))
          .thenAnswer((_) async => {});
      return sut;
    },
    act: (bloc) => bloc.add(
      AddFavoritePressed(
        category: Category.movies,
        id: 1,
        name: 'Test',
        url: 'url',
        gender: 0,
      ),
    ),
    expect: () => [],
  );

  blocTest<AccountBloc, AccountState>(
    'triggers DeleteFavoritePressed event.',
    build: () {
      when(() => accountRepository.deleteFavorite(id: any(named: 'id')))
          .thenAnswer((_) async => {});
      return sut;
    },
    act: (bloc) => bloc.add(
      DeleteFavoritePressed(
        id: 1,
      ),
    ),
    expect: () => [],
  );

  group('should fetch favorites by category', () {
    final List<Map<String, dynamic>> testCases = [
      {'category': 'movies', 'expectedLength': 3},
      {'category': 'tv_shows', 'expectedLength': 2},
      {'category': 'cast', 'expectedLength': 1},
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['category']}',
        () {
          sut.addSingleFavToLocalFavorites(favorite: favoriteTest);
          sut.addSingleFavToLocalFavorites(favorite: favoriteTest);
          sut.addSingleFavToLocalFavorites(favorite: favoriteTest);
          sut.addSingleFavToLocalFavorites(
              favorite: Favorite(
                  category: Category.tvShows, id: 2, name: 'name', url: 'url'));
          sut.addSingleFavToLocalFavorites(
              favorite: Favorite(
                  category: Category.tvShows, id: 2, name: 'name', url: 'url'));
          sut.addSingleFavToLocalFavorites(
              favorite: Favorite(
                  category: Category.cast, id: 2, name: 'name', url: 'url'));

          final List<Favorite> favs = sut.pickFavoritesByCategory(
            favorites: sut.favorites,
            currentCategory: testCase['category'] as String,
          );
          expect(favs.length, testCase['expectedLength']);
        },
      );
    }
  });

  group('Password change -', () {
    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading], [AuthError] and [AuthInitial] when ChangePasswordPressed is added without data.',
      build: () => sut,
      act: (bloc) =>
          bloc.add(ChangePasswordPressed(currentPassword: '', newPassword: '')),
      expect: () => [
        AccountLoading(),
        AccountError(errorMessage: 'Please fill in all fields'),
        AccountInitial(),
      ],
    );
    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading], [AuthError] and [AuthInitial] when ChangePasswordPressed is added without password.',
      build: () => sut,
      act: (bloc) => bloc.add(ChangePasswordPressed(
          currentPassword: '', newPassword: 'newPassword')),
      expect: () => [
        AccountLoading(),
        AccountError(errorMessage: 'Please fill in all fields'),
        AccountInitial(),
      ],
    );
    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading], [AuthError] and [AuthInitial] when ChangePasswordPressed is added without new password.',
      build: () => sut,
      act: (bloc) => bloc.add(ChangePasswordPressed(
          currentPassword: 'currentPassword', newPassword: '')),
      expect: () => [
        AccountLoading(),
        AccountError(errorMessage: 'Please fill in all fields'),
        AccountInitial(),
      ],
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading] and [AccountSuccess] when ChangePasswordPressed is added with proper data.',
      build: () {
        when(() => accountRepository.changePassword(
                currentPassword: any(named: 'currentPassword'),
                newPassword: any(named: 'newPassword')))
            .thenAnswer((_) async => {});
        when(() => accountRepository.getFavorites())
            .thenAnswer((_) async => [favoriteTest]);
        return sut;
      },
      act: (bloc) => bloc.add(ChangePasswordPressed(
          currentPassword: 'currentPassword', newPassword: 'newPassword')),
      expect: () => [
        AccountLoading(),
        AccountSuccess(favorites: [favoriteTest])
      ],
    );
  });

  group('Delete account -', () {
    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading], [AuthError] and [AuthInitial] when DeleteAccountPressed is added without password.',
      build: () => sut,
      act: (bloc) => bloc.add(DeleteAccountPressed(password: '')),
      expect: () => [
        AccountLoading(),
        AccountError(errorMessage: 'Password field cannot be empty'),
        AccountInitial(),
      ],
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading] and [AccountSuccess] when DeleteAccountPressed is added with proper data.',
      build: () {
        when(() => accountRepository.validateUserPassword(
            password: any(named: 'password'))).thenAnswer((_) async => {});
        when(() => accountRepository.deleteUser()).thenAnswer((_) async => {});

        return sut;
      },
      act: (bloc) => bloc.add(DeleteAccountPressed(password: 'password')),
      expect: () => [AccountLoading(), AccountSuccess()],
    );
  });

  group('Username change -', () {
    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading], [AuthError] and [AuthInitial] when ChangeUsernamePressed is added without username.',
      build: () => sut,
      act: (bloc) => bloc.add(ChangeUsernamePressed(username: '')),
      expect: () => [
        AccountLoading(),
        AccountError(errorMessage: 'Username field cannot be empty'),
        AccountInitial(),
      ],
    );

    blocTest<AccountBloc, AccountState>(
      'emits [AccountLoading] and [AccountSuccess] when ChangeUsernamePressed is added with proper data.',
      build: () {
        when(() => accountRepository.changeUsername(
            username: any(named: 'username'))).thenAnswer((_) async => {});
        when(() => accountRepository.getFavorites())
            .thenAnswer((_) async => [favoriteTest]);

        return sut;
      },
      act: (bloc) => bloc.add(ChangeUsernamePressed(username: 'username')),
      expect: () => [
        AccountLoading(),
        AccountSuccess(
          favorites: [favoriteTest],
        ),
      ],
    );
  });

  test(
    'should validate photo',
    () async {
      when(() =>
              accountRepository.getItemPhotoUrl(itemId: any(named: 'itemId')))
          .thenAnswer((_) async => 'url');
      when(() => accountRepository.updatePhotoUrl(
          itemId: any(named: 'itemId'),
          newUrl: any(named: 'newUrl'))).thenAnswer((_) async => {});
      sut.addSingleFavToLocalFavorites(favorite: favoriteTest);

      sut.add(PhotoValidationPressed(url: 'url2', id: 1));
      await Future.delayed(const Duration(milliseconds: 100));

      verify(() =>
              accountRepository.getItemPhotoUrl(itemId: any(named: 'itemId')))
          .called(1);
      verify(() => accountRepository.updatePhotoUrl(
          itemId: any(named: 'itemId'),
          newUrl: any(named: 'newUrl'))).called(1);
    },
  );

  test(
    'should trigger logout function',
    () async {
      when(() => accountRepository.logout()).thenAnswer((_) async => {});

      await sut.logout();

      verify(() => accountRepository.logout()).called(1);
    },
  );

  test(
    'should trigger save username from firebase to hive',
    () async {
      when(() => accountRepository.saveUsernameFromFirebaseToHive())
          .thenAnswer((_) async => {});

      await sut.saveUsernameFromFirebaseToHive();

      verify(() => accountRepository.saveUsernameFromFirebaseToHive())
          .called(1);
    },
  );

  test(
    'should fetch username',
    () async {
      when(() => accountRepository.getUsername()).thenReturn('username');

      final String username = sut.getUsername();

      expect(username, 'username');
    },
  );

  group('should check if password change is possible', () {
    test(
      'and return true',
      () async {
        when(() => accountRepository.getLoginMethod())
            .thenReturn('email_password');

        final bool isPossible = sut.passwordChangePossible();

        expect(isPossible, true);
      },
    );

    test(
      'and return false',
      () async {
        when(() => accountRepository.getLoginMethod())
            .thenReturn('social_media');

        final bool isPossible = sut.passwordChangePossible();

        expect(isPossible, false);
      },
    );
  });

  group('should get no favorite text', () {
    final List<Map<String, dynamic>> testCases = [
      {'category': 'movies', 'expectedString': 'movies'},
      {'category': 'tv_shows', 'expectedString': 'TV Shows'},
      {'category': 'cast', 'expectedString': 'Actor'},
    ];

    for (final testCase in testCases) {
      test(
        'for ${testCase['category']}',
        () {
          final outcome = sut.getNoFavoriteText(
            category: testCase['category']! as String,
          );

          expect(outcome, testCase['expectedString']);
        },
      );
    }
  });
}
