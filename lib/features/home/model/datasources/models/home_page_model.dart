// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';

class HomePageModel extends Equatable {
  final Category category;
  final int page;
  final String tab;

  HomePageModel({
    required this.category,
    required this.page,
    required this.tab,
  });

  @override
  List<Object?> get props => [
        category,
        page,
        tab,
      ];
}
