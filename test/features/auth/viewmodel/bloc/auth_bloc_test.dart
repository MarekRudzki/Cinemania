import 'package:bloc_test/bloc_test.dart';
import 'package:cinemania/features/auth/model/auth_repository.dart';
import 'package:cinemania/features/auth/viewmodel/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc sut;
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    sut = AuthBloc(authRepository: authRepository);
  });

  group('Login - ', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthError] and [AuthInitial] when LoginButtonPressed is added without data.',
      build: () => sut,
      act: (bloc) => bloc.add(LoginButtonPressed(email: '', password: '')),
      expect: () => [
        AuthLoading(),
        AuthError(errorMessage: 'Please fill in all fields'),
        AuthInitial(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthError] and [AuthInitial] when LoginButtonPressed is added without email.',
      build: () => sut,
      act: (bloc) =>
          bloc.add(LoginButtonPressed(email: '', password: 'password')),
      expect: () => [
        AuthLoading(),
        AuthError(errorMessage: 'Please fill in all fields'),
        AuthInitial(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthError] and [AuthInitial] when LoginButtonPressed is added without password.',
      build: () => sut,
      act: (bloc) => bloc.add(LoginButtonPressed(email: 'email', password: '')),
      expect: () => [
        AuthLoading(),
        AuthError(errorMessage: 'Please fill in all fields'),
        AuthInitial(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthSuccess] and [AuthInitial] when LoginButtonPressed is added with proper data.',
      build: () {
        when(() => authRepository.logInWithEmailPassword(
            email: any(named: 'email'),
            password: any(named: 'password'))).thenAnswer((_) async => {});
        return sut;
      },
      act: (bloc) =>
          bloc.add(LoginButtonPressed(email: 'email', password: 'password')),
      expect: () => [
        AuthLoading(),
        AuthSuccess(),
        AuthInitial(),
      ],
    );
  });

  group('Register - ', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthError] and [AuthInitial] when RegisterButtonPressed is added without data.',
      build: () => sut,
      act: (bloc) => bloc.add(RegisterButtonPressed(email: '', password: '')),
      expect: () => [
        AuthLoading(),
        AuthError(errorMessage: 'Please fill in all fields'),
        AuthInitial(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthError] and [AuthInitial] when RegisterButtonPressed is added without email.',
      build: () => sut,
      act: (bloc) =>
          bloc.add(RegisterButtonPressed(email: '', password: 'password')),
      expect: () => [
        AuthLoading(),
        AuthError(errorMessage: 'Please fill in all fields'),
        AuthInitial(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthError] and [AuthInitial] when RegisterButtonPressed is added without password.',
      build: () => sut,
      act: (bloc) =>
          bloc.add(RegisterButtonPressed(email: 'email', password: '')),
      expect: () => [
        AuthLoading(),
        AuthError(errorMessage: 'Please fill in all fields'),
        AuthInitial(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthSuccess] and [AuthInitial] when RegisterButtonPressed is added with proper data.',
      build: () {
        when(() => authRepository.registerWithEmailPassword(
            email: any(named: 'email'),
            password: any(named: 'password'))).thenAnswer((_) async => {});
        return sut;
      },
      act: (bloc) =>
          bloc.add(RegisterButtonPressed(email: 'email', password: 'password')),
      expect: () => [
        AuthLoading(),
        AuthSuccess(),
        AuthInitial(),
      ],
    );
  });

  group('Password reset - ', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthError] and [AuthInitial] when PasswordResetPressed is added without password.',
      build: () => sut,
      act: (bloc) => bloc.add(PasswordResetPressed(passwordResetEmail: '')),
      expect: () => [
        AuthLoading(),
        AuthError(errorMessage: 'Field is empty'),
        AuthInitial(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading], [AuthSuccess] and [AuthInitial] when PasswordResetPressed is added with proper data.',
      build: () {
        when(() => authRepository.resetPassword(email: any(named: 'email')))
            .thenAnswer((_) async => {});
        return sut;
      },
      act: (bloc) => bloc
          .add(PasswordResetPressed(passwordResetEmail: 'passwordResetEmail')),
      expect: () => [
        AuthLoading(),
        AuthSuccess(),
        AuthInitial(),
      ],
    );
  });

  test(
    'should check if user is logged',
    () async {
      when(() => authRepository.isUserLogged()).thenReturn(true);

      final isLogged = sut.isUserLogged();

      expect(isLogged, true);
    },
  );
}
