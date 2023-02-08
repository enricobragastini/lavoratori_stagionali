import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  const Filter({required this.keywords});

  final String keywords;

  Filter copyWith({String? keywords}) {
    return Filter(keywords: keywords ?? this.keywords);
  }

  static const Filter empty = Filter(
    keywords: "",
  );

  @override
  List<Object?> get props => [keywords];
}
