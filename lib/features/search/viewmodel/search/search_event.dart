part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchPressed extends SearchEvent {
  final String searchQuery;
  final Category category;

  SearchPressed({
    required this.searchQuery,
    required this.category,
  });

  @override
  List<Object> get props => [
        searchQuery,
        category,
      ];
}

class ResetSearch extends SearchEvent {}

class GetUserSearchesPressed extends SearchEvent {}

class ChangeCategoryPressed extends SearchEvent {
  final Category category;

  ChangeCategoryPressed({
    required this.category,
  });

  @override
  List<Object> get props => [
        category,
      ];
}
