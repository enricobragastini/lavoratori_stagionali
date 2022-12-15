import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:employees_repository/employees_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : authenticationRepository = authenticationRepository,
        super(const AppState.unknown()) {
    on<AppAuthenticationStatusChanged>(_authenticationStatusChanged);
    authenticationStreamSubscription = authenticationRepository.stream
        .listen((status) => add(AppAuthenticationStatusChanged(status)));
  }

  final AuthenticationRepository authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      authenticationStreamSubscription;

  Future<void> _authenticationStatusChanged(
      AppAuthenticationStatusChanged event, Emitter<AppState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AppState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final employee = _tryGetEmployee();
        return emit(
          employee != null
              ? AppState.authenticated(employee)
              : const AppState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(const AppState.unknown());
    }
  }

  Employee? _tryGetEmployee() {
    if (authenticationRepository.currentEmployee != Employee.empty) {
      return authenticationRepository.currentEmployee;
    } else {
      return null;
    }
  }
}
