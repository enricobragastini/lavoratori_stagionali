part of 'create_bloc.dart';

enum CreateStatus { initial, loading, success, failure }

class CreateState extends Equatable {
  const CreateState({
    this.status = CreateStatus.initial,
    this.firstname = "",
    this.lastname = "",
    this.birthday = "",
    this.birthplace = "",
    this.nationality = "",
    this.address = "",
    this.phone = "",
    this.email = "",
    this.workExperiences = const [],
    this.emergencyContacts = const [],
    this.languages = const [],
    this.licenses = const [],
    this.locations = const [],
    this.periods = const [],
    this.withOwnCar = false,
  });

  final CreateStatus status;
  final String firstname;
  final String lastname;
  final String birthday;
  final String birthplace;
  final String nationality;
  final String address;
  final String phone;
  final String email;

  final List<WorkExperience> workExperiences;
  final List<EmergencyContact> emergencyContacts;
  final List<String> languages;
  final List<String> licenses;
  final List<String> locations;
  final List<Period> periods;
  final bool withOwnCar;

  CreateState copyWith({
    CreateStatus? status,
    String? firstname,
    String? lastname,
    String? birthday,
    String? birthplace,
    String? nationality,
    String? address,
    String? phone,
    String? email,
    List<WorkExperience>? workExperiences,
    List<EmergencyContact>? emergencyContacts,
    List<String>? languages,
    List<String>? licenses,
    List<String>? locations,
    List<Period>? periods,
    bool? withOwnCar,
  }) {
    return CreateState(
        status: status ?? this.status,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        birthday: birthday ?? this.birthday,
        birthplace: birthplace ?? this.birthplace,
        nationality: nationality ?? this.nationality,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        workExperiences: workExperiences ?? this.workExperiences,
        emergencyContacts: emergencyContacts ?? this.emergencyContacts,
        languages: languages ?? this.languages,
        licenses: licenses ?? this.licenses,
        locations: locations ?? this.locations,
        periods: periods ?? this.periods,
        withOwnCar: withOwnCar ?? this.withOwnCar);
  }

  @override
  List<Object> get props => [
        status,
        firstname,
        lastname,
        birthday,
        birthplace,
        nationality,
        address,
        phone,
        email,
        workExperiences,
        languages,
        licenses,
        locations,
        periods,
        withOwnCar
      ];
}
