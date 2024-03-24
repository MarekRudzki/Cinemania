// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';

class SearchPageModel extends Equatable {
  final int page;
  final String query;
  final Category category;

  SearchPageModel({
    required this.page,
    required this.query,
    required this.category,
  });

  @override
  List<Object?> get props => [
        page,
        query,
        category,
      ];
}
