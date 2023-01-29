// import 'dart:async';
import 'dart:async';

import 'package:appwrite_repository/appwrite_repository.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:employees_repository/employees_repository.dart' show Employee;

// Custom Exception in caso di fallimento del login
class LogInFailure implements Exception {
  const LogInFailure([
    this.message = 'Si è verificato un errore sconosciuto!',
  ]);

  final String message;
}

// Possibili stati di autenticazione
enum AuthenticationStatus { authenticated, unauthenticated }

class AuthenticationRepository {
  late final AppwriteRepository appwriteRepository;
  late Employee loggedInEmployee;

  // StreamController
  // Fa uno streaming dello stato dell'autenticazione
  final controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository({required this.appwriteRepository}) {
    loggedInEmployee = Employee.empty;
    controller.add(AuthenticationStatus.unauthenticated);

    appwriteRepository.isSessionActive.then((active) {
      if (active) {
        // Se all'avvio c'è una sessione attiva
        // Recupera le informazioni sull'utente autenticato
        appwriteRepository.currentAccount.then((account) {
          updateCurrentEmployee(account);
          controller.add(AuthenticationStatus.authenticated);
        });
      }
    });
  }

  // Funzione per il login con email e password
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await appwriteRepository.account
          .createEmailSession(email: email, password: password);
      print("CreateEmailSession: ${await appwriteRepository.isSessionActive}");
      updateCurrentEmployee(await appwriteRepository.currentAccount);

      if (await appwriteRepository.isSessionActive) {
        controller.add(AuthenticationStatus.authenticated);
      }
    } on AppwriteException catch (e) {
      loggedInEmployee = Employee.empty;
      controller.add(AuthenticationStatus.unauthenticated);
      throw LogInFailure(e.message!);
    }
  }

  // Funzione che imposta i dati dell'utente autenticato
  void updateCurrentEmployee(models.Account account) async {
    // Recupera le info dal database
    Map<String, dynamic> userDocument =
        await appwriteRepository.getEmployeeDocument(account.$id);

    loggedInEmployee = Employee(
      id: account.$id,
      firstname: userDocument["firstname"],
      lastname: userDocument["lastname"],
      email: account.email,
      phone: userDocument["phone"],
      birthday: DateTime.parse(userDocument["birthday"]),
      username: account.name,
    );
  }

  Future<bool> ensureLoggedIn() async {
    return await appwriteRepository.isSessionActive;
  }

  // Funzione per il logout
  // Elimina la sessione e le info utente
  Future<bool> logout() async {
    try {
      appwriteRepository.account.deleteSession(sessionId: "current");
      this.loggedInEmployee = Employee.empty;
      return true;
    } on AppwriteException {
      return false;
    }
  }

  // Stream dello stato di autenticazione
  Stream<AuthenticationStatus> get stream => controller.stream;

  void dispose() => controller.close();
}
