import 'package:cinemania/common/enums.dart';
import 'package:equatable/equatable.dart';

class CategoryPageModel extends Equatable {
  final int page;
  final int? genre;
  final Category category;

  CategoryPageModel({
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
