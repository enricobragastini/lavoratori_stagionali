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
        workExperiences: workExperiences ?? this.workExperiences);
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
      ];

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
