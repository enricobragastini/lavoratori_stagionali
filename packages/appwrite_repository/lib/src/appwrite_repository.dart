import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppwriteRepository {
  final String _database_id = "63934940ad64e6c0c116";
  final String _employees_collection_id = "6393495fd3f61c7eaef0";
  late final Client client;

  AppwriteRepository() {
    this.client = Client()
        .setEndpoint('https://127.0.0.1/v1')
        .setProject('63934922910ffd76d406')
        .setSelfSigned();
  }

  Storage get storage => Storage(client);

  Account get accountService => Account(client);

  Future<models.Account> get currentAccount async => accountService.get();

  Future<models.Session> get currentSession async =>
      accountService.getSession(sessionId: "current");

  Future<Map<String, dynamic>> getEmployeeDocument(String userId) async {
    Databases database = Databases(client);

    models.DocumentList docs = await database.listDocuments(
        databaseId: _database_id,
        collectionId: _employees_collection_id,
        queries: [Query.equal("user_id", userId)]);

    return docs.documents[0].data;
  }

  Future<bool> get isSessionActive async {
    try {
      await accountService.get();
      return true;
    } on AppwriteException catch (e) {
      return false;
    }
  }
}
