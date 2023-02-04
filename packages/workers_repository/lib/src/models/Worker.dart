import 'package:equatable/equatable.dart';

import './WorkExperience.dart';

class Worker extends Equatable {
  const Worker(
      {this.id,
      required this.firstname,
      required this.lastname,
      required this.birthday,
      required this.birthplace,
      required this.nationality,
      required this.email,
      required this.phone,
      required this.address,
      required this.workExperiences});

  final String? id;
  final String firstname;
  final String lastname;
  final DateTime birthday;
  final String birthplace;
  final String nationality;
  final String email;
  final String phone;
  final String address;

  final List<WorkExperience> workExperiences;

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
      List<WorkExperience>? workExperiences}) {
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
        workExperiences: workExperiences ?? this.workExperiences);
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
        workExperiences
      ];
}
