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

  bool includes(Period other) {
    return ((this.start.isAfter(other.start) || this.start == other.start) &&
        (this.end.isBefore(other.end) || this.end == other.end));
  }

  @override
  List<Object?> get props => [id, start, end];
}
