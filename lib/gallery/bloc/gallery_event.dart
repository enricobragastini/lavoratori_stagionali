part of 'gallery_bloc.dart';

class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}

class WorkersSubscriptionRequested extends GalleryEvent {
  const WorkersSubscriptionRequested();
}

class WorkersListUpdated extends GalleryEvent {
  const WorkersListUpdated();
}

class WorkerDeleteRequested extends GalleryEvent {
  final Worker worker;

  const WorkerDeleteRequested({required this.worker});
}
