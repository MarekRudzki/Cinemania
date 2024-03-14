import 'package:cinemania/features/home/model/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<FetchGenres>(_onFetchGenres);
  }
  final List<String> categories = [
    'Popular Movies',
    'Coming Soon',
    'Recommended Movies',
    'Recommended TV Shows',
    'Best Movies',
    'Best TV Shows',
    'Movie Categories',
    'TV Show Categories',
  ];

  Future<void> _onFetchGenres(
    FetchGenres event,
    Emitter<HomeState> emit,
  ) async {
    // final List<Genre> movieGenres = await homeRepository.fetchMovieGenres();
    // final List<Genre> tvShowGenres = await homeRepository.fetchTvShowGenres();

    // for (final movieGenre in movieGenres) {
    //   categories.add('Best ${movieGenre.name} Movies');
    // }

    // for (final tvShowGenre in tvShowGenres) {
    //   categories.add('Best ${tvShowGenre.name} TV Shows');
    // }
  }
}
