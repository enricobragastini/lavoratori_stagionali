import 'package:person_model/person_model.dart';

class EmergencyContact extends Person {
  EmergencyContact(
      {this.id,
      required String firstname,
      required String lastname,
      required String email,
      required String phone})
      : super(
            firstname: firstname,
            lastname: lastname,
            email: email,
            phone: phone);

  final String? id;

  EmergencyContact copyWith(
      {String? id,
      String? firstname,
      String? lastname,
      String? email,
      String? phone}) {
    return EmergencyContact(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        phone: phone ?? this.phone);
  }

  @override
  List<Object?> get props => [firstname, lastname, email, phone];
}
