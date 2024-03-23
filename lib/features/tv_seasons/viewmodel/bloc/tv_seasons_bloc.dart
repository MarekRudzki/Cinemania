import 'package:cinemania/features/tv_seasons/model/models/season.dart';
import 'package:cinemania/features/tv_seasons/model/tv_seasons_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'tv_seasons_event.dart';
part 'tv_seasons_state.dart';

@injectable
class TVSeasonsBloc extends Bloc<TVSeasonsEvent, TVSeasonsState> {
  final TVSeasonsRepository tvSeasonsRepository;
  TVSeasonsBloc(this.tvSeasonsRepository) : super(TVSeasonsInitial()) {
    on<FetchSeason>(_onFetchSeason);
  }

  Future<void> _onFetchSeason(
    FetchSeason event,
    Emitter<TVSeasonsState> emit,
  ) async {
    try {
      emit(TVSeasonsLoading());
      final season = await tvSeasonsRepository.fetchSeasonData(
        id: event.id,
        seasonNumber: event.seasonNumber,
      );

      emit(TVSeasonsSuccess(season: season));
    } catch (e) {
      emit(TVSeasonsError(errorMessage: e.toString()));
    }
  }

  double getSeasonsBarHeight({required int seasonsNumber}) {
    return 45 * (1 + ((seasonsNumber - 1) ~/ 4).toDouble());
  }

  String calculateLength({
    required int minutes,
  }) {
    if (minutes < 60) {
      return '${minutes} min';
    } else {
      final int hours = minutes ~/ 60;
      final int remainingMinutes = minutes % 60;
      String formattedTime = '${hours} h';
      if (remainingMinutes > 0) {
        formattedTime += ' ${remainingMinutes} min';
      }
      return formattedTime;
    }
  }
}
