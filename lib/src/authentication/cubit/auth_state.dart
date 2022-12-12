part of 'auth_cubit.dart';

enum FormStatus {
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
  final FormStatus status;

  const AuthState(
      {this.email = '',
      this.password = '',
      this.passwordVisibility = false,
      this.errorMessage,
      this.status = FormStatus.invalid});

  @override
  List<Object> get props => [email, password, status, passwordVisibility];

  AuthState copyWith({
    String? email,
    String? password,
    bool? passwordVisibility,
    String? errorMessage,
    FormStatus? status,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordVisibility: passwordVisibility ?? this.passwordVisibility,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
