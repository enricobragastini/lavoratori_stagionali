// import 'dart:async';
import 'package:appwrite_repository/appwrite_repository.dart';
import 'package:appwrite/appwrite.dart';

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

class AuthenticationRepository {
  late final AppwriteRepository appwriteRepository;
  late final Client client;
  late final Account account;

  AuthenticationRepository() {
    appwriteRepository = AppwriteRepository();
    client = appwriteRepository.getClient();
    account = Account(client);
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    print("AuthRepo: login");
    try {
      await account.createEmailSession(email: email, password: password);
    } on AppwriteException catch (e) {
      throw LogInFailure(e.message!);
    }
  }
}
