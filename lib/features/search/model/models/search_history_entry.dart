// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';

class SearchHistoryEntry extends Equatable {
  final String text;
  final Category category;

  SearchHistoryEntry({
    required this.text,
    required this.category,
  });

  factory SearchHistoryEntry.fromJson(Map<String, dynamic> json) {
    final Category categoryType;
    if ((json['category'] as String) == 'Category.movies') {
      categoryType = Category.movies;
    } else if ((json['category'] as String) == 'Category.tvShows') {
      categoryType = Category.tvShows;
    } else {
      categoryType = Category.cast;
    }
    return SearchHistoryEntry(
      category: categoryType,
      text: json['text'] as String,
    );
  }

  @override
  List<Object?> get props => [
        category,
        text,
      ];
}
