import 'package:appwrite/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workers_repository/workers_repository.dart'
    show WorkersRepository, WorkersException, Worker, WorkExperience;
import 'package:intl/intl.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc({required this.workersRepository}) : super(const CreateState()) {
    on<SaveRequested>(_onSaveRequest);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthDayChanged>(_onBirthdayChanged);
    on<BirthPlaceChanged>(_onBirthplaceChanged);
    on<NationalityChanged>(_onNationalityChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<AddressChanged>(_onAddressChanged);
    on<WorkExperienceAdded>(_onWorkExperienceAdded);
    on<WorkExperienceDeleted>(_onWorkExperienceDeleted);
    on<LanguagesEdited>(_onLanguagesEdited);
    on<LicensesEdited>(_onLicensesEdited);
    on<WithOwnCarEdited>(_onWithOwnCarEdited);
  }

  final WorkersRepository workersRepository;

  Future<void> _onSaveRequest(
      SaveRequested event, Emitter<CreateState> emit) async {
    try {
      emit(state.copyWith(status: CreateStatus.loading));
      await workersRepository.saveWorker(Worker(
          firstname: state.firstname,
          lastname: state.lastname,
          birthday: DateFormat("dd/MM/yyyy").parse(state.birthday),
          birthplace: state.birthplace,
          nationality: state.nationality,
          email: state.email,
          phone: state.phone,
          address: state.address,
          workExperiences: state.workExperiences,
          languages: state.languages,
          licenses: state.licenses,
          withOwnCar: state.withOwnCar));
      print("[INFO] Elemento inserito nel database correttamente!");
      emit(const CreateState());
    } on WorkersException {
      print("[INFO] Errore di inserimento nel database correttamente!");
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<CreateState> emit,
  ) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success, firstname: event.firstname));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onLastNameChanged(
    LastNameChanged event,
    Emitter<CreateState> emit,
  ) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success, lastname: event.lastname));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onBirthdayChanged(
    BirthDayChanged event,
    Emitter<CreateState> emit,
  ) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success, birthday: event.birthday));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onBirthplaceChanged(
    BirthPlaceChanged event,
    Emitter<CreateState> emit,
  ) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success, birthplace: event.birthplace));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onNationalityChanged(
    NationalityChanged event,
    Emitter<CreateState> emit,
  ) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success, nationality: event.nationality));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onEmailChanged(
    EmailChanged event,
    Emitter<CreateState> emit,
  ) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(status: CreateStatus.success, email: event.email));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onPhoneChanged(
    PhoneChanged event,
    Emitter<CreateState> emit,
  ) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(status: CreateStatus.success, phone: event.phone));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onAddressChanged(
    AddressChanged event,
    Emitter<CreateState> emit,
  ) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(
          state.copyWith(status: CreateStatus.success, address: event.address));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onWorkExperienceAdded(
      WorkExperienceAdded event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success,
          workExperiences: [...state.workExperiences, event.workExperience]));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onWorkExperienceDeleted(
      WorkExperienceDeleted event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      List<WorkExperience> newList = state.workExperiences;
      newList.remove(event.workExperience);
      emit(state.copyWith(
          status: CreateStatus.success, workExperiences: newList));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onLanguagesEdited(
      LanguagesEdited event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success, languages: event.languages));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onLicensesEdited(
      LicensesEdited event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success, licenses: event.licenses));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onWithOwnCarEdited(
      WithOwnCarEdited event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success, withOwnCar: event.withOwnCarEdited));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }
}
