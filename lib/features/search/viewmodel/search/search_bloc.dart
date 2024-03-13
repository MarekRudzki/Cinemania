import 'package:cinemania/common/models/basic_model.dart';
import 'package:cinemania/features/search/model/search_repository.dart';
import 'package:cinemania/common/enums.dart';
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
    on<ResetSearch>(_onResetSearch);
    on<ChangeCategoryPressed>(_onChangeCategoryPressed);
  }
  Category currentCategory = Category.movies;
  String searchQuery = '';

  Future<void> _onSearchPressed(
    SearchPressed event,
    Emitter<SearchState> emit,
  ) async {
    if (event.searchQuery.isEmpty) {
      emit(SearchError(errorMessage: 'Search field cannot be empty.'));
    }
    final String query = event.searchQuery.replaceAll(' ', '-');
    searchQuery = query;
    emit(SearchLoading());
    try {
      if (event.category == Category.movies) {
        final movies = await searchRepository.fetchMovies(
          query: query,
          page: 1,
        );
        emit(
          SearchSuccess(
            category: Category.movies,
            movies: movies,
          ),
        );
      } else if (event.category == Category.tvShows) {
        final tvShows = await searchRepository.fetchTvShows(
          query: query,
          page: 1,
        );
        emit(
          SearchSuccess(
            category: Category.tvShows,
            tvShows: tvShows,
          ),
        );
      } else {
        final cast = await searchRepository.fetchCast(
          query: query,
          page: 1,
        );
        emit(
          SearchSuccess(
            category: Category.cast,
            cast: cast,
          ),
        );
      }
    } catch (e) {
      emit(SearchError(errorMessage: e.toString()));
    }
  }

  void _onResetSearch(
    ResetSearch event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchInitial());
  }

  void _onChangeCategoryPressed(
    ChangeCategoryPressed event,
    Emitter<SearchState> emit,
  ) {
    emit(CategoryChanged());
    searchQuery = '';
    currentCategory = event.category;
  }

  String getAssetAdress({
    required Category category,
    int? gender,
  }) {
    if (category == Category.movies) {
      return 'assets/movie.png';
    } else if (category == Category.tvShows) {
      return 'assets/tv_show.png';
    } else {
      if (gender == 1) {
        return 'assets/woman.png';
      } else if (gender == 2) {
        return 'assets/man.png';
      } else {
        return 'assets/unknown_nonbinary.png';
      }
    }
  }
}
