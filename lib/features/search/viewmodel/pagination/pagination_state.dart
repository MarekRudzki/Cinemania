part of 'pagination_bloc.dart';

class PaginationState extends Equatable {
  final List<MovieBasic>? searchedMovies;
  final List<TVShowBasic>? searchedTVShows;
  final List<PersonBasic>? searchedCast;
  final dynamic error;
  final int? page;

  PaginationState({
    this.searchedMovies,
    this.searchedTVShows,
    this.searchedCast,
    this.error,
    this.page = 1,
  });

  @override
  List<Object?> get props => [
        searchedMovies,
        searchedTVShows,
        searchedCast,
        error,
        page,
      ];
}
