import 'package:appwrite/appwrite.dart';

class AppwriteRepository {
  AppwriteRepository() {}

  Client getClient() {
    Client client = Client()
        .setEndpoint('https://127.0.0.1/v1')
        .setProject('63934922910ffd76d406')
        .setSelfSigned();
    return client;
  }

  Storage getStorage() {
    Storage storage = Storage(getClient());
    return storage;
  }

  Account getAccountService() {
    Account accountService = Account(getClient());
    return accountService;
  }
}
