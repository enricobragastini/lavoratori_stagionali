import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:workers_repository/workers_repository.dart';
import 'package:workers_repository/src/models/Worker.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc({required this.workersRepository}) : super(const GalleryState()) {
    on<WorkersSubscriptionRequested>(_onWorkersSubscriptionRequested);
    on<WorkersListUpdated>(_onWorkersListUpdated);
    on<WorkerDeleteRequested>(_onWorkersDeleteRequested);

    workersRepository.workersStream.listen((event) {
      add(const WorkersListUpdated());
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
    await workersRepository.workersList.then((list) async {
      emit(state.copyWith(status: GalleryStatus.success, workers: list));
    });
  }

  Future<void> _onWorkersDeleteRequested(
      WorkerDeleteRequested event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    workersRepository.deleteWorker(event.worker).then((deleted) {
      if (deleted) {
        emit(state.copyWith(status: GalleryStatus.success));
      } else {
        emit(state.copyWith(status: GalleryStatus.failure));
      }
    });
  }
}
