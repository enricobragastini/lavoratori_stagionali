import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppwriteRepository {
  // Id per accedere a database e collections
  final String _database_id = "63d6895b934434b4966a";
  final String _employees_collection_id = "63d689659673376c728e";
  final String _workers_collection_id = "63d6896c220160c60b82";

  // Client Appwrite
  late final Client client;
  late final Account account;
  late final Storage storage;
  late final Databases database;
  late final Realtime realtime;

  // Workers Realtime Subscription
  late final RealtimeSubscription workersSubscription;

  AppwriteRepository() {
    this.client = Client()
        .setEndpoint('http://139.144.74.141/v1')
        .setProject('63d68840443d59c7b008')
        .setSelfSigned(status: true);
    this.account = Account(client);
    this.storage = Storage(client);
    this.database = Databases(this.client);
    this.realtime = Realtime(this.client);
    this.workersSubscription = realtime.subscribe(["documents"]);
  }

/*   // Servizio di storage di Appwrite
  Storage get storage => Storage(client);

  // Servizio di autenticazione di appwrite
  Account get account => Account(client); */

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
      await account.getSession(sessionId: 'current');
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
    isSessionActive.then(
        (value) => print("workersDocumentList-> isSessionActive: $value"));
    return database.listDocuments(
        databaseId: _database_id,
        collectionId: _workers_collection_id,
        queries: []);
  }

  Stream<RealtimeMessage> get workersStream => workersSubscription.stream;
}
