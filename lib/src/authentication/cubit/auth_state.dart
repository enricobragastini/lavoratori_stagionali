part of 'auth_cubit.dart';

enum FormState {
  invalid,
  valid,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool passwordVisibility;
  final String? errorMessage;
  final FormState formState;

  const AuthState(
      {this.email = '',
      this.password = '',
      this.passwordVisibility = false,
      this.errorMessage,
      this.formState = FormState.invalid});

  @override
  List<Object> get props => [email, password, passwordVisibility];

  AuthState copyWith({
    String? email,
    String? password,
    bool? passwordVisibility,
    String? errorMessage,
    FormState? formState,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordVisibility: passwordVisibility ?? this.passwordVisibility,
      errorMessage: errorMessage ?? this.errorMessage,
      formState: formState ?? this.formState,
    );
  }
}
