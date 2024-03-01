part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class CategoryChanged extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final Category category;
  final List<MovieBasic>? movies;
  final List<TVShowBasic>? tvShows;
  final List<PersonBasic>? cast;

  SearchSuccess({
    required this.category,
    this.movies,
    this.tvShows,
    this.cast,
  });

  @override
  List<Object> get props => [
        category,
        movies ?? Object(),
        tvShows ?? Object(),
        cast ?? Object(),
      ];
}

final class SearchError extends SearchState {
  final String errorMessage;

  SearchError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
