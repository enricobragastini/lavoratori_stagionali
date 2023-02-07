import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:workers_repository/workers_repository.dart'
    show Worker, WorkersRepository, WorkersException;

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc({required this.workersRepository}) : super(const GalleryState()) {
    on<WorkersSubscriptionRequested>(_onWorkersSubscriptionRequested);
    on<WorkersListUpdated>(_onWorkersListUpdated);
    on<WorkerDeleteRequested>(_onWorkersDeleteRequested);

    // Ascolta lo stream dal database in attesa di modifiche al database
    workersRepository.workersStream.listen((event) async {
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

    await workersRepository.deleteWorker(event.worker).then((deleted) async {
      if (deleted) {
        emit(state.copyWith(status: GalleryStatus.success));
      } else {
        emit(state.copyWith(status: GalleryStatus.failure));
      }
    });
  }
}
