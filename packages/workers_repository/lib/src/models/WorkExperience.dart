import 'package:equatable/equatable.dart';

class WorkExperience extends Equatable {
  final String title;
  final DateTime start;
  final DateTime end;
  final String companyName;
  final List<String> tasks;
  final String notes;

  WorkExperience({
    required this.title,
    required this.start,
    required this.end,
    required this.companyName,
    required this.tasks,
    required this.notes,
  });

  WorkExperience copyWith({
    String? title,
    DateTime? start,
    DateTime? end,
    String? companyName,
    List<String>? tasks,
    String? notes,
  }) {
    return WorkExperience(
      title: title ?? this.title,
      start: start ?? this.start,
      end: end ?? this.end,
      companyName: companyName ?? this.companyName,
      tasks: tasks ?? this.tasks,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        this.title,
        this.start,
        this.end,
        this.companyName,
        this.tasks,
        this.notes
      ];
}
