import 'package:equatable/equatable.dart';

abstract class Person implements Equatable {
  final String firstname;
  final String lastname;
  final String phone;
  final String email;

  Person(
      {required this.firstname,
      required this.lastname,
      required this.phone,
      required this.email});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [firstname, lastname, phone, email];
}
