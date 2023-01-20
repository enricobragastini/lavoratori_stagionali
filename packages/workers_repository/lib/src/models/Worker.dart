import 'package:equatable/equatable.dart';

class Worker extends Equatable {
  const Worker(
      {required this.id,
      required this.firstname,
      required this.surname,
      required this.birthday,
      required this.birthplace,
      required this.nationality,
      required this.email,
      required this.phone,
      required this.address});

  final String id;
  final String firstname;
  final String surname;
  final String birthday;
  final String birthplace;
  final String nationality;
  final String email;
  final String phone;
  final String address;

  Worker copyWith({
    String? id,
    String? firstname,
    String? surname,
    String? birthday,
    String? birthplace,
    String? nationality,
    String? email,
    String? phone,
    String? address,
  }) {
    return Worker(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      surname: surname ?? this.surname,
      birthday: birthday ?? this.birthday,
      birthplace: birthplace ?? this.birthplace,
      nationality: nationality ?? this.nationality,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstname,
        surname,
        birthday,
        birthplace,
        nationality,
        email,
        phone,
        address,
      ];
}
