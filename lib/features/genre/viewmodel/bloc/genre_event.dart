part of 'genre_bloc.dart';

sealed class GenreEvent extends Equatable {
  const GenreEvent();

  @override
  List<Object> get props => [];
}

class FetchGenrePressed extends GenreEvent {
  final int genreId;
  final Category type;

  FetchGenrePressed({
    required this.genreId,
    required this.type,
  });

  @override
  List<Object> get props => [
        genreId,
        type,
      ];
}
