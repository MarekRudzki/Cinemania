// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';

class GenrePageModel extends Equatable {
  final int page;
  final int? genre;
  final Category category;

  GenrePageModel({
    required this.page,
    this.genre,
    required this.category,
  });

  @override
  List<Object?> get props => [
        page,
        genre ?? Object(),
        category,
      ];
}
