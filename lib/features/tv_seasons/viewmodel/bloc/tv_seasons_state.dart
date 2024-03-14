part of 'tv_seasons_bloc.dart';

sealed class TVSeasonsState extends Equatable {
  const TVSeasonsState();

  @override
  List<Object> get props => [];
}

final class TVSeasonsInitial extends TVSeasonsState {}

final class TVSeasonsLoading extends TVSeasonsState {}

final class TVSeasonsSuccess extends TVSeasonsState {
  final Season season;

  TVSeasonsSuccess({
    required this.season,
  });

  @override
  List<Object> get props => [
        season,
      ];
}

final class TVSeasonsError extends TVSeasonsState {
  final String errorMessage;

  TVSeasonsError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
