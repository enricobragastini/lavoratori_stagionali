import 'package:equatable/equatable.dart';
import 'package:person_model/person_model.dart';

import './EmergencyContact.dart';
import './WorkExperience.dart';
import './Period.dart';

class Worker extends Person {
  Worker(
      {this.id,
      required String firstname,
      required String lastname,
      required this.birthday,
      required this.birthplace,
      required this.nationality,
      required String email,
      required String phone,
      required this.address,
      required this.workExperiences,
      required this.emergencyContacts,
      required this.languages,
      required this.licenses,
      required this.locations,
      required this.periods,
      required this.withOwnCar})
      : super(
            firstname: firstname,
            lastname: lastname,
            phone: phone,
            email: email);

  final String? id;
  final DateTime birthday;
  final String birthplace;
  final String nationality;
  final String address;

  final List<WorkExperience> workExperiences;
  final List<EmergencyContact> emergencyContacts;
  final List<String> languages;
  final List<String> licenses;
  final List<String> locations;
  final List<Period> periods;
  final bool withOwnCar;

  Worker copyWith(
      {String? id,
      String? firstname,
      String? surname,
      DateTime? birthday,
      String? birthplace,
      String? nationality,
      String? email,
      String? phone,
      String? address,
      List<WorkExperience>? workExperiences,
      List<EmergencyContact>? emergencyContacts,
      List<String>? languages,
      List<String>? licenses,
      List<String>? locations,
      List<Period>? periods,
      bool? withOwnCar}) {
    return Worker(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: surname ?? this.lastname,
        birthday: birthday ?? this.birthday,
        birthplace: birthplace ?? this.birthplace,
        nationality: nationality ?? this.nationality,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        workExperiences: workExperiences ?? this.workExperiences,
        emergencyContacts: emergencyContacts ?? this.emergencyContacts,
        languages: languages ?? this.languages,
        licenses: licenses ?? this.licenses,
        locations: locations ?? this.locations,
        periods: periods ?? this.periods,
        withOwnCar: withOwnCar ?? this.withOwnCar);
  }

  List<String> get allTasks {
    List<String> allTasks = [];
    for (var wp in workExperiences) {
      allTasks.addAll(wp.tasks);
    }
    return allTasks;
  }

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        birthday,
        birthplace,
        nationality,
        email,
        phone,
        address,
        workExperiences,
        emergencyContacts,
        languages,
        licenses,
        locations,
        periods,
        withOwnCar
      ];
}
