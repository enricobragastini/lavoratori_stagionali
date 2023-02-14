import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:lavoratori_stagionali/authentication/cubit/auth_cubit.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('AuthCubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });

    test('initial state is correct', () {
      final cubit =
          AuthCubit(authenticationRepository: authenticationRepository);
      expect(cubit.state, const AuthState());
    });

    blocTest<AuthCubit, AuthState>(
      'emits updated state when email is changed',
      build: () =>
          AuthCubit(authenticationRepository: authenticationRepository),
      act: (cubit) => cubit.emailChanged('example@example.com'),
      expect: () => const [
        AuthState(email: 'example@example.com', status: FormStatus.invalid)
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits updated state when password is changed',
      build: () =>
          AuthCubit(authenticationRepository: authenticationRepository),
      act: (cubit) => cubit.passwordChanged('password123'),
      expect: () => const [
        AuthState(password: 'password123', status: FormStatus.invalid)
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits updated state when password visibility is changed',
      build: () =>
          AuthCubit(authenticationRepository: authenticationRepository),
      act: (cubit) => cubit.passwordVisibilityChanged(),
      expect: () => const [AuthState(passwordVisibility: true)],
    );

    blocTest<AuthCubit, AuthState>(
      'emits submissionSuccess when loginWithCredentials is called with valid email and password',
      build: () {
        when(() => authenticationRepository.loginWithEmailAndPassword(
            any(), any())).thenAnswer((_) async {});
        return AuthCubit(authenticationRepository: authenticationRepository);
      },
      act: (cubit) {
        cubit.emailChanged('example@example.com');
        cubit.passwordChanged('password123');
        cubit.loginWithCredentials();
      },
      expect: () => const [
        AuthState(
            email: "example@example.com",
            password: "",
            status: FormStatus.invalid,
            passwordVisibility: false),
        AuthState(
            email: "example@example.com",
            password: "password123",
            status: FormStatus.valid,
            passwordVisibility: false),
        AuthState(
            email: "example@example.com",
            password: "password123",
            status: FormStatus.submissionSuccess,
            passwordVisibility: false)
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits submissionFailure when loginWithCredentials fails',
      build: () {
        when(() => authenticationRepository.loginWithEmailAndPassword(
            any(), any())).thenThrow(const LogInFailure('Failed to log in'));
        return AuthCubit(authenticationRepository: authenticationRepository);
      },
      act: (cubit) {
        cubit.emailChanged('example@example.com');
        cubit.passwordChanged('password123');
        cubit.loginWithCredentials();
      },
      expect: () => const [
        AuthState(
            email: "example@example.com",
            password: "",
            status: FormStatus.invalid,
            passwordVisibility: false),
        AuthState(
            email: "example@example.com",
            password: "password123",
            status: FormStatus.valid,
            passwordVisibility: false),
        AuthState(
            email: 'example@example.com',
            password: 'password123',
            status: FormStatus.submissionFailure,
            errorMessage: 'Failed to log in'),
      ],
    );
  });
}
