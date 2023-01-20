import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppwriteRepository {
  // Id per accedere a database e collections
  final String _database_id = "63a5777a35b83decd653";
  final String _employees_collection_id = "63a5778dbd36d1734ca1";

  // Client Appwrite
  late final Client client;

  AppwriteRepository() {
    this.client = Client()
        .setEndpoint('https://127.0.0.1:4322/v1')
        .setProject('63a45ff8eecc92be3dda')
        .setSelfSigned(status: true);
  }

  // Servizio di storage di Appwrite
  Storage get storage => Storage(client);

  // Servizio di autenticazione di appwrite
  Account get account => Account(client);

  // Riceve le informazioni utente della sessione attiva
  Future<models.Account> get currentAccount async => account.get();

  // Recupera dal database le informazioni di un Employee dato il suo userId
  Future<Map<String, dynamic>> getEmployeeDocument(String userId) async {
    Databases database = Databases(client);

    models.DocumentList docs = await database.listDocuments(
        // Query al db
        databaseId: _database_id,
        collectionId: _employees_collection_id,
        queries: [Query.equal("user_id", userId)]);

    return docs.documents[0].data;
  }

  // Stabilisce se c'è una sessione aperta
  Future<bool> get isSessionActive async {
    try {
      await account.get();
      return true;
    } on AppwriteException catch (e) {
      return false;
    }
  }
}
