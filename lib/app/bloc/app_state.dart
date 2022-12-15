part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    this.status = AuthenticationStatus.unknown,
    this.employee = Employee.empty,
  });

  const AppState.unknown() : this._();

  const AppState.authenticated(Employee employee)
      : this._(status: AuthenticationStatus.authenticated, employee: employee);

  const AppState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final Employee employee;

  @override
  List<Object> get props => [status, employee];
}
