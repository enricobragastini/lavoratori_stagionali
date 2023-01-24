import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppwriteRepository {
  // Id per accedere a database e collections
  final String _database_id = "63a5777a35b83decd653";
  final String _employees_collection_id = "63a5778dbd36d1734ca1";
  final String _workers_collection_id = "63cc4b176d8d88961b74";

  // Client Appwrite
  late final Client client;
  late final Databases database;
  late final Realtime realtime;

  // Workers Realtime Subscription
  late final RealtimeSubscription workersSubscription;

  AppwriteRepository() {
    this.client = Client()
        .setEndpoint('https://127.0.0.1:4322/v1')
        .setProject('63a45ff8eecc92be3dda')
        .setSelfSigned(status: true);
    this.database = Databases(this.client);
    this.realtime = Realtime(this.client);
    this.workersSubscription = realtime.subscribe(["documents"]);
  }

  // Servizio di storage di Appwrite
  Storage get storage => Storage(client);

  // Servizio di autenticazione di appwrite
  Account get account => Account(client);

  // Riceve le informazioni utente della sessione attiva
  Future<models.Account> get currentAccount async => account.get();

  // Recupera dal database le informazioni di un Employee dato il suo userId
  Future<Map<String, dynamic>> getEmployeeDocument(String userId) async {
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
    } on AppwriteException {
      return false;
    }
  }

  Future<bool> saveWorker(Map<dynamic, dynamic> rawData) async {
    try {
      print(rawData);
      database.createDocument(
          databaseId: _database_id,
          collectionId: _workers_collection_id,
          documentId: "unique()",
          data: rawData);
      return true;
    } on AppwriteException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteWorker(String documentId) async {
    try {
      database.deleteDocument(
          databaseId: _database_id,
          collectionId: _workers_collection_id,
          documentId: documentId);
      return true;
    } on AppwriteRepository catch (e) {
      print(e);
      return false;
    }
  }

  Future<models.DocumentList> get workersDocumentList async {
    return database.listDocuments(
        databaseId: _database_id,
        collectionId: _workers_collection_id,
        queries: []);
  }

  Stream<RealtimeMessage> get workersStream => workersSubscription.stream;
}
