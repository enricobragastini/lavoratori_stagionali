import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppwriteRepository {
  // Id per accedere a database e collections
  final String _database_id = "63d6895b934434b4966a";
  final String _employees_collection_id = "63d689659673376c728e";
  final String _workers_collection_id = "63d6896c220160c60b82";
  final String _workExperiences_collection_id = "63d6ef5b0ded6e3bfaec";

  // Client Appwrite
  late final Client client;

  // Servizi offerti da Appwrite
  late final Account account;
  late final Storage storage;
  late final Databases database;
  late final Realtime realtime;

  // Realtime Subscriptions
  late final RealtimeSubscription workersSubscription;
  late final RealtimeSubscription accountSubscription;

  AppwriteRepository() {
    this.client = Client()
        .setEndpoint('http://139.144.74.141/v1')
        .setProject('63d68840443d59c7b008')
        .setSelfSigned(status: true);

    this.account = Account(this.client);
    this.storage = Storage(this.client);
    this.database = Databases(this.client);
    this.realtime = Realtime(this.client);

    this.workersSubscription = realtime.subscribe(["documents"]);
    // this.accountSubscription = realtime.subscribe(["account"]);
  }

  // Riceve le informazioni utente della sessione attuale
  // Se fallisce -> Non c'è una sessione aperta
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

  Future<void> saveWorker(Map<dynamic, dynamic> workerRawData) async {
    database.createDocument(
        databaseId: _database_id,
        collectionId: _workers_collection_id,
        documentId: "unique()",
        data: workerRawData);
  }

  Future<void> saveWorkExperiences(
      List<Map<dynamic, dynamic>> experiencesRawData) async {
    for (Map<dynamic, dynamic> experience in experiencesRawData) {
      database.createDocument(
          databaseId: _database_id,
          collectionId: _workExperiences_collection_id,
          documentId: "unique()",
          data: experience);
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
