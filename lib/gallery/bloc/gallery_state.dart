part of 'gallery_bloc.dart';

enum GalleryStatus { initial, loading, success, failure }

class GalleryState extends Equatable {
  const GalleryState(
      {this.status = GalleryStatus.initial,
      this.workers = const [],
      this.errorMessage});

  final GalleryStatus status;
  final List<Worker> workers;
  final String? errorMessage;

  @override
  List<Object> get props => [status, workers];

  GalleryState copyWith(
      {GalleryStatus? status, List<Worker>? workers, String? errorMessage}) {
    return GalleryState(
        status: status ?? this.status,
        workers: workers ?? this.workers,
        errorMessage: errorMessage);
  }
}
