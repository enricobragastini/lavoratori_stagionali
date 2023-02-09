import 'package:appwrite/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:workers_repository/workers_repository.dart'
    show Worker, WorkersRepository, WorkersException, Period;
import 'package:filter/filter.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc({required this.workersRepository}) : super(const GalleryState()) {
    on<WorkersSubscriptionRequested>(_onWorkersSubscriptionRequested);
    on<WorkersListUpdated>(_onWorkersListUpdated);
    on<WorkerDeleteRequested>(_onWorkersDeleteRequested);
    on<KeywordsUpdated>(_onKeywordsUpdated);
    on<ShowFiltersChanged>(_onShowFiltersChanged);
    on<FiltersUpdated>(_onFiltersUpdated);
    on<LanguageToggled>(_onLanguageToggled);
    on<LicenceToggled>(_onLicenceToggled);
    on<LocationToggled>(_onLocationToggled);
    on<TaskToggled>(_onTaskToggled);
    on<PeriodAdded>(_onPeriodAdded);
    on<PeriodDeleted>(_onPeriodDeleted);

    // Ascolta lo stream dal database in attesa di modifiche al database
    workersRepository.workersStream.listen((event) async {
      add(const WorkersListUpdated());
      add(const FiltersUpdated());
    });
  }

  WorkersRepository workersRepository;

  Future<void> _onWorkersSubscriptionRequested(
    WorkersSubscriptionRequested event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: GalleryStatus.loading));
    try {
      await workersRepository.workersList.then((list) async {
        emit(state.copyWith(status: GalleryStatus.success, workers: list));
        add(const FiltersUpdated());
      });
    } on WorkersException catch (e) {
      emit(state.copyWith(
          status: GalleryStatus.failure, errorMessage: e.message));
    }
  }

  Future<void> _onWorkersListUpdated(
    WorkersListUpdated event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      await workersRepository.workersList.then((list) async {
        emit(state.copyWith(status: GalleryStatus.success, workers: list));
      });
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }

  Future<void> _onWorkersDeleteRequested(
      WorkerDeleteRequested event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    await workersRepository.deleteWorker(event.worker).then((deleted) async {
      if (deleted) {
        emit(state.copyWith(status: GalleryStatus.success));
      } else {
        emit(state.copyWith(status: GalleryStatus.failure));
      }
    });
  }

  Future<void> _onKeywordsUpdated(
      KeywordsUpdated event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: GalleryStatus.success,
          filter: state.filter.copyWith(keywords: event.keywords)));
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }

  Future<void> _onShowFiltersChanged(
      ShowFiltersChanged event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: GalleryStatus.success, showFilters: event.showFilters));
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }

  Future<void> _onFiltersUpdated(
      FiltersUpdated event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      List<Worker> workers = state.workers;
      List<String> allLanguages = [];
      List<String> allLicences = [];
      List<String> allLocations = [];
      List<String> allTasks = [];

      for (final worker in workers) {
        allLanguages.addAll(worker.languages);
        allLicences.addAll(worker.licenses);
        allLocations.addAll(worker.locations);
        for (final workExperience in worker.workExperiences) {
          allTasks.addAll(workExperience.tasks);
        }
      }
      emit(state.copyWith(
          status: GalleryStatus.success,
          allLanguages: allLanguages.toSet().toList(),
          allLicences: allLicences.toSet().toList(),
          allLocations: allLocations.toSet().toList(),
          allTasks: allTasks.toSet().toList()));
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }

  Future<void> _onLanguageToggled(
      LanguageToggled event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      if (!state.selectedLanguages.contains(event.language)) {
        emit(state.copyWith(
            status: GalleryStatus.success,
            selectedLanguages: [...state.selectedLanguages, event.language],
            filter: state.filter.copyWith(
                languages: [...state.selectedLanguages, event.language])));
      } else {
        List<String> newList = state.selectedLanguages;
        newList.remove(event.language);
        emit(state.copyWith(
            status: GalleryStatus.success,
            selectedLanguages: newList,
            filter: state.filter.copyWith(languages: newList)));
      }
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }

  Future<void> _onLicenceToggled(
      LicenceToggled event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      if (!state.selectedLicences.contains(event.licence)) {
        emit(state.copyWith(
            status: GalleryStatus.success,
            selectedLicences: [...state.selectedLicences, event.licence],
            filter: state.filter.copyWith(
                licences: [...state.selectedLicences, event.licence])));
      } else {
        List<String> newList = state.selectedLicences;
        newList.remove(event.licence);
        emit(state.copyWith(
            status: GalleryStatus.success,
            selectedLicences: newList,
            filter: state.filter.copyWith(licences: newList)));
      }
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }

  Future<void> _onLocationToggled(
      LocationToggled event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      if (!state.selectedLocations.contains(event.location)) {
        emit(state.copyWith(
            status: GalleryStatus.success,
            selectedLocations: [...state.selectedLocations, event.location],
            filter: state.filter.copyWith(
                locations: [...state.selectedLocations, event.location])));
      } else {
        List<String> newList = state.selectedLocations;
        newList.remove(event.location);
        emit(state.copyWith(
            status: GalleryStatus.success,
            selectedLocations: newList,
            filter: state.filter.copyWith(locations: newList)));
      }
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }

  Future<void> _onTaskToggled(
      TaskToggled event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      if (!state.selectedTasks.contains(event.task)) {
        emit(state.copyWith(
            status: GalleryStatus.success,
            selectedTasks: [...state.selectedTasks, event.task],
            filter: state.filter
                .copyWith(tasks: [...state.selectedTasks, event.task])));
      } else {
        List<String> newList = state.selectedTasks;
        newList.remove(event.task);
        emit(state.copyWith(
            status: GalleryStatus.success,
            selectedTasks: newList,
            filter: state.filter.copyWith(tasks: newList)));
      }
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }

  Future<void> _onPeriodAdded(
      PeriodAdded event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      emit(state.copyWith(
          status: GalleryStatus.success,
          filter: state.filter
              .copyWith(periods: [...state.filter.periods, event.period])));
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }

  Future<void> _onPeriodDeleted(
      PeriodDeleted event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      List<Period> newList = state.filter.periods;
      newList.remove(event.period);
      emit(state.copyWith(
          status: GalleryStatus.success,
          filter: state.filter.copyWith(periods: newList)));
    } catch (e) {
      emit(state.copyWith(status: GalleryStatus.failure));
    }
  }
}
