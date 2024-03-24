// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';

class DetailHistory extends Equatable {
  final Category category;
  final int id;
  final int scrollableListIndex;
  final String scrollableListCategory;

  DetailHistory({
    required this.category,
    required this.id,
    required this.scrollableListIndex,
    required this.scrollableListCategory,
  });

  @override
  List<Object> get props => [
        category,
        id,
        scrollableListIndex,
        scrollableListCategory,
      ];
}
