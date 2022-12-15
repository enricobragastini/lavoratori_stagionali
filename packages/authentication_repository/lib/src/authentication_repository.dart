// import 'dart:async';
import 'dart:async';

import 'package:appwrite_repository/appwrite_repository.dart';
import 'package:appwrite/appwrite.dart';
import 'package:rxdart/rxdart.dart';
import 'package:appwrite/models.dart' as models;
import 'package:employees_repository/employees_repository.dart' show Employee;

class LogInFailure implements Exception {
  const LogInFailure([
    this.message = 'Si è verificato un errore sconosciuto!',
  ]);

  factory LogInFailure.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return const LogInFailure(
          'Email/Username o password non corretta.',
        );
      default:
        return const LogInFailure();
    }
  }

  final String message;
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  late final AppwriteRepository appwriteRepository;
  late final Client client;
  late final Account account;
  late Employee loggedInEmployee;
  final controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository() {
    appwriteRepository = AppwriteRepository();
    client = appwriteRepository.client;
    account = appwriteRepository.accountService;
    loggedInEmployee = Employee.empty;
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      models.Session session =
          await account.createEmailSession(email: email, password: password);

      Map<String, dynamic> userDocument =
          await appwriteRepository.getEmployeeDocument(session.userId);

      String username = (await appwriteRepository.currentAccount).name;

      print("session_userId: ${session.userId}");

      loggedInEmployee = Employee(
        id: session.userId,
        firstname: userDocument["firstname"],
        lastname: userDocument["lastname"],
        email: email,
        phone: userDocument["phone"],
        birthday: DateTime.parse(userDocument["birthday"]),
        username: username,
      );
      controller.add(AuthenticationStatus.authenticated);
    } on AppwriteException catch (e) {
      loggedInEmployee = Employee.empty;
      controller.add(AuthenticationStatus.authenticated);
      throw LogInFailure(e.message!);
    }
  }

  Employee get currentEmployee => loggedInEmployee;

  Stream<AuthenticationStatus> get stream => controller.stream;

  void dispose() => controller.close();
}
