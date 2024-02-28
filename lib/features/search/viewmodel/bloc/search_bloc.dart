import 'package:cinemania/features/search/model/search_repository.dart';
import 'package:cinemania/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;
  SearchBloc(this.searchRepository) : super(SearchInitial()) {
    on<SearchPressed>(_onSearchPressed);
  }

  Future<void> _onSearchPressed(
    SearchPressed event,
    Emitter<SearchState> emit,
  ) async {
    final String query = event.searchQuery.replaceAll(' ', '-');

    if (event.category == SearchCategory.movies) {
      searchRepository.fetchMovies(query: query);
    } else if (event.category == SearchCategory.tvShows) {
      searchRepository.fetchTvShows(query: query);
    } else {
      searchRepository.fetchCast(query: query);
    }
  }
}
