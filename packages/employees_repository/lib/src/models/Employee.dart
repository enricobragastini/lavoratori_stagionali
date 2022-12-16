import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  const Employee({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.username,
  });

  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
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
