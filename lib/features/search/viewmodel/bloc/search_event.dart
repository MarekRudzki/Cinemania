part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchPressed extends SearchEvent {
  final String searchQuery;
  final SearchCategory category;

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
