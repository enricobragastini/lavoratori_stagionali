import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authenticationRepository})
      : super(const AuthState());

  final AuthenticationRepository authenticationRepository;

  void emailChanged(String newEmail) {
    emit(state.copyWith(
        email: newEmail,
        status: (state.password != '' && newEmail != '')
            ? FormStatus.valid
            : FormStatus.invalid));
  }

  void passwordChanged(String newPassword) {
    emit(state.copyWith(
        password: newPassword,
        status: (state.email != '' && newPassword != '')
            ? FormStatus.valid
            : FormStatus.invalid));
  }

  void passwordVisibilityChanged() {
    emit(
      state.copyWith(passwordVisibility: !state.passwordVisibility),
    );
  }

  void loginWithCredentials() async {
    if (state.status != FormStatus.valid) return;
    try {
      await authenticationRepository.loginWithEmailAndPassword(
          state.email, state.password);
      emit(state.copyWith(status: FormStatus.submissionSuccess));
    } on LogInFailure catch (e) {
      emit(state.copyWith(
          status: FormStatus.submissionFailure, errorMessage: e.message));
    }
  }
}
