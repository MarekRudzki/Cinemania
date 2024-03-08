import 'package:cinemania/common/models/genre.dart';
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
    on<FetchMovieGenresPressed>(_onFetchMovieGenresPressed);
    on<FetchTVShowGenresPressed>(_onFetchTVShowGenresPressed);
  }

  Future<void> _onFetchMovieGenresPressed(
    FetchMovieGenresPressed event,
    Emitter<HomeState> emit,
  ) async {
    final List<Genre> movieGenres = await homeRepository.fetchMovieGenres();
  }

  Future<void> _onFetchTVShowGenresPressed(
    FetchTVShowGenresPressed event,
    Emitter<HomeState> emit,
  ) async {
    final List<Genre> tvShowGenres = await homeRepository.fetchTvShowGenres();
  }
}
