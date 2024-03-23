import 'package:cinemania/features/auth/model/auth_repository.dart';
import 'package:cinemania/features/auth/model/datasources/local/auth_hive.dart';
import 'package:cinemania/features/auth/model/datasources/remote/auth_auth.dart';
import 'package:cinemania/features/auth/model/datasources/remote/auth_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthFirestore extends Mock implements AuthFirestore {}

class MockAuthAuth extends Mock implements AuthAuth {}

class MockAuthHive extends Mock implements AuthHive {}

void main() {
  late AuthRepository sut;
  late AuthFirestore authFirestore;
  late AuthAuth authAuth;
  late AuthHive authHive;

  setUp(() {
    authFirestore = MockAuthFirestore();
    authAuth = MockAuthAuth();
    authHive = MockAuthHive();

    sut = AuthRepository(
      authFirestore: authFirestore,
      authAuth: authAuth,
      authHive: authHive,
    );
  });

  test(
    'should trigger login with email and password',
    () async {
      when(() => authAuth.getUid()).thenReturn('uid');
      when(
        () => authAuth.logInWithEmailPassword(
            email: any(named: 'email'), password: any(named: 'password')),
      ).thenAnswer((_) async {});
      when(
        () => authHive.saveUser(
            uid: any(named: 'uid'),
            username: any(named: 'username'),
            loginMethod: any(named: 'loginMethod')),
      ).thenAnswer((_) async => {});

      sut.logInWithEmailPassword(email: 'email', password: 'password');

      verify(
        () => authAuth.logInWithEmailPassword(
            email: any(named: 'email'), password: any(named: 'password')),
      ).called(1);
    },
  );

  test(
    'should trigger register with email and password',
    () async {
      when(() => authAuth.getUid()).thenReturn('uid');
      when(
        () => authAuth.registerWithEmailPassword(
            email: any(named: 'email'), password: any(named: 'password')),
      ).thenAnswer((_) async {});
      when(
        () => authHive.saveUser(
            uid: any(named: 'uid'),
            username: any(named: 'username'),
            loginMethod: any(named: 'loginMethod')),
      ).thenAnswer((_) async => {});
      when(() => authFirestore.addUser(
          uid: any(named: 'uid'),
          username: any(named: 'username'))).thenAnswer((_) async => {});

      sut.registerWithEmailPassword(email: 'email', password: 'password');

      verify(
        () => authAuth.registerWithEmailPassword(
            email: any(named: 'email'), password: any(named: 'password')),
      ).called(1);
    },
  );

  test(
    'should trigger login with credential',
    () async {
      when(() => authAuth.getUid()).thenReturn('uid');
      when(
        () => authAuth.signInWithCredential(
            credential: const AuthCredential(
                providerId: '1', signInMethod: 'signInMethod')),
      ).thenAnswer((_) async {});
      when(
        () => authHive.saveUser(
            uid: any(named: 'uid'),
            username: any(named: 'username'),
            loginMethod: any(named: 'loginMethod')),
      ).thenAnswer((_) async => {});
      when(() => authFirestore.addUser(
          uid: any(named: 'uid'),
          username: any(named: 'username'))).thenAnswer((_) async => {});

      sut.signInWithCredential(
          credential: const AuthCredential(
              providerId: '1', signInMethod: 'signInMethod'),
          username: 'Test');

      verify(() => authAuth.signInWithCredential(
          credential: const AuthCredential(
              providerId: '1', signInMethod: 'signInMethod'))).called(1);
    },
  );

  test(
    'should reset auth password',
    () async {
      when(() => authAuth.resetPassword(email: any(named: 'email')))
          .thenAnswer((_) async => {});

      sut.resetPassword(email: 'email');

      verify(() => authAuth.resetPassword(email: 'email')).called(1);
    },
  );

  test(
    'should check if user is logged',
    () async {
      when(() => authHive.isUserLogged()).thenReturn(true);

      final isLogged = sut.isUserLogged();

      expect(isLogged, true);
    },
  );
}
