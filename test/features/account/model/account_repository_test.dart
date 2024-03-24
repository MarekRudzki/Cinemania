// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/account/model/account_repository.dart';
import 'package:cinemania/features/account/model/datasources/local/account_hive.dart';
import 'package:cinemania/features/account/model/datasources/remote/account_auth.dart';
import 'package:cinemania/features/account/model/datasources/remote/account_firestore.dart';
import 'package:cinemania/features/account/model/models/favorite_model.dart';

class MockAccountFirestore extends Mock implements AccountFirestore {}

class MockAccountAuth extends Mock implements AccountAuth {}

class MockAccountHive extends Mock implements AccountHive {}

void main() {
  late AccountRepository sut;
  late AccountFirestore accountFirestore;
  late AccountAuth accountAuth;
  late AccountHive accountHive;

  setUp(() {
    accountFirestore = MockAccountFirestore();
    accountAuth = MockAccountAuth();
    accountHive = MockAccountHive();

    sut = AccountRepository(
      accountFirestore: accountFirestore,
      accountAuth: accountAuth,
      accountHive: accountHive,
    );
  });

  test(
    'should trigger user delete',
    () async {
      when(() => accountAuth.getUid()).thenReturn('uid');
      when(() => accountHive.deleteUser()).thenAnswer((_) async => {});
      when(() => accountFirestore.deleteUserData(uid: any(named: 'uid')))
          .thenAnswer((_) async => {});
      when(() => accountAuth.deleteUser()).thenAnswer((_) async => {});

      await sut.deleteUser();

      verify(() => accountHive.deleteUser()).called(1);
      verify(() => accountFirestore.deleteUserData(uid: 'uid')).called(1);
      verify(() => accountAuth.deleteUser()).called(1);
    },
  );

  test(
    'should trigger password change',
    () async {
      when(() => accountAuth.changePassword(
          currentPassword: any(named: 'currentPassword'),
          newPassword: any(named: 'newPassword'))).thenAnswer((_) async => {});

      await sut.changePassword(
          currentPassword: 'currentPassword', newPassword: 'newPassword');

      verify(() => accountAuth.changePassword(
          currentPassword: any(named: 'currentPassword'),
          newPassword: any(named: 'newPassword'))).called(1);
    },
  );

  test(
    'should trigger username change',
    () async {
      when(() => accountAuth.getUid()).thenReturn('uid');
      when(() => accountFirestore.changeUsername(
          uid: any(named: 'uid'),
          username: any(named: 'username'))).thenAnswer((_) async => {});
      when(() => accountHive.changeUsername(username: any(named: 'username')))
          .thenAnswer((_) async => {});

      await sut.changeUsername(username: 'username');

      verify(() => accountFirestore.changeUsername(
          uid: any(named: 'uid'), username: any(named: 'username'))).called(1);
      verify(() => accountAuth.getUid()).called(1);
      verify(() => accountHive.changeUsername(username: any(named: 'username')))
          .called(1);
    },
  );

  test(
    'should validate user password',
    () async {
      when(() => accountAuth.validateUserPassword(
          password: any(named: 'password'))).thenAnswer((_) async => {});

      await sut.validateUserPassword(password: 'password');

      verify(() => accountAuth.validateUserPassword(
          password: any(named: 'password'))).called(1);
    },
  );

  test(
    'should trigger logout',
    () async {
      when(() => accountHive.deleteUser()).thenAnswer((_) async => {});

      await sut.logout();

      verify(() => accountHive.deleteUser()).called(1);
    },
  );

  test(
    'should save username from firebase to hive',
    () async {
      when(() => accountHive.getUid()).thenReturn('uid');
      when(() => accountFirestore.getUsername(uid: any(named: 'uid')))
          .thenAnswer((_) async => 'username');
      when(() => accountHive.saveUsername(username: any(named: 'username')))
          .thenAnswer((_) async => {});

      await sut.saveUsernameFromFirebaseToHive();

      verify(() => accountHive.getUid()).called(1);
      verify(() => accountFirestore.getUsername(uid: any(named: 'uid')))
          .called(1);
      verify(() => accountHive.saveUsername(username: any(named: 'username')))
          .called(1);
    },
  );

  test(
    'should get username',
    () async {
      when(() => accountHive.getUsername()).thenReturn('username');

      final username = sut.getUsername();

      expect(username, 'username');
    },
  );

  test(
    'should get login method',
    () async {
      when(() => accountHive.getLoginMethod()).thenReturn('login_password');

      final loginMethod = sut.getLoginMethod();

      expect(loginMethod, 'login_password');
    },
  );

  test(
    'should get favorites list',
    () async {
      final List<Map<String, dynamic>> favoriteList = [
        {
          'category': 'Category.movies',
          'id': 1,
          'name': 'Test',
          'url': 'url',
        }
      ];

      final Favorite favoriteTest = Favorite(
        category: Category.movies,
        id: 1,
        gender: 0,
        name: 'Test',
        url: 'url',
      );
      when(() => accountAuth.getUid()).thenReturn('uid');
      when(() => accountFirestore.getUserFavorites(uid: any(named: 'uid')))
          .thenAnswer(
        (_) async => favoriteList,
      );

      final List<Favorite> favorites = await sut.getFavorites();

      expect(favorites, [favoriteTest]);
    },
  );

  test(
    'should add favorite',
    () async {
      final Favorite favoriteTest = Favorite(
        category: Category.movies,
        id: 1,
        gender: 0,
        name: 'Test',
        url: 'url',
      );

      when(() => accountAuth.getUid()).thenReturn('uid');
      when(() => accountFirestore.addFavorite(
          uid: any(named: 'uid'),
          favorite: favoriteTest)).thenAnswer((_) async => {});

      await sut.addFavorite(favorite: favoriteTest);

      verify(() => accountFirestore.addFavorite(
          uid: any(named: 'uid'), favorite: favoriteTest)).called(1);
    },
  );

  test(
    'should delete favorite',
    () async {
      when(() => accountAuth.getUid()).thenReturn('uid');
      when(() => accountFirestore.deleteFavorite(
          uid: any(named: 'uid'),
          id: any(named: 'id'))).thenAnswer((_) async => {});

      await sut.deleteFavorite(id: 1);

      verify(() => accountFirestore.deleteFavorite(
          uid: any(named: 'uid'), id: any(named: 'id'))).called(1);
    },
  );

  test(
    'should update photo url',
    () async {
      when(() => accountAuth.getUid()).thenReturn('uid');
      when(() => accountFirestore.updatePhotoUrl(
          uid: any(named: 'uid'),
          newUrl: any(named: 'newUrl'),
          itemId: any(named: 'itemId'))).thenAnswer((_) async => {});

      await sut.updatePhotoUrl(itemId: 1, newUrl: 'newUrl');

      verify(() => accountFirestore.updatePhotoUrl(
          uid: any(named: 'uid'),
          newUrl: any(named: 'newUrl'),
          itemId: any(named: 'itemId'))).called(1);
    },
  );

  test(
    'should get item photo url',
    () async {
      when(() => accountAuth.getUid()).thenReturn('uid');
      when(() => accountFirestore.getItemPhotoUrl(
          uid: any(named: 'uid'),
          itemId: any(named: 'itemId'))).thenAnswer((_) async => 'url');

      final String url = await sut.getItemPhotoUrl(itemId: 1);

      expect(url, 'url');
    },
  );
}
