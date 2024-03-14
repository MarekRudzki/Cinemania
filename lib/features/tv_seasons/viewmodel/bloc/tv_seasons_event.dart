part of 'tv_seasons_bloc.dart';

sealed class TVSeasonsEvent extends Equatable {
  const TVSeasonsEvent();

  @override
  List<Object> get props => [];
}

class FetchSeason extends TVSeasonsEvent {
  final int id;
  final int seasonNumber;

  FetchSeason({
    required this.id,
    required this.seasonNumber,
  });

  @override
  List<Object> get props => [
        id,
        seasonNumber,
      ];
}
