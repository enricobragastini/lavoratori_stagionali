import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  const Filter({
    required this.keywords,
    required this.languages,
    required this.locations,
    required this.licences,
    required this.tasks,
  });

  final String keywords;

  final List<String> languages;
  final List<String> locations;
  final List<String> licences;
  final List<String> tasks;

  Filter copyWith(
      {String? keywords,
      List<String>? languages,
      List<String>? locations,
      List<String>? licences,
      List<String>? tasks}) {
    return Filter(
      keywords: keywords ?? this.keywords,
      languages: languages ?? this.languages,
      locations: locations ?? this.locations,
      licences: licences ?? this.licences,
      tasks: tasks ?? this.tasks,
    );
  }

  static const Filter empty = Filter(
    keywords: "",
    languages: [],
    locations: [],
    licences: [],
    tasks: [],
  );

  @override
  List<Object?> get props => [keywords, languages, locations, licences, tasks];
}
