import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import "package:appwrite_repository/appwrite_repository.dart";
import "./models/Worker.dart";
import "./models/WorkExperience.dart";

import 'package:intl/intl.dart';

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

  Future<void> saveWorker(Worker worker) async {
    try {
      String workerID = await appwriteRepository.saveWorker({
        "firstname": worker.firstname,
        "lastname": worker.lastname,
        "birthday": worker.birthday.toIso8601String(),
        "birthplace": worker.birthplace,
        "nationality": worker.nationality,
        "email": worker.email,
        "phone": worker.phone,
        "address": worker.address,
        "licenses": worker.licenses,
        "languages": worker.languages,
        "withOwnCar": worker.withOwnCar,
      });

      List<Map<dynamic, dynamic>> rawExperiencesDataList = [];
      for (WorkExperience experience in worker.workExperiences) {
        rawExperiencesDataList.add({
          "title": experience.title,
          "start": experience.start.toIso8601String(),
          "end": experience.end.toIso8601String(),
          "companyName": experience.companyName,
          "tasks": experience.tasks,
          "notes": experience.notes,
          "workplace": experience.workplace,
          "dailyPay": experience.dailyPay,
          "workerID": workerID,
        });
        await appwriteRepository.saveWorkExperiences(rawExperiencesDataList);
      }
    } on Exception {
      throw WorkersException();
    }
  }

  Future<List<Worker>> get workersList async {
    List<Worker> workersList = [];

    try {
      DocumentList workersDocumentList =
          await appwriteRepository.workersDocumentList;

      DocumentList workExperiencesDocumentList =
          await appwriteRepository.workExperiencesDocumentList;

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
            workExperiences: [],
            languages: (doc.data["languages"] as List)
                .map((item) => item as String)
                .toList(),
            licenses: (doc.data["licenses"] as List)
                .map((item) => item as String)
                .toList(),
            withOwnCar: (doc.data["withOwnCar"] != null)
                ? doc.data["withOwnCar"]
                : false));
      }

      for (Document doc in workExperiencesDocumentList.documents) {
        workersList
            .where((worker) => worker.id == doc.data["workerID"])
            .forEach((worker) => worker.workExperiences.add(WorkExperience(
                  id: doc.$id,
                  title: doc.data["title"],
                  start: DateTime.parse(doc.data["start"]),
                  end: DateTime.parse(doc.data["end"]),
                  companyName: doc.data["companyName"],
                  tasks: (doc.data["tasks"] as List)
                      .map((item) => item as String)
                      .toList(),
                  notes: doc.data["notes"],
                  workplace: doc.data["workplace"],
                  dailyPay: doc.data["dailyPay"] is int
                      ? (doc.data["dailyPay"] as int).toDouble()
                      : (doc.data["dailyPay"] as double),
                )));
      }
    } on AppwriteException catch (e) {
      throw new WorkersException(e.message!);
    }

    return workersList;
  }

  Future<bool> deleteWorker(Worker worker) async {
    try {
      await appwriteRepository.deleteWorker(worker.id!);
      for (WorkExperience exp in worker.workExperiences) {
        appwriteRepository.deleteWorkExperience(exp.id!);
      }
      return true;
    } on AppwriteException {
      throw WorkersException();
    }
  }
}
