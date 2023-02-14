import 'package:test/test.dart';
import 'package:lavoratori_stagionali/authentication/cubit/auth_cubit.dart';

void main() {
  group('AuthState', () {
    test('supports value comparison', () {
      expect(
        const AuthState(),
        const AuthState(),
      );
      expect(
        const AuthState(
            email: 'email', password: 'password', status: FormStatus.valid),
        const AuthState(
            email: 'email', password: 'password', status: FormStatus.valid),
      );
      expect(
        const AuthState(
            email: 'email', password: 'password', status: FormStatus.valid),
        isNot(const AuthState(
            email: 'different email',
            password: 'password',
            status: FormStatus.valid)),
      );
    });

    test('copyWith creates a new instance with updated fields', () {
      const state = AuthState(
          email: 'email', password: 'password', status: FormStatus.valid);
      final newState = state.copyWith(passwordVisibility: true);

      expect(state, isNot(newState));
      expect(state.email, newState.email);
      expect(state.password, newState.password);
      expect(state.status, newState.status);
      expect(state.errorMessage, newState.errorMessage);
      expect(newState.passwordVisibility, isTrue);
    });
  });
}
