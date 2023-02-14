part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

class SaveRequested extends CreateEvent {
  const SaveRequested();
}

class FirstNameChanged extends CreateEvent {
  const FirstNameChanged({required this.firstname});

  final String firstname;

  @override
  List<Object> get props => [firstname];
}

class LastNameChanged extends CreateEvent {
  const LastNameChanged({required this.lastname});

  final String lastname;

  @override
  List<Object> get props => [lastname];
}

class BirthDayChanged extends CreateEvent {
  const BirthDayChanged({required this.birthday});

  final String birthday;

  @override
  List<Object> get props => [birthday];
}

class BirthPlaceChanged extends CreateEvent {
  const BirthPlaceChanged({required this.birthplace});

  final String birthplace;

  @override
  List<Object> get props => [birthplace];
}

class NationalityChanged extends CreateEvent {
  const NationalityChanged({required this.nationality});

  final String nationality;

  @override
  List<Object> get props => [nationality];
}

class AddressChanged extends CreateEvent {
  const AddressChanged({required this.address});

  final String address;

  @override
  List<Object> get props => [address];
}

class EmailChanged extends CreateEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PhoneChanged extends CreateEvent {
  const PhoneChanged({required this.phone});

  final String phone;

  @override
  List<Object> get props => [phone];
}

class WorkExperienceAdded extends CreateEvent {
  const WorkExperienceAdded({required this.workExperience});

  final WorkExperience workExperience;

  @override
  List<Object> get props => [workExperience];
}

class WorkExperienceDeleted extends CreateEvent {
  const WorkExperienceDeleted({required this.workExperience});

  final WorkExperience workExperience;

  @override
  List<Object> get props => [workExperience];
}

class LanguagesEdited extends CreateEvent {
  const LanguagesEdited({required this.languages});

  final List<String> languages;

  @override
  List<Object> get props => [languages];
}

class LicensesEdited extends CreateEvent {
  const LicensesEdited({required this.licenses});

  final List<String> licenses;

  @override
  List<Object> get props => [licenses];
}

class WithOwnCarEdited extends CreateEvent {
  const WithOwnCarEdited({required this.withOwnCarEdited});

  final bool withOwnCarEdited;

  @override
  List<Object> get props => [withOwnCarEdited];
}

class EmergencyContactAdded extends CreateEvent {
  const EmergencyContactAdded({required this.emergencyContact});

  final EmergencyContact emergencyContact;

  @override
  List<Object> get props => [emergencyContact];
}

class EmergencyContactDeleted extends CreateEvent {
  const EmergencyContactDeleted({required this.emergencyContact});

  final EmergencyContact emergencyContact;

  @override
  List<Object> get props => [emergencyContact];
}

class LocationAdded extends CreateEvent {
  const LocationAdded({required this.location});

  final String location;

  @override
  List<Object> get props => [location];
}

class LocationDeleted extends CreateEvent {
  const LocationDeleted({required this.location});

  final String location;

  @override
  List<Object> get props => [location];
}

class PeriodAdded extends CreateEvent {
  const PeriodAdded({required this.period});

  final Period period;

  @override
  List<Object> get props => [period];
}

class PeriodDeleted extends CreateEvent {
  const PeriodDeleted({required this.period});

  final Period period;

  @override
  List<Object> get props => [period];
}

class WorkerEditRequested extends CreateEvent {
  const WorkerEditRequested({required this.worker});

  final Worker worker;

  @override
  List<Object> get props => [worker];
}

class ResetForm extends CreateEvent {
  const ResetForm();
}
