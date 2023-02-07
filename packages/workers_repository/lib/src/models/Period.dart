import 'package:equatable/equatable.dart';

class Period extends Equatable {
  Period({this.id, required this.start, required this.end});

  final String? id;
  final DateTime start;
  final DateTime end;

  Period copyWith({
    String? id,
    DateTime? start,
    DateTime? end,
  }) {
    return Period(
        id: id ?? this.id, start: start ?? this.start, end: end ?? this.end);
  }

  @override
  List<Object?> get props => [id, start, end];
}
