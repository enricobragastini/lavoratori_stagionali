import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:employees_repository/employees_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers_repository/workers_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  AppBloc(
      {required AuthenticationRepository authenticationRepository,
      required this.workersRepository})
      // ignore: prefer_initializing_formals
      : authenticationRepository = authenticationRepository,
        super(const AppState.unknown()) {
    on<AppAuthenticationStatusChanged>(_authenticationStatusChanged);
    on<AppLogoutRequested>(_onAppLogOutRequested);
    authenticationStreamSubscription = authenticationRepository.stream
        .listen((status) => add(AppAuthenticationStatusChanged(status)));
  }

  final AuthenticationRepository authenticationRepository;
  final WorkersRepository workersRepository;
  late StreamSubscription<AuthenticationStatus>
      authenticationStreamSubscription;

  Future<void> _authenticationStatusChanged(
      AppAuthenticationStatusChanged event, Emitter<AppState> emit) async {
    print("_goRouterRedirect triggered: ${event.status}");
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AppState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final employee = _tryGetEmployee();
        print(authenticationRepository.loggedInEmployee);
        return emit(
          employee != null
              ? AppState.authenticated(employee)
              : const AppState.unauthenticated(),
        );
    }
  }

  void _onAppLogOutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    authenticationRepository.logout();
    emit(const AppState.unauthenticated());
  }

  Employee? _tryGetEmployee() {
    if (authenticationRepository.loggedInEmployee != Employee.empty) {
      return authenticationRepository.loggedInEmployee;
    } else {
      return null;
    }
  }
}
