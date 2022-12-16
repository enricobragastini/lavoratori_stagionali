// import 'dart:async';
import 'dart:async';

import 'package:appwrite_repository/appwrite_repository.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:employees_repository/employees_repository.dart' show Employee;

class LogInFailure implements Exception {
  const LogInFailure([
    this.message = 'Si è verificato un errore sconosciuto!',
  ]);

  final String message;
}

enum AuthenticationStatus { authenticated, unauthenticated }

class AuthenticationRepository {
  final AppwriteRepository appwriteRepository = AppwriteRepository();
  late final Client client;
  late final Account account;
  late Employee loggedInEmployee;
  final controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository() {
    client = appwriteRepository.client;
    account = appwriteRepository.accountService;
    loggedInEmployee = Employee.empty;
    controller.add(AuthenticationStatus.unauthenticated);

    appwriteRepository.isSessionActive.then((isSessionActive) {
      print(isSessionActive);
      if (isSessionActive) {
        appwriteRepository.currentAccount.then((value) => print(value.$id));
        appwriteRepository.currentAccount.then((account) {
          _updateCurrentEmployee(account);
        });
      }
    });
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      models.Session session =
          await account.createEmailSession(email: email, password: password);

      _updateCurrentEmployee(await appwriteRepository.currentAccount);
    } on AppwriteException catch (e) {
      loggedInEmployee = Employee.empty;

      controller.add(AuthenticationStatus.unauthenticated);

      throw LogInFailure(e.message!);
    }
  }

  void _updateCurrentEmployee(models.Account account) async {
    Map<String, dynamic> userDocument =
        await appwriteRepository.getEmployeeDocument(account.$id);

    String username = account.name;
    String email = account.email;

    loggedInEmployee = Employee(
      id: account.$id,
      firstname: userDocument["firstname"],
      lastname: userDocument["lastname"],
      email: email,
      phone: userDocument["phone"],
      birthday: DateTime.parse(userDocument["birthday"]),
      username: username,
    );
    controller.add(AuthenticationStatus.authenticated);
  }

  Future<bool> logout() async {
    try {
      appwriteRepository.accountService.deleteSession(sessionId: "current");
      this.loggedInEmployee = Employee.empty;
      return true;
    } on AppwriteRepository {
      return false;
    }
  }

  Stream<AuthenticationStatus> get stream => controller.stream;

  void dispose() => controller.close();
}
