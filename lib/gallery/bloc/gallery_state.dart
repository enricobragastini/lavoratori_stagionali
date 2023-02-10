part of 'gallery_bloc.dart';

enum GalleryStatus { initial, loading, success, failure }

// ignore: constant_identifier_names
enum SearchMode { AND, OR }

class GalleryState extends Equatable {
  const GalleryState({
    this.status = GalleryStatus.initial,
    this.workers = const [],
    this.filter = Filter.empty,
    this.showFilters = false,
    this.allLanguages = const [],
    this.selectedLanguages = const [],
    this.allLicences = const [],
    this.selectedLicences = const [],
    this.allLocations = const [],
    this.selectedLocations = const [],
    this.allTasks = const [],
    this.selectedTasks = const [],
    this.errorMessage,
    this.searchMode = SearchMode.AND,
  });

  final GalleryStatus status;
  final List<Worker> workers;
  final String? errorMessage;

  final bool showFilters;
  final Filter filter;

  final List<String> allLanguages;
  final List<String> selectedLanguages;

  final List<String> allLicences;
  final List<String> selectedLicences;

  final List<String> allLocations;
  final List<String> selectedLocations;

  final List<String> allTasks;
  final List<String> selectedTasks;

  final SearchMode searchMode;

  List<Worker> get filteredWorkers {
    // Restituisce la lista dei lavoratori filtrati
    if (filter == Filter.empty) {
      return workers;
    }

    // Ricerca in OR
    if (searchMode == SearchMode.OR) {
      return workers
          .where((worker) =>
              (filter.keywords.isEmpty
                  ? true
                  : "${worker.firstname} ${worker.lastname}"
                      .contains(filter.keywords)) &&
              (filter.languages.isEmpty
                  ? true
                  : worker.languages
                      .any((wl) => filter.languages.contains(wl))) &&
              (filter.locations.isEmpty
                  ? true
                  : worker.locations
                      .any((wl) => filter.locations.contains(wl))) &&
              (filter.licences.isEmpty
                  ? true
                  : worker.licenses
                      .any((wl) => filter.licences.contains(wl))) &&
              ((filter.withOwnCar == false) ? true : worker.withOwnCar) &&
              (filter.tasks.isEmpty
                  ? true
                  : worker.workExperiences.any((workexperience) =>
                      workexperience.tasks
                          .toSet()
                          .intersection(filter.tasks.toSet())
                          .isNotEmpty)) &&
              (filter.periods.isEmpty
                  ? true
                  : worker.periods.any(
                      (wp) => filter.periods
                          .where((fp) => fp.includes(wp))
                          .isNotEmpty,
                    )))
          .toList();
    } else {
      // Ricerca in AND
      return workers
          .where((worker) =>
              (filter.keywords.isEmpty
                  ? true
                  : "${worker.firstname} ${worker.lastname}"
                      .contains(filter.keywords)) &&
              (filter.languages.isEmpty
                  ? true
                  : worker.languages
                          .toSet()
                          .intersection(filter.languages.toSet())
                          .length ==
                      filter.languages.toSet().length) &&
              (filter.locations.isEmpty
                  ? true
                  : worker.locations
                          .toSet()
                          .intersection(filter.locations.toSet())
                          .length ==
                      filter.locations.toSet().length) &&
              (filter.licences.isEmpty
                  ? true
                  : worker.licenses
                          .toSet()
                          .intersection(filter.licences.toSet())
                          .length ==
                      filter.licences.toSet().length) &&
              ((filter.withOwnCar == false)
                  ? true
                  : worker.withOwnCar == true) &&
              (filter.tasks.isEmpty
                  ? true
                  : worker.allTasks
                          .toSet()
                          .intersection(filter.tasks.toSet())
                          .length ==
                      filter.tasks.toSet().length) &&
              (filter.periods.isEmpty
                  ? true
                  : worker.periods.any(
                      (wp) =>
                          filter.periods
                              .where((fp) => fp.includes(wp))
                              .length ==
                          filter.periods.length,
                    )))
          .toList();
    }
  }

  @override
  List<Object> get props => [status, workers];

  GalleryState copyWith(
      {GalleryStatus? status,
      List<Worker>? workers,
      String? errorMessage,
      bool? showFilters,
      List<String>? allLanguages,
      List<String>? selectedLanguages,
      List<String>? allLicences,
      List<String>? selectedLicences,
      List<String>? allLocations,
      List<String>? selectedLocations,
      List<String>? allTasks,
      List<String>? selectedTasks,
      SearchMode? searchMode,
      Filter? filter}) {
    return GalleryState(
        status: status ?? this.status,
        showFilters: showFilters ?? this.showFilters,
        filter: filter ?? this.filter,
        allLanguages: allLanguages ?? this.allLanguages,
        selectedLanguages: selectedLanguages ?? this.selectedLanguages,
        allLicences: allLicences ?? this.allLicences,
        selectedLicences: selectedLicences ?? this.selectedLicences,
        allLocations: allLocations ?? this.allLocations,
        selectedLocations: selectedLocations ?? this.selectedLocations,
        allTasks: allTasks ?? this.allTasks,
        selectedTasks: selectedTasks ?? this.selectedTasks,
        workers: workers ?? this.workers,
        searchMode: searchMode ?? this.searchMode,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
