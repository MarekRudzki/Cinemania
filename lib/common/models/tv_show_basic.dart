import 'package:equatable/equatable.dart';

class TVShowBasic extends Equatable {
  final int id;
  final String imageUrl;
  final String title;

  TVShowBasic({
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

  factory TVShowBasic.fromJson(Map<String, dynamic> json) {
    final String basicUrl =
        json['poster_path'] != null ? json['poster_path'] as String : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

    return TVShowBasic(
      id: json['id'] as int,
      title: json['name'] != null ? json['name'] as String : 'No data',
      imageUrl: fullUrl,
    );
  }
}
