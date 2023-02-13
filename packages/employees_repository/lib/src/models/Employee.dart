import 'package:equatable/equatable.dart';

import 'package:person_model/person_model.dart';

class Employee extends Person {
  const Employee({
    required this.id,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required this.birthday,
    required this.username,
  }) : super(
            firstname: firstname,
            lastname: lastname,
            email: email,
            phone: phone);

  final String id;
  final DateTime? birthday;
  final String username;

  Employee copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? username,
  }) {
    return Employee(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      username: username ?? this.username,
    );
  }

  static const Employee empty = Employee(
      id: '',
      firstname: '',
      lastname: '',
      email: '',
      phone: '',
      birthday: null,
      username: '');

  bool get isEmpty => this == Employee.empty;

  bool get notEmpty => this != Employee.empty;

  @override
  List<Object?> get props =>
      [id, firstname, lastname, email, phone, birthday, username];

  @override
  String toString() {
    return "$firstname $lastname ($email - $phone)";
  }
}
