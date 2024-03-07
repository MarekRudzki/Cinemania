import 'package:cinemania/common/enums.dart';
import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final Category category;
  final int? gender;
  final int id;
  final String name;
  final String url;

  Favorite({
    required this.category,
    this.gender,
    required this.id,
    required this.name,
    required this.url,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    final Category categoryType;
    if ((json['category'] as String) == 'Category.movies') {
      categoryType = Category.movies;
    } else if ((json['category'] as String) == 'Category.tvShows') {
      categoryType = Category.tvShows;
    } else {
      categoryType = Category.cast;
    }
    return Favorite(
      category: categoryType,
      gender: json['gender'] != null ? json['gender'] as int : 0,
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  @override
  List<Object?> get props => [
        category,
        gender,
        id,
        name,
        url,
      ];
}
