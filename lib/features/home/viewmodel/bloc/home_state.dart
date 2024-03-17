part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<BasicModel>? movies;
  final List<BasicModel>? tvShows;
  final List<Genre>? genres;
  final dynamic error;
  final int? page;

  HomeState({
    this.movies,
    this.tvShows,
    this.genres,
    this.error,
    this.page = 1,
  });

  @override
  List<Object?> get props => [
        movies,
        tvShows,
        genres,
        error,
        page,
      ];
}

class CategoriesChanged extends HomeState {}

class HomeLoading extends HomeState {}
