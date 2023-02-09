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

  @override
  List<Object> get props => [worker];
}

class ShowFiltersChanged extends GalleryEvent {
  final bool showFilters;

  const ShowFiltersChanged({required this.showFilters});

  @override
  List<Object> get props => [showFilters];
}

class KeywordsUpdated extends GalleryEvent {
  final String keywords;

  const KeywordsUpdated({required this.keywords});

  @override
  List<Object> get props => [keywords];
}

class FiltersUpdated extends GalleryEvent {
  const FiltersUpdated();

  @override
  List<Object> get props => [];
}

class LanguageToggled extends GalleryEvent {
  const LanguageToggled({required this.language});

  final String language;

  @override
  List<Object> get props => [language];
}

class LicenceToggled extends GalleryEvent {
  const LicenceToggled({required this.licence});

  final String licence;

  @override
  List<Object> get props => [licence];
}

class LocationToggled extends GalleryEvent {
  const LocationToggled({required this.location});

  final String location;

  @override
  List<Object> get props => [location];
}

class TaskToggled extends GalleryEvent {
  const TaskToggled({required this.task});

  final String task;

  @override
  List<Object> get props => [task];
}

class PeriodAdded extends GalleryEvent {
  const PeriodAdded({required this.period});

  final Period period;

  @override
  List<Object> get props => [period];
}

class PeriodDeleted extends GalleryEvent {
  const PeriodDeleted({required this.period});

  final Period period;

  @override
  List<Object> get props => [period];
}
