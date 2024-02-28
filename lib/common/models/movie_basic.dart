import 'package:equatable/equatable.dart';

class MovieBasic extends Equatable {
  final String id;
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
}
