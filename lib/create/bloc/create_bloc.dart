import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workers_repository/workers_repository.dart'
    show
        WorkersRepository,
        WorkersException,
        Worker,
        WorkExperience,
        Period,
        EmergencyContact;
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
    on<EmergencyContactAdded>(_onEmergencyContactAdded);
    on<EmergencyContactDeleted>(_onEmergencyContactDeleted);
    on<LocationAdded>(_onLocationAdded);
    on<LocationDeleted>(_onLocationDeleted);
    on<PeriodAdded>(_onPeriodAdded);
    on<PeriodDeleted>(_onPeriodDeleted);
    on<WorkerEditRequested>(_onWorkerEditRequested);
    on<ResetForm>(_onResetForm);
  }

  final WorkersRepository workersRepository;

  Future<void> _onSaveRequest(
      SaveRequested event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    if (state.emergencyContacts.isNotEmpty &&
        state.languages.isNotEmpty &&
        state.licenses.isNotEmpty &&
        state.locations.isNotEmpty) {
      try {
        if (state.oldWorker != null && state.oldWorker!.id == state.workerId) {
          await workersRepository.resetWorker(state.oldWorker!);
        }

        await workersRepository.saveWorker(Worker(
            id: state.workerId,
            firstname: state.firstname,
            lastname: state.lastname,
            birthday: DateFormat("dd/MM/yyyy").parse(state.birthday),
            birthplace: state.birthplace,
            nationality: state.nationality,
            email: state.email,
            phone: state.phone,
            address: state.address,
            workExperiences: state.workExperiences,
            emergencyContacts: state.emergencyContacts,
            languages: state.languages,
            licenses: state.licenses,
            locations: state.locations,
            periods: state.periods,
            withOwnCar: state.withOwnCar));

        emit(const CreateState());
      } on Exception {
        emit(state.copyWith(status: CreateStatus.failure));
      }
    } else {
      emit(state.copyWith(
          status: CreateStatus.failure,
          errorMessage: "Compilare tutti i campi obbligatori."));
    }
  }

  Future<void> _onFirstNameChanged(
      FirstNameChanged event, Emitter<CreateState> emit) async {
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

  Future<void> _onEmergencyContactAdded(
      EmergencyContactAdded event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(status: CreateStatus.success, emergencyContacts: [
        ...state.emergencyContacts,
        event.emergencyContact
      ]));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onEmergencyContactDeleted(
      EmergencyContactDeleted event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      List<EmergencyContact> newList = state.emergencyContacts;
      newList.remove(event.emergencyContact);
      emit(state.copyWith(
          status: CreateStatus.success, emergencyContacts: newList));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onLocationAdded(
      LocationAdded event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success,
          locations: [...state.locations, event.location]));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onLocationDeleted(
      LocationDeleted event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      List<String> newList = state.locations;
      newList.remove(event.location);
      emit(state.copyWith(status: CreateStatus.success, locations: newList));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onPeriodAdded(
      PeriodAdded event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
          status: CreateStatus.success,
          periods: [...state.periods, event.period]));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onPeriodDeleted(
      PeriodDeleted event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      List<Period> newList = state.periods;
      newList.remove(event.period);
      emit(state.copyWith(status: CreateStatus.success, periods: newList));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onWorkerEditRequested(
      WorkerEditRequested event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(state.copyWith(
        status: CreateStatus.success,
        workerId: event.worker.id,
        firstname: event.worker.firstname,
        lastname: event.worker.lastname,
        birthday: DateFormat("dd/MM/yyyy").format(event.worker.birthday),
        birthplace: event.worker.birthplace,
        nationality: event.worker.nationality,
        address: event.worker.address,
        phone: event.worker.phone,
        email: event.worker.email,
        workExperiences: event.worker.workExperiences,
        emergencyContacts: event.worker.emergencyContacts,
        languages: event.worker.languages,
        licenses: event.worker.licenses,
        locations: event.worker.locations,
        periods: event.worker.periods,
        withOwnCar: event.worker.withOwnCar,
        oldWorker: event.worker.copyWith(
            workExperiences: [...event.worker.workExperiences],
            emergencyContacts: [...event.worker.emergencyContacts],
            periods: [...event.worker.periods]),
      ));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }

  Future<void> _onResetForm(ResetForm event, Emitter<CreateState> emit) async {
    emit(state.copyWith(status: CreateStatus.loading));

    try {
      emit(const CreateState());
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }
}
