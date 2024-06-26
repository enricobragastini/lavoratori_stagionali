import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import "package:appwrite_api/appwrite_api.dart";

import "./models/Worker.dart";
import "./models/WorkExperience.dart";
import "./models/EmergencyContact.dart";
import "./models/Period.dart";

class WorkersException implements Exception {
  const WorkersException(
      [this.message = 'Si è verificato un errore sconosciuto!']);
  final String message;
}

class WorkersRepository {
  late final AppwriteAPI appwriteAPI;
  late final Stream<RealtimeMessage> workersStream;

  WorkersRepository({required this.appwriteAPI}) {
    workersStream = appwriteAPI.workersStream;
  }

  Future<void>? saveWorker(Worker worker) async {
    try {
      String workerID = await appwriteAPI.saveWorker(worker.id, {
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
        "locations": worker.locations,
      });

      for (WorkExperience experience in worker.workExperiences) {
        appwriteAPI.saveWorkExperience(experience.id, {
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
      }

      for (Period period in worker.periods) {
        appwriteAPI.savePeriod(period.id, {
          "start": period.start.toIso8601String(),
          "end": period.end.toIso8601String(),
          "workerID": workerID,
        });
      }

      for (EmergencyContact contact in worker.emergencyContacts) {
        appwriteAPI.saveEmergencyContact(contact.id, {
          "firstname": contact.firstname,
          "lastname": contact.lastname,
          "email": contact.email,
          "phone": contact.phone,
          "workerID": workerID
        });
      }
    } on AppwriteException catch (e) {
      throw WorkersException(e.message!);
    }
  }

  Future<List<Worker>> get workersList async {
    List<Worker> workersList = [];

    try {
      DocumentList workersDocumentList = await appwriteAPI.workersDocumentList;

      DocumentList workExperiencesDocumentList =
          await appwriteAPI.workExperiencesDocumentList;

      DocumentList periodsDocumentList = await appwriteAPI.periodsDocumentList;

      DocumentList emergencyContactsDocumentList =
          await appwriteAPI.emergencyContactsDocumentList;

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
            emergencyContacts: [],
            locations: (doc.data["locations"] as List)
                .map((item) => item as String)
                .toList(),
            periods: [],
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

      for (Document doc in periodsDocumentList.documents) {
        workersList
            .where((worker) => worker.id == doc.data["workerID"])
            .forEach((worker) => worker.periods.add(Period(
                id: doc.$id,
                start: DateTime.parse(doc.data["start"]),
                end: DateTime.parse(doc.data["end"]))));
      }

      for (Document doc in emergencyContactsDocumentList.documents) {
        workersList
            .where((worker) => worker.id == doc.data["workerID"])
            .forEach((worker) => worker.emergencyContacts.add(EmergencyContact(
                  id: doc.$id,
                  firstname: doc.data["firstname"],
                  lastname: doc.data["lastname"],
                  email: doc.data["email"],
                  phone: doc.data["phone"],
                )));
      }
    } on AppwriteException catch (e) {
      throw new WorkersException(e.message!);
    }

    return workersList;
  }

  Future<bool> deleteWorker(Worker worker) async {
    try {
      await appwriteAPI.deleteWorker(worker.id!);
      for (final exp in worker.workExperiences) {
        await appwriteAPI.deleteWorkExperience(exp.id!);
      }
      for (final period in worker.periods) {
        await appwriteAPI.deletePeriod(period.id!);
      }
      for (final contact in worker.emergencyContacts) {
        await appwriteAPI.deleteEmergencyContact(contact.id!);
      }
      return true;
    } on AppwriteException {
      throw WorkersException();
    }
  }

  Future<bool> resetWorker(Worker worker) async {
    try {
      for (final exp in worker.workExperiences) {
        await appwriteAPI.deleteWorkExperience(exp.id!);
      }
    } catch (e) {
      return false;
    }
    try {
      for (final period in worker.periods) {
        await appwriteAPI.deletePeriod(period.id!);
      }
    } catch (e) {
      return false;
    }
    try {
      for (final contact in worker.emergencyContacts) {
        await appwriteAPI.deleteEmergencyContact(contact.id!);
      }
    } catch (e) {
      return false;
    }
    return true;
  }
}
