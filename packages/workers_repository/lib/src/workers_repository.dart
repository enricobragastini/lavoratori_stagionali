import 'package:appwrite/appwrite.dart';
import "package:appwrite_repository/appwrite_repository.dart";
import "./models/Worker.dart";

class WorkersRepository {
  final AppwriteRepository appwriteRepository = AppwriteRepository();

  WorkersRepository();

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
}
