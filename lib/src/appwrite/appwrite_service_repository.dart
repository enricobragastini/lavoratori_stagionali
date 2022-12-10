import 'package:appwrite/appwrite.dart';

class AppwriteServiceRepository {
  Client getClient() {
    Client client = Client()
        .setEndpoint('http://localhost/v1')
        .setProject('63934922910ffd76d406')
        .setSelfSigned(status: true);
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
