// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:cinemania/common/enums.dart';
import 'package:cinemania/features/details/model/details_repository.dart';
import 'package:cinemania/features/details/model/models/detail_history.dart';
import 'package:cinemania/features/details/model/models/movie.dart';
import 'package:cinemania/features/details/model/models/person.dart';
import 'package:cinemania/features/details/model/models/tv_show.dart';

part 'details_event.dart';
part 'details_state.dart';

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsRepository detailsRepository;

  DetailsBloc(this.detailsRepository) : super(DetailsInitial()) {
    on<FetchMovieDataPressed>(_onFetchMovieDataPressed);
    on<FetchTVShowDataPressed>(_onFetchTVShowDataPressed);
    on<FetchPersonDataPressed>(_onFetchPersonDataPressed);
    on<AddToHistoryPressed>(_onAddToHistoryPressed);
    on<DeleteLastHistoryElementPressed>(_onDeleteLastHistoryElementPressed);
  }

  List<DetailHistory> history = [];

  void _onAddToHistoryPressed(
    AddToHistoryPressed event,
    Emitter<DetailsState> emit,
  ) {
    history.add(
      DetailHistory(
        category: event.category,
        id: event.id,
        scrollableListIndex: event.scrollableListIndex,
        scrollableListCategory: event.scrollableListCategory,
      ),
    );
  }

  void _onDeleteLastHistoryElementPressed(
    DeleteLastHistoryElementPressed event,
    Emitter<DetailsState> emit,
  ) {
    if (history.isNotEmpty) {
      history.removeLast();
    }
  }

  Future<void> _onFetchMovieDataPressed(
    FetchMovieDataPressed event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoading());
    try {
      final Movie movie = await detailsRepository.fetchMovieData(id: event.id);
      emit(
        DetailsSuccess(
          movie: movie,
          scrollableListCategory: event.scrollableListCategory,
          scrollableListIndex: event.scrollableListIndex,
        ),
      );
    } catch (e) {
      emit(DetailsError(errorMessage: e.toString()));
    }
  }

  Future<void> _onFetchTVShowDataPressed(
    FetchTVShowDataPressed event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoading());
    try {
      final TVShow tvShow =
          await detailsRepository.fetchTVShowData(id: event.id);
      emit(
        DetailsSuccess(
          tvShow: tvShow,
          scrollableListCategory: event.scrollableListCategory,
          scrollableListIndex: event.scrollableListIndex,
        ),
      );
    } catch (e) {
      emit(DetailsError(errorMessage: e.toString()));
    }
  }

  Future<void> _onFetchPersonDataPressed(
    FetchPersonDataPressed event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoading());
    try {
      final Person person =
          await detailsRepository.fetchPersonData(id: event.id);
      emit(
        DetailsSuccess(
          person: person,
          scrollableListCategory: event.scrollableListCategory,
          scrollableListIndex: event.scrollableListIndex,
        ),
      );
    } catch (e) {
      emit(DetailsError(errorMessage: e.toString()));
    }
  }

  String getAssetAdress({
    Category? category,
    int? gender,
  }) {
    if (category == null) {
      return 'assets/photo_loading.png';
    }
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

  int calculateAge({
    required String birthday,
    required String deathday,
  }) {
    final DateTime birthdayFormatted = DateFormat("yyyy-MM-dd").parse(birthday);
    DateTime? deathdayFormatted;

    if (deathday != 'No data') {
      deathdayFormatted = DateFormat("yyyy-MM-dd").parse(deathday);
    }

    final DateTime now = DateTime.now();
    late int age;

    if (deathdayFormatted != null) {
      age = deathdayFormatted.year - birthdayFormatted.year;
      if (deathdayFormatted.month < birthdayFormatted.month ||
          (deathdayFormatted.month == birthdayFormatted.month &&
              deathdayFormatted.day < birthdayFormatted.day)) {
        age--;
      }
    } else {
      age = now.year - birthdayFormatted.year;
      if (now.month < birthdayFormatted.month ||
          (now.month == birthdayFormatted.month &&
              now.day < birthdayFormatted.day)) {
        age--;
      }
    }

    return age;
  }

  String calculateMovieLength({
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

  String showBigNumer({
    required int number,
  }) {
    final String result = number.toString();
    if (result.length <= 3) {
      return '$result \$';
    }

    int separatorPosition = result.length % 3;
    if (separatorPosition == 0) {
      separatorPosition = 3;
    }

    String formattedNumber = result.substring(0, separatorPosition);
    for (int i = separatorPosition; i < result.length; i += 3) {
      // ignore: use_string_buffers
      formattedNumber += ' ${result.substring(i, i + 3)}';
    }

    return '$formattedNumber \$';
  }
}
