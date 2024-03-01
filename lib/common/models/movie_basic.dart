import 'package:equatable/equatable.dart';

class MovieBasic extends Equatable {
  final int id;
  final String imageUrl;
  final String title;

  MovieBasic({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        title,
      ];

  factory MovieBasic.fromJson(Map<String, dynamic> json) {
    final String basicUrl =
        json['poster_path'] != null ? json['poster_path'] as String : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

    return MovieBasic(
      id: json['id'] as int,
      title: json['title'] != null ? json['title'] as String : 'No data',
      imageUrl: fullUrl,
    );
  }
}
