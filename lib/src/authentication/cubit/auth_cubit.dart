import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void emailChanged(String newEmail) {
    emit(state.copyWith(
        email: newEmail,
        formState: (state.password != '' && newEmail != '')
            ? FormState.valid
            : FormState.invalid));
  }

  void passwordChanged(String newPassword) {
    emit(state.copyWith(
        password: newPassword,
        formState: (state.email != '' && newPassword != '')
            ? FormState.valid
            : FormState.invalid));
  }

  void passwordVisibilityChanged() {
    emit(
      state.copyWith(passwordVisibility: !state.passwordVisibility),
    );
  }
}
