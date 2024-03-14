part of 'genre_bloc.dart';

class GenreState extends Equatable {
  final List<BasicModel>? movies;
  final List<BasicModel>? tvShows;
  final dynamic error;
  final int? page;

  GenreState({
    this.movies,
    this.tvShows,
    this.error,
    this.page = 1,
  });

  @override
  List<Object?> get props => [
        movies,
        tvShows,
        error,
        page,
      ];
}
