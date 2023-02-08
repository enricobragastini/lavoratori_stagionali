part of 'gallery_bloc.dart';

enum GalleryStatus { initial, loading, success, failure }

class GalleryState extends Equatable {
  const GalleryState(
      {this.status = GalleryStatus.initial,
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
      this.errorMessage});

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

  List<Worker> get filteredWorkers {
    if (filter == Filter.empty) {
      return workers;
    }
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
                    .isNotEmpty) &&
            (filter.locations.isEmpty
                ? true
                : worker.locations
                    .toSet()
                    .intersection(filter.locations.toSet())
                    .isNotEmpty) &&
            (filter.licences.isEmpty
                ? true
                : worker.licenses
                    .toSet()
                    .intersection(filter.licences.toSet())
                    .isNotEmpty) &&
            (filter.tasks.isEmpty
                ? true
                : worker.workExperiences.any((workexperience) => workexperience
                    .tasks
                    .toSet()
                    .intersection(filter.tasks.toSet())
                    .isNotEmpty)))
        .toList();
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
        errorMessage: errorMessage);
  }
}
