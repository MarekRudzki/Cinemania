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
  final List<BasicModel> titles;

  SearchSuccess({
    required this.category,
    required this.titles,
  });

  @override
  List<Object> get props => [
        category,
        titles,
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

final class UserSearches extends SearchState {
  final List<SearchHistoryEntry> searches;

  UserSearches({
    required this.searches,
  });

  @override
  List<Object> get props => [
        searches,
      ];
}
