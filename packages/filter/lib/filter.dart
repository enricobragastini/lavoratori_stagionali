import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:workers_repository/workers_repository.dart' show Period;

class Filter extends Equatable {
  const Filter({
    required this.keywords,
    required this.languages,
    required this.locations,
    required this.licences,
    required this.tasks,
    required this.periods,
    required this.withOwnCar,
  });

  final String keywords;

  final List<String> languages;
  final List<String> locations;
  final List<String> licences;
  final List<String> tasks;

  final List<Period> periods;

  final bool withOwnCar;

  Filter copyWith(
      {String? keywords,
      List<String>? languages,
      List<String>? locations,
      List<String>? licences,
      List<String>? tasks,
      List<Period>? periods,
      bool? withOwnCar}) {
    return Filter(
      keywords: keywords ?? this.keywords,
      languages: languages ?? this.languages,
      locations: locations ?? this.locations,
      licences: licences ?? this.licences,
      tasks: tasks ?? this.tasks,
      periods: periods ?? this.periods,
      withOwnCar: withOwnCar ?? this.withOwnCar,
    );
  }

  static const Filter empty = Filter(
    keywords: "",
    languages: [],
    locations: [],
    licences: [],
    tasks: [],
    periods: [],
    withOwnCar: false,
  );

  @override
  List<Object?> get props =>
      [keywords, languages, locations, licences, tasks, periods, withOwnCar];
}
