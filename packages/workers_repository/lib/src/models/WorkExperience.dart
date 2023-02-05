import 'package:equatable/equatable.dart';

class WorkExperience extends Equatable {
  final String? id;
  final String title;
  final DateTime start;
  final DateTime end;
  final String companyName;
  final String workplace;
  final double dailyPay;
  final List<String> tasks;
  final String notes;

  WorkExperience({
    this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.companyName,
    required this.workplace,
    required this.dailyPay,
    required this.tasks,
    required this.notes,
  });

  WorkExperience copyWith({
    String? id,
    String? title,
    DateTime? start,
    DateTime? end,
    String? companyName,
    String? workplace,
    double? dailyPay,
    List<String>? tasks,
    String? notes,
  }) {
    return WorkExperience(
      id: id ?? this.id,
      title: title ?? this.title,
      start: start ?? this.start,
      end: end ?? this.end,
      companyName: companyName ?? this.companyName,
      workplace: workplace ?? this.workplace,
      dailyPay: dailyPay ?? this.dailyPay,
      tasks: tasks ?? this.tasks,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        this.id,
        this.title,
        this.start,
        this.end,
        this.companyName,
        this.workplace,
        this.dailyPay,
        this.tasks,
        this.notes
      ];
}
