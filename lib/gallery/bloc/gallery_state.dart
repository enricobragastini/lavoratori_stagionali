part of 'gallery_bloc.dart';

enum GalleryStatus { initial, loading, success, failure }

class GalleryState extends Equatable {
  const GalleryState(
      {this.status = GalleryStatus.initial,
      this.workers = const [],
      this.filter = Filter.empty,
      this.errorMessage});

  final GalleryStatus status;
  final List<Worker> workers;
  final String? errorMessage;

  final Filter filter;

  List<Worker> get filteredWorkers {
    if (filter == Filter.empty) {
      return workers;
    }
    return workers.where((worker) {
      return "${worker.firstname} ${worker.lastname}".contains(filter.keywords);
    }).toList();
  }

  @override
  List<Object> get props => [status, workers];

  GalleryState copyWith(
      {GalleryStatus? status,
      List<Worker>? workers,
      String? errorMessage,
      Filter? filter}) {
    return GalleryState(
        status: status ?? this.status,
        filter: filter ?? this.filter,
        workers: workers ?? this.workers,
        errorMessage: errorMessage);
  }
}
