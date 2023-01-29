import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import "package:appwrite_repository/appwrite_repository.dart";
import "./models/Worker.dart";

class WorkersException implements Exception {
  const WorkersException(
      [this.message = 'Si è verificato un errore sconosciuto!']);
  final String message;
}

class WorkersRepository {
  late final AppwriteRepository appwriteRepository;
  late final Stream<RealtimeMessage> workersStream;

  WorkersRepository({required this.appwriteRepository}) {
    workersStream = appwriteRepository.workersStream;
  }

  Future<bool> saveWorker(Worker worker) async {
    return appwriteRepository.saveWorker({
      "firstname": worker.firstname,
      "lastname": worker.lastname,
      "birthday": worker.birthday.toIso8601String(),
      "birthplace": worker.birthplace,
      "nationality": worker.nationality,
      "email": worker.email,
      "phone": worker.phone,
      "address": worker.address,
    });
  }

  Future<List<Worker>> get workersList async {
    List<Worker> workersList = [];

    try {
      DocumentList workersDocumentList =
          await appwriteRepository.workersDocumentList;

      for (Document doc in workersDocumentList.documents) {
        workersList.add(Worker(
          id: doc.$id,
          firstname: doc.data["firstname"],
          lastname: doc.data["lastname"],
          birthday: DateTime.parse(doc.data["birthday"]),
          birthplace: doc.data["birthplace"],
          nationality: doc.data["nationality"],
          email: doc.data["email"],
          phone: doc.data["phone"],
          address: doc.data["address"],
        ));
      }
    } on AppwriteException catch (e) {
      throw new WorkersException(e.message!);
    }

    return workersList;
  }

  Future<bool> deleteWorker(Worker worker) async {
    return (await appwriteRepository.deleteWorker(worker.id!));
  }
}
