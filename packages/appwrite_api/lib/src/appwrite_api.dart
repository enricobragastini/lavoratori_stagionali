import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppwriteAPI {
  // Id per accedere a database e collections
  final String _database_id = "63d6895b934434b4966a";
  final String _employees_collection_id = "63d689659673376c728e";
  final String _workers_collection_id = "63d6896c220160c60b82";
  final String _workExperiences_collection_id = "63d6ef5b0ded6e3bfaec";
  final String _periods_collection_id = "63e2bf32bcfb1bcc0b4c";
  final String _emergencyContacts_collection_id = "63e23d327b3f2b585fe3";

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

  AppwriteAPI() {
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

  Future<String> saveWorker(
      String? id, Map<String, dynamic> workerRawData) async {
    return (await upsert(
            databaseId: _database_id,
            collectionId: _workers_collection_id,
            documentId: id == null ? "unique()" : id,
            data: workerRawData))
        .$id;
  }

  Future<String> saveWorkExperience(
      String? id, Map<String, dynamic> experienceRawData) async {
    return (await upsert(
            databaseId: _database_id,
            collectionId: _workExperiences_collection_id,
            documentId: id == null ? "unique()" : id,
            data: experienceRawData))
        .$id;
  }

  Future<String> savePeriod(
      String? id, Map<String, dynamic> periodRawData) async {
    return (await upsert(
            databaseId: _database_id,
            collectionId: _periods_collection_id,
            documentId: id == null ? "unique()" : id,
            data: periodRawData))
        .$id;
  }

  Future<String> saveEmergencyContact(
      String? id, Map<String, dynamic> emergencyContactRawData) async {
    return (await upsert(
            databaseId: _database_id,
            collectionId: _emergencyContacts_collection_id,
            documentId: id == null ? "unique()" : id,
            data: emergencyContactRawData))
        .$id;
  }

  Future<void> deleteWorker(String documentId) async {
    database.deleteDocument(
        databaseId: _database_id,
        collectionId: _workers_collection_id,
        documentId: documentId);
  }

  Future<void> deleteWorkExperience(String documentId) async {
    database.deleteDocument(
        databaseId: _database_id,
        collectionId: _workExperiences_collection_id,
        documentId: documentId);
  }

  Future<void> deletePeriod(String documentId) async {
    database.deleteDocument(
        databaseId: _database_id,
        collectionId: _periods_collection_id,
        documentId: documentId);
  }

  Future<void> deleteEmergencyContact(String documentId) async {
    database.deleteDocument(
        databaseId: _database_id,
        collectionId: _emergencyContacts_collection_id,
        documentId: documentId);
  }

  Future<models.DocumentList> get workersDocumentList async {
    return database.listDocuments(
        databaseId: _database_id,
        collectionId: _workers_collection_id,
        queries: []);
  }

  Future<models.DocumentList> get workExperiencesDocumentList async {
    return database.listDocuments(
        databaseId: _database_id,
        collectionId: _workExperiences_collection_id,
        queries: []);
  }

  Future<models.DocumentList> get periodsDocumentList async {
    return database.listDocuments(
        databaseId: _database_id,
        collectionId: _periods_collection_id,
        queries: []);
  }

  Future<models.DocumentList> get emergencyContactsDocumentList async {
    return database.listDocuments(
        databaseId: _database_id,
        collectionId: _emergencyContacts_collection_id,
        queries: []);
  }

  Stream<RealtimeMessage> get workersStream => workersSubscription.stream;

  Future<models.Document> upsert(
      {required String databaseId,
      required String collectionId,
      required String documentId,
      required Map<String, dynamic> data}) async {
    try {
      return await database.createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
          data: data);
    } on AppwriteException catch (e) {
      if (e.code == 409) {
        return await database.updateDocument(
            databaseId: databaseId,
            collectionId: collectionId,
            documentId: documentId,
            data: data);
      } else {
        rethrow;
      }
    }
  }
}
